import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';

Color getApplicationStatusColor(int statusId) {
  switch (statusId) {
    case 1:
      return AppColors.nextStep1Color;
    case 2:
      return AppColors.nextStep2Color;
    case 3:
      return AppColors.nextStep3Color;
    default:
      return AppColors.emailUsIconColor;
  }
}
