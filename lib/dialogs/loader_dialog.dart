import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';

Future<dynamic> showLoader(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      );
    },
  );
}
