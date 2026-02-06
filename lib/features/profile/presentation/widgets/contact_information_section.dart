import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/master_data/models/user_model.dart';

class ContactInformationSection extends StatelessWidget {
  final UserModel user;
  const ContactInformationSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Contact Information", style: AppTextstyles.neutra700black224),
        SizedBox(height: 14.h),
        _ContactInfoCard(
          color: AppColors.nextStep2Color,
          icon: AppImages.emailIconSvg,
          title: "Email",
          value: user.email,
        ),
        SizedBox(height: 14.h),
        _ContactInfoCard(
          color: AppColors.nextStep3Color,
          icon: AppImages.phoneIconSvg,
          title: "Phone",
          value: user.contact,
        ),
        // TODO: add region info in user model
        // SizedBox(height: 14.h),
        // _ContactInfoCard(
        //   color: AppColors.emailUsIconColor,
        //   icon: AppImages.locationIconSvg,
        //   title: "Region",
        //   value: "Karachi Region",
        // ),
      ],
    );
  }
}

class _ContactInfoCard extends StatelessWidget {
  final Color color;
  final String icon;
  final String title;
  final String value;
  const _ContactInfoCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextstyles.googleInter500LabelColor14.copyWith(
                  fontSize: 15.sp,
                  color: AppColors.black2Color,
                ),
              ),
              Text(
                value,
                style: AppTextstyles.googleInter400Grey14.copyWith(
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
