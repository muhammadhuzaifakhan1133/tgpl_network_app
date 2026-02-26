import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class DashboardCountContainer extends StatelessWidget {
  final Color color1;
  final Color color2;
  final String iconPath;
  final IconData? iconData;
  final String title;
  final int count;
  const DashboardCountContainer({
    required this.color1,
    required this.color2,
    required this.title,
    required this.count,
    this.iconPath = "",
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    assert(
      iconPath.isNotEmpty || iconData != null,
      "Either iconPath or iconData must be provided",
    );
    return Container(
      height: 115.5.h,
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color1, color2],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: iconData != null
                    ? Icon(iconData, size: 25.w, color: AppColors.white)
                    : SvgPicture.asset(
                        iconPath,
                        width: 25.w,
                        height: 25.h,
                        color: AppColors.white,
                      ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  count.toString(),
                  style: AppTextstyles.googleInter700black28.copyWith(
                    fontSize: 32.sp,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  title,
                  style: AppTextstyles.googleInter500LabelColor14.copyWith(
                    fontSize: 13.sp,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}