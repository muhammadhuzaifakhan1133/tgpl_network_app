import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/utils/extensions/screen_size_extension.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final TextStyle? textStyle;
  final Widget? child;
  final double height;
  final double? width;
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
    this.width,
    this.height = 55,
    this.topPadding = 10,
    this.bottomPadding = 10,
    this.rightPadding = 50,
    this.leftPadding = 50,
    this.backgroundColor = AppColors.primary,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.only(
          top: topPadding.h,
          bottom: bottomPadding.h,
          right: rightPadding.w,
          left: leftPadding.w,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        fixedSize: Size(width?.w ?? context.screenWidth * 0.75, height.h),
      ),
      child:
          child ??
          Text(
            text,
            textAlign: TextAlign.center,
            style: textStyle ?? AppTextstyles.neutra500white22,
          ),
    );
  }
}
