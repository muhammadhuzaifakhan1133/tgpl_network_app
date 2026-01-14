import 'package:flutter/material.dart';
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
          style: AppTextstyles.neutra700black32.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 5),
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
      height: 57,
      margin: EdgeInsets.only(bottom: 14),
      width: double.infinity,
      padding: EdgeInsets.only(top: 7.5, bottom: 7.5, left: 8, right: 15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.nextStep1Color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.4),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppImages.locationIconSvg,
                color: AppColors.nextStep1Color,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  region,
                  style: AppTextstyles.googleInter500LabelColor14.copyWith(
                    fontSize: 15,
                  ),
                ),
                Text(
                  "In Process",
                  style: AppTextstyles.googleInter400Grey14.copyWith(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Text(
            count.toString(),
            style: AppTextstyles.googleInter700black28.copyWith(fontSize: 22),
          ),
        ],
      ),
    );
  }
}
