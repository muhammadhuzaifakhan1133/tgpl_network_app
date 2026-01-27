import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  int seconds = 2,
  Color? bgColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: seconds),
      backgroundColor: bgColor,
    ),
  );
}
