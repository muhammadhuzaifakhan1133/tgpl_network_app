import 'package:flutter/material.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/features/dashboard/presentation/widgets/dashboard_count_container.dart';

class AllDashboardCountContainers extends StatelessWidget {
  const AllDashboardCountContainers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DashboardCountContainer(
                icon: AppImages.inProcessIconSvg,
                color1: AppColors.inProcessCountColor,
                color2: AppColors.inProcessCountDarkColor,
                title: "In Process",
                count: 124,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: DashboardCountContainer(
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
          child: DashboardCountContainer(
            icon: AppImages.rejectedIconSvg,
            color1: AppColors.rejectedCountColor,
            color2: AppColors.rejectedCountDarkColor,
            title: "Rejected",
            count: 15,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: DashboardCountContainer(
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
