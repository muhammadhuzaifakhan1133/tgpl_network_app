import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class DashboardGreetingText extends StatelessWidget {
  const DashboardGreetingText({super.key});

  String getGreeting() {
    DateTime now = DateTime.now();
    String greeting = "";
    int hours = now.hour;

    if (hours >= 1 && hours <= 12) {
      greeting = "Good Morning";
    } else if (hours >= 12 && hours <= 16) {
      greeting = "Good Afternoon";
    } else {
      greeting = "Good Evening";
    }
    return greeting;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${getGreeting()} 👋",
              style: AppTextstyles.neutra700black32.copyWith(
                color: AppColors.black2Color,
                fontSize: 28.sp,
              ),
            ),
            Text(
              "Here's what's happening with your operations today",
              style: AppTextstyles.neutra500grey12.copyWith(fontSize: 16.sp),
            ),
          ],
        ),
      ],
    );
  }
}
