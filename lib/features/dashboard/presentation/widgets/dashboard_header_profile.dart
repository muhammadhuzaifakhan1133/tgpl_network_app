import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class DashboardHeaderProfile extends StatelessWidget {
  const DashboardHeaderProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.nextStep1Color,
                AppColors.headerDarkBlueColor,
              ],
            ),
          ),
          child: Center(
            child: Text(
              "A",
              style: AppTextstyles.googleInter700black28.copyWith(
                fontSize: 20,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ahmed Hassan",
                style: AppTextstyles.googleInter700black28.copyWith(
                  fontSize: 20,
                  color: AppColors.black2Color,
                ),
              ),
              Text(
                "Regional Manager",
                style: AppTextstyles.googleInter400Grey14.copyWith(
                  fontSize: 16,
                  color: AppColors.black2Color,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.4),
            color: AppColors.actionContainerColor,
          ),
          child: Center(child: SvgPicture.asset(AppImages.searchIconSvg)),
        ),
        const SizedBox(width: 8),
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.4),
            color: AppColors.actionContainerColor,
          ),
          child: Center(child: SvgPicture.asset(AppImages.notificationIconSvg)),
        ),
      ],
    );
  }
}
