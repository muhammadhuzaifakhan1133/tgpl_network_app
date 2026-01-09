  import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';

Color getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return AppColors.emailUsIconColor;
      case "Medium":
        return AppColors.nextStep3Color;
      case "Low":
        return AppColors.nextStep2Color;
      default:
        return AppColors.inactiveStatusColor;
    }
  }