import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class DashboardRegionalManagerCard extends StatelessWidget {
  final String region;
  final int count;
  const DashboardRegionalManagerCard({
    super.key,
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
                AppImages.redLocationIconSvg,
                color: AppColors.nextStep1Color,
              ),
            ),
          ),
          SizedBox(width: 12),
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
