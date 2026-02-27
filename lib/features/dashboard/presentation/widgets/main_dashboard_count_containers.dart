import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/dashboard_count_container.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/features/dashboard/presentation/dashboard_controller.dart';

class MainDashboardCountContainers extends ConsumerWidget {
  const MainDashboardCountContainers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardData = ref.watch(dashboardAsyncControllerProvider).value;
    if (dashboardData == null) {
      return SizedBox.shrink();
    }
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DashboardCountContainer(
                iconPath: AppImages.inProcessIconSvg,
                color1: AppColors.nextStep1Color,
                color2: AppColors.headerDarkBlueColor,
                title: "In Process",
                count: dashboardData.counts.inProcess,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: DashboardCountContainer(
                iconPath: AppImages.inauguratedIconSvg,
                color1: AppColors.inauguratedCountColor,
                color2: AppColors.inauguratedCountDarkColor,
                title: "Inaugurated",
                count: dashboardData.counts.inaugurated,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: DashboardCountContainer(
                iconPath: AppImages.rejectedIconSvg,
                color1: AppColors.rejectedCountColor,
                color2: AppColors.rejectedCountDarkColor,
                title: "Rejected",
                count: dashboardData.counts.rejected,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: DashboardCountContainer(
                iconPath: AppImages.holdIconSvg,
                color1: AppColors.inProcessCountColor,
                color2: AppColors.inProcessCountDarkColor,
                title: "Hold",
                count: dashboardData.counts.hold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
