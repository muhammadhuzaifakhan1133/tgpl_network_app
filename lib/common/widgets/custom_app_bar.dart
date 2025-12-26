import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBackButton;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: Row(
        children: [
          if (showBackButton)
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: AppColors.actionContainerColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.subHeadingColor,
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
                  title,
                  style: AppTextstyles.googleInter700black28.copyWith(
                    fontSize: 20,
                    color: AppColors.black2Color,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTextstyles.googleInter400Grey14.copyWith(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.actionContainerColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Icon(Icons.search, color: AppColors.subHeadingColor),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.actionContainerColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Icon(
                Icons.filter_alt_outlined,
                color: AppColors.subHeadingColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
