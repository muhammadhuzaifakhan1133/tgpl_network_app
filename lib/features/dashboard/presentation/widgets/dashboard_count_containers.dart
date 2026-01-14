import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class DashboardCountContainers extends StatelessWidget {
  const DashboardCountContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _DashboardCountContainer(
                icon: AppImages.inProcessIconSvg,
                color1: AppColors.inProcessCountColor,
                color2: AppColors.inProcessCountDarkColor,
                title: "In Process",
                count: 124,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _DashboardCountContainer(
                icon: AppImages.inauguratedIconSvg,
                color1: AppColors.inauguratedCountColor,
                color2: AppColors.inauguratedCountDarkColor,
                title: "Inaugurated",
                count: 89,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _DashboardCountContainer(
                icon: AppImages.rejectedIconSvg,
                color1: AppColors.rejectedCountColor,
                color2: AppColors.rejectedCountDarkColor,
                title: "Rejected",
                count: 15,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _DashboardCountContainer(
                icon: AppImages.totalActiveIconSvg,
                color1: AppColors.nextStep1Color,
                color2: AppColors.headerDarkBlueColor,
                title: "Total Active",
                count: 228,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DashboardCountContainer extends StatelessWidget {
  final Color color1;
  final Color color2;
  final String icon;
  final String title;
  final int count;
  const _DashboardCountContainer({
    required this.color1,
    required this.color2,
    required this.icon,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115.5,
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color1, color2],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(child: SvgPicture.asset(icon)),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  count.toString(),
                  style: AppTextstyles.googleInter700black28.copyWith(
                    fontSize: 32,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  title,
                  style: AppTextstyles.googleInter500LabelColor14.copyWith(
                    fontSize: 13,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
