import 'package:e_com/auth/display_error_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final emailController = TextEditingController();
  void passwordReset() async {
    //You have to pass BuildContext to passwordReset
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      displayMessage("Password reset link has sent.\nClick on the link to reset and login again.", context);
    } on FirebaseAuthException catch (e) {
      displayMessage(e.message.toString(), context);
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
            child: Padding(padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Enter the Email to reset the password",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                    ),),
                  const SizedBox(height: 30,),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        label: const Text('Email'),
                        prefixIcon: const Icon(Icons.mail),
                    ),
                    controller: emailController,
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(onPressed: passwordReset,
                      child: const Text("Reset"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
