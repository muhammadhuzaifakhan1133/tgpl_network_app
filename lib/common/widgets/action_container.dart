import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/constants/app_colors.dart';

Widget actionContainer({
  required String icon,
  required void Function()? onTap,
  Color iconColor = AppColors.subHeadingColor,
  Color backgroundColor = AppColors.actionContainerColor,
  double leftMargin = 8,
  double rightMargin = 0,
  double topMargin = 0,
  double bottomMargin = 0,
  double padding = 8,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(padding.w),
      margin: EdgeInsets.only(left: leftMargin.w, right: rightMargin.w, top: topMargin.h, bottom: bottomMargin.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: SvgPicture.asset(icon, color: iconColor),
    ),
  );
}
