import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class WelcomeCard extends StatelessWidget {
  final String iconPath;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Function() onTap;
  const WelcomeCard({
    super.key,
    required this.iconPath,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.4.r)),
      shadowColor: AppColors.black.withOpacity(0.6),
      color: AppColors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Row(
            children: [
              Container(
                width: 48.h,
                height: 48.h,
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(child: SvgPicture.asset(iconPath)),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextstyles.googleInter700black28.copyWith(
                        fontSize: 15.sp,
                      ),
                    ),
                    // SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: AppTextstyles.googleInter400black16.copyWith(
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 14.w),
                height: 32.h,
                width: 33.w,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16.w,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
