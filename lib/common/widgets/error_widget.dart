import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

Widget errorWidget(String message, [String? details]) {
    return Center(
      child: Text(
        "Error: $message${details != null ? "\nDetails: $details" : ""}",
        style: AppTextstyles.googleInter400Grey14,
      ),
    );
  }