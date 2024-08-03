import 'package:e_com/Authentication/loginPage.dart';
import 'package:e_com/auth/display_error_message.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();

  bool passwordConfirm() {
    if (passwordController.text.trim() ==
        confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  //resister Method
  void register() async {
    //show loading circle
    showDialog(context: context, builder: (context)=> const Center(child: CircularProgressIndicator(),));
    if (!passwordConfirm()) {
      Navigator.pop(context);
      displayMessage('Password dont match', context);
    }else {try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        Navigator.pop(context);
        displayMessage("New User Created", context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
                displayMessage(e.message.toString(), context);
      }
    }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'New Users Register here',
                        style: TextStyle(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w800,
                          fontSize: 50,),
                      ),
                      const SizedBox(height: 30,),

                      //email TextField
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            label: const Text('Email'),
                            prefixIcon: const Icon(Icons.mail)
                        ),
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      //password Controller
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            label: const Text('Password'),
                            prefixIcon: const Icon(Icons.lock)
                        ),
                        controller: passwordController,
                      ),
                      const SizedBox(height: 20,),

                      //confirmPassword Textfield
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            label: const Text('Confirm Password'),
                            prefixIcon: const Icon(Icons.lock)
                        ),
                        controller: confirmpasswordController,
                      ),
                      const SizedBox(height: 30,),

                      //Register Button
                      ElevatedButton(onPressed: register, child: const Text('Register')),
                      const SizedBox(height: 20,),

                      //login Gestures
                      Row(
                        children: [
                          const Text("I'm a member ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18
                            ),),
                          GestureDetector(
                            onTap: widget.onTap,
                            //     (){
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (context) => LoginPage()),
                            //   );
                            // },
                            child:
                            const Text('Login',
                              style: TextStyle(
                                color: Colors.lightBlue,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
