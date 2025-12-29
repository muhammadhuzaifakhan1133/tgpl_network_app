import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/profile/presentation/widgets/account_setting_and_support_card.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Support", style: AppTextstyles.neutra700black224),
        const SizedBox(height: 14),
        AccountSettingAndSupportCard(
          title: "Help Center",
          icon: AppImages.lockIconSvg,
          color: AppColors.nextStep1Color,
          onTap: () {},
        ),
        const SizedBox(height: 14),
        AccountSettingAndSupportCard(
          title: "Logout",
          icon: AppImages.logoutIconSvg,
          color: AppColors.emailUsIconColor,
          colorTitle: true,
          onTap: () {},
        ),
      ],
    );
  }
}
