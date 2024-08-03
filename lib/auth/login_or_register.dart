import 'package:e_com/Authentication/loginPage.dart';
import 'package:e_com/Authentication/registerPage.dart';
import 'package:flutter/material.dart';
 class LoginOrRegister extends StatefulWidget {
   const LoginOrRegister({super.key});

   @override
   State<LoginOrRegister> createState() => _LoginOrRegisterState();
 }

 class _LoginOrRegisterState extends State<LoginOrRegister> {
   //initialised the login page
   bool showLoginPage = true;

   //switch between login and register
   void togglePages(){
     setState(() {
       showLoginPage =!showLoginPage;
     });
   }

   @override
   Widget build(BuildContext context) {
     if (showLoginPage){
       return LoginPage(onTap: togglePages);
     }else {
       return RegisterPage(onTap: togglePages);
     }
   }
 }
