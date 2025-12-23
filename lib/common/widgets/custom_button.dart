import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/utils/screen_size_extension.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Widget? child;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        fixedSize: Size(context.screenWidth * 0.75, 55),
      ),
      child:
          child ??
          Text(
            text,
            textAlign: TextAlign.center,
            style: AppTextstyles.neutra500white22,
          ),
    );
  }
}
