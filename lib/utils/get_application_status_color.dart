import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';

Color getApplicationStatusColor(int statusId) {
  switch (statusId) {
    // In Process
    case < 13:
      return AppColors.nextStep1Color;
    // inaugurated
    case 13:
      return AppColors.nextStep2Color;
    // hold
    case 15:
    case 16:
      return AppColors.nextStep3Color;
    // rejected
    case 14:
    case 17:
      return AppColors.emailUsIconColor;
    default:
      return AppColors.grey;
  }
}
