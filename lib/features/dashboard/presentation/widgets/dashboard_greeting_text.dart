import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/utils/get_greeting.dart';

class DashboardGreetingText extends StatelessWidget {
  const DashboardGreetingText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${getGreeting()} 👋",
          style: AppTextstyles.neutra700black32.copyWith(
            color: AppColors.black2Color,
            fontSize: 28,
          ),
        ),
        Text(
          "Here's what's happening with your operations today",
          style: AppTextstyles.neutra500grey12.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
