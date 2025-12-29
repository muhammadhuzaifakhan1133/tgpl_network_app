import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/utils/screen_size_extension.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Widget? child;
  final double height;
  final double topPadding;
  final double bottomPadding;
  final double rightPadding;
  final double leftPadding;
  final Color backgroundColor;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.child,
    this.height = 55,
    this.topPadding = 10,
    this.bottomPadding = 10,
    this.rightPadding = 50,
    this.leftPadding = 50,
    this.backgroundColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.only(
          top: topPadding,
          bottom: bottomPadding,
          right: rightPadding,
          left: leftPadding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        fixedSize: Size(context.screenWidth * 0.75, height),
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
