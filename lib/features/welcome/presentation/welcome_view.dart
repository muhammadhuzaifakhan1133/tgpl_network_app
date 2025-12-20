import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 100),
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
                iconColor: AppColors.skyBlue,
                title: "Apply for New Station",
                subtitle: "Submit application without login",
              ),
              const SizedBox(height: 25),
              WelcomeCard(
                iconPath: AppImages.redLocationIconSvg,
                iconColor: AppColors.lightRed,
                title: "I am an Employee",
                subtitle: "Login to TGPL Field Operations",
              ),
              // WelcomeContainer,
              // const SizedBox(height: 28),
              // WelcomeContainer,
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeCard extends StatelessWidget {
  final String iconPath;
  final Color iconColor;
  final String title;
  final String subtitle;
  const WelcomeCard({
    super.key,
    required this.iconPath,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(child: SvgPicture.asset(iconPath)),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextstyles.googleInter700black28.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppTextstyles.googleInter400black16.copyWith(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 8),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
