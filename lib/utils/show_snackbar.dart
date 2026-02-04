import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  String message, {
  int seconds = 2,
  Color? bgColor,
}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: Duration(seconds: seconds),
    backgroundColor: bgColor,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
