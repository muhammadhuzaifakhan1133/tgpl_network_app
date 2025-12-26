import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class ApplicationsView extends StatelessWidget {
  const ApplicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          title: "Applications",
          subtitle: "Process status tracking",
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.4),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "APP-2025-001",
                      style: AppTextstyles.googleInter400LightGrey12.copyWith(
                        color: AppColors.subHeadingColor,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.emailUsIconColor.withOpacity(0.082),
                    ),
                    child: Center(
                      child: Text(
                        "High",
                        style: AppTextstyles.googleInter400LightGrey12.copyWith(
                          color: AppColors.emailUsIconColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
