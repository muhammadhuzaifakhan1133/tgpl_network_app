import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/dashboard_count_container.dart';
import 'package:tgpl_network/constants/app_colors.dart';

class AuditDashboardCountContainers extends StatelessWidget {
  const AuditDashboardCountContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DashboardCountContainer(
                iconData: Icons.assignment, // Replace with appropriate icon
                color1: AppColors.nextStep1Color,
                color2: AppColors.headerDarkBlueColor,
                title: "Total Audits",
                count: 5,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: DashboardCountContainer(
                iconData: Icons.edit_document, // Replace with appropriate icon
                color1: AppColors.inProcessCountColor,
                color2: AppColors.inProcessCountDarkColor,
                title: "Draft Audits",
                count: 3,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: DashboardCountContainer(
                iconData: Icons.pending_actions,
                color1: AppColors.offlineStatusColor,
                color2: AppColors.offlineStatusColor.withOpacity(0.8),
                title: "Pending Sync",
                count: 2,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: DashboardCountContainer(
                iconData: Icons.check_circle, // Replace with appropriate icon
                color1: AppColors.inauguratedCountColor,
                color2: AppColors.inauguratedCountDarkColor,
                title: "Completed",
                count: 4,
              ),
            ),
          ],
        ),
      ],
    );
  }
}