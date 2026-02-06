import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class AccountSettingAndSupportCard extends StatelessWidget {
  final Color color;
  final String icon;
  final String title;
  final bool colorTitle;
  final void Function() onTap;
  const AccountSettingAndSupportCard({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    this.colorTitle = false, 
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.4.r),
                color: color.withOpacity(0.082),
              ),
              child: Center(child: SvgPicture.asset(icon, color: color)),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: AppTextstyles.googleInter500LabelColor14.copyWith(
                  fontSize: 15.sp,
                  color: colorTitle ? color : AppColors.black2Color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
