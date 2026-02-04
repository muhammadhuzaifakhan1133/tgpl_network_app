import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class NextStepOrHelpContainer extends StatelessWidget {
  final String? step;
  final String? icon;
  final Color color;
  final String title;
  final String subtitle;
  const NextStepOrHelpContainer({
    super.key,
    this.step,
    this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.4.r)),
      shadowColor: AppColors.black.withOpacity(0.5),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.5.h, horizontal: 8.w),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: color.withOpacity(0.082),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: step != null
                    ? Text(
                        step!,
                        style: AppTextstyles.googleInter700black28.copyWith(
                          fontSize: 18.sp,
                          color: color,
                        ),
                      )
                    : SvgPicture.asset(icon!, color: color),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextstyles.googleInter700black28.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.black2Color,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: AppTextstyles.googleInter400Grey14.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
