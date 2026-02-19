import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';

class RegionalManagersSection extends StatelessWidget {
  const RegionalManagersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Regional Managers",
          style: AppTextstyles.neutra700black32.copyWith(fontSize: 24.sp),
        ),
        SizedBox(height: 5.h),
        _DashboardRegionalManagerCard(region: "Karachi Region", count: 52),
        _DashboardRegionalManagerCard(region: "Lahore Region", count: 34),
        _DashboardRegionalManagerCard(region: "Hyderabad Region", count: 28),
        _DashboardRegionalManagerCard(region: "Sukkur Region", count: 10),
      ],
    );
  }
}

class _DashboardRegionalManagerCard extends StatelessWidget {
  final String region;
  final int count;
  const _DashboardRegionalManagerCard({
    required this.region,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57.h,
      margin: EdgeInsets.only(bottom: 14.h),
      width: double.infinity,
      padding: EdgeInsets.only(top: 7.5.h, bottom: 7.5.h, left: 8.w, right: 15.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.nextStep1Color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.4.r),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppImages.locationIconSvg,
                color: AppColors.nextStep1Color,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  region,
                  style: AppTextstyles.googleInter500LabelColor14.copyWith(
                    fontSize: 15.sp,
                  ),
                ),
                Text(
                  "In Process",
                  style: AppTextstyles.googleInter400Grey14.copyWith(
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          Text(
            count.toString(),
            style: AppTextstyles.googleInter700black28.copyWith(fontSize: 22.sp),
          ),
        ],
      ),
    );
  }
}
