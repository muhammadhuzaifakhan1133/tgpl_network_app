import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';


Color getApplicationCategoryColor(String category) {
  switch (category) {
    case "New Plot":
      return AppColors.inauguratedCountDarkColor;
    case "Conversion":
      return AppColors.inProcessCountDarkColor;
    case "CNG":
      return AppColors.emailUsIconColor;
    default:
      return AppColors.subHeadingColor;
  }
}