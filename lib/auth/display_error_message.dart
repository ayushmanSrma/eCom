import 'package:flutter/material.dart';

void displayMessage(String message, BuildContext context){
  showDialog(context: context, builder: (context)=>AlertDialog(
    content: Text(message,
      style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    ),
  ));
}