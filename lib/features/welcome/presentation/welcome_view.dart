import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/welcome/presentation/widgets/welcome_card.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';

class WelcomeView extends ConsumerWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 120.5.h),
              SvgPicture.asset(AppImages.tajLogoSvg, width: 46.w, height: 45.h),
              SizedBox(height: 28.h),
              Text(
                "Welcome to TGPL",
                style: AppTextstyles.googleInter700black28,
              ),
              SizedBox(height: 5.h),
              Text(
                "Please choose how you want to continue",
                style: AppTextstyles.googleInter400black16,
              ),
              SizedBox(height: 40.h),
              WelcomeCard(
                iconPath: AppImages.applyNewStationIconSvg,
                iconColor: AppColors.applyNewStationIconColor,
                title: "Apply for New Station",
                subtitle: "Submit application without login",
                onTap: () {
                  ref.read(goRouterProvider).push(AppRoutes.stationForm);
                },
              ),
              SizedBox(height: 24.h),
              WelcomeCard(
                iconPath: AppImages.locationIconSvg,
                iconColor: AppColors.redLocationIconColor,
                title: "I am an Employee",
                subtitle: "Login to TGPL Field Operations",
                onTap: () {
                  ref.read(goRouterProvider).push(AppRoutes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
