import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/welcome/presentation/widgets/welcome_card.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';
import 'package:tgpl_network/utils/extensions/screen_size_extension.dart';

class WelcomeView extends ConsumerWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: context.screenHeight * 0.15),
              SvgPicture.asset(AppImages.tajLogoSvg, width: 50, height: 50),
              const SizedBox(height: 28),
              Text(
                "Welcome to TGPL",
                style: AppTextstyles.googleInter700black28,
              ),
              const SizedBox(height: 10),
              Text(
                "Please choose how you want to continue",
                style: AppTextstyles.googleInter400black16,
              ),
              const SizedBox(height: 28),
              WelcomeCard(
                iconPath: AppImages.applyNewStationIconSvg,
                iconColor: AppColors.applyNewStationIconColor,
                title: "Apply for New Station",
                subtitle: "Submit application without login",
                onTap: () {
                  ref.read(goRouterProvider).push(AppRoutes.stationForm);
                },
              ),
              const SizedBox(height: 25),
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
