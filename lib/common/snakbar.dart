import 'package:flutter/material.dart';

showSnakBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor:const Color.fromARGB(255, 210, 7, 255),
    duration:const Duration(seconds: 2),
    content: Text(text),
    // action: SnackBarAction(label: "close", onPressed:(){}),
  ));
}
