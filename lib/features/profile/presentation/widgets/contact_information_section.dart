import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class ContactInformationSection extends StatelessWidget {
  const ContactInformationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Contact Information", style: AppTextstyles.neutra700black224),
        const SizedBox(height: 14),
        _ContactInfoCard(
          color: AppColors.nextStep2Color,
          icon: AppImages.emailIconSvg,
          title: "Email",
          value: "ahmad.hassan@tgpl.com",
        ),
        const SizedBox(height: 14),
        _ContactInfoCard(
          color: AppColors.nextStep3Color,
          icon: AppImages.phoneIconSvg,
          title: "Phone",
          value: "0321-1234567",
        ),
        const SizedBox(height: 14),
        _ContactInfoCard(
          color: AppColors.emailUsIconColor,
          icon: AppImages.locationIconSvg,
          title: "Region",
          value: "Karachi Region",
        ),
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
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.4),
              color: color.withOpacity(0.082),
            ),
            child: Center(child: SvgPicture.asset(icon, color: color)),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextstyles.googleInter500LabelColor14.copyWith(
                  fontSize: 15,
                  color: AppColors.black2Color,
                ),
              ),
              Text(
                value,
                style: AppTextstyles.googleInter400Grey14.copyWith(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
