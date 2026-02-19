import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/dashboard/presentation/dashboard_controller.dart';

class DashboardCountContainers extends ConsumerWidget {
  const DashboardCountContainers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardData = ref
        .watch(dashboardAsyncControllerProvider)
        .value;
    if (dashboardData == null) {
      return SizedBox.shrink();
    }
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _DashboardCountContainer(
                icon: AppImages.inProcessIconSvg,
                color1: AppColors.nextStep1Color,
                color2: AppColors.headerDarkBlueColor,
                title: "In Process",
                count: dashboardData.counts.inProcess,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _DashboardCountContainer(
                icon: AppImages.inauguratedIconSvg,
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
              child: _DashboardCountContainer(
                icon: AppImages.rejectedIconSvg,
                color1: AppColors.rejectedCountColor,
                color2: AppColors.rejectedCountDarkColor,
                title: "Rejected",
                count: dashboardData.counts.rejected,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _DashboardCountContainer(
                icon: AppImages.holdIconSvg,
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
      height: 115.5.h,
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
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
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16.r),
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
                    fontSize: 32.sp,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  title,
                  style: AppTextstyles.googleInter500LabelColor14.copyWith(
                    fontSize: 13.sp,
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
