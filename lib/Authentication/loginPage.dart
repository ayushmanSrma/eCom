import 'package:e_com/Authentication/ForgotPage.dart';
import 'package:e_com/Authentication/registerPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/display_error_message.dart';

class LoginPage extends StatefulWidget {

  final void Function()? onTap;

  LoginPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();


  //resister Method
  void login() async {
    showDialog(context: context, builder: (context)=> const Center(child: CircularProgressIndicator(),));
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
    }on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessage(e.message.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
          elevation: 0, centerTitle: true, backgroundColor: Colors.transparent),
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
                      //Text
                      const Text(
                        'Hi, login to ECom ',
                        style: TextStyle(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w800,
                          fontSize: 50,),
                      ),
                      const SizedBox(height: 30,),
                      //Email Textbox
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

                      //Password Textbox
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            label: const Text('Password'),
                            prefixIcon: const Icon(Icons.lock)
                        ),
                        controller: passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 15,),
                      //Text Forgot password
                      Center(
                        child: GestureDetector(
                          onTap:(){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context){
                                  return ForgotPage();
                                },
                                )
                            );
                          },
                          child: const Text('Forgot Password??',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                                fontSize: 16
                            ),),
                        ),
                      ),
                      //Login button
                      const SizedBox(height: 15,),
                      ElevatedButton(onPressed: login , child: const Text('Login')),
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          const Text('Not a member? ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18
                            ),),
                          GestureDetector(
                            onTap: widget.onTap,
                            //     (){
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (context) => const RegisterPage()),
                            //   );
                            // },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
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
