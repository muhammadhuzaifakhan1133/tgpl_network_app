import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';

class AuditDashboardActionsSection extends ConsumerWidget {
  const AuditDashboardActionsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Actions",
          style: AppTextstyles.googleInter700black28.copyWith(fontSize: 18.sp),
        ),
        SizedBox(height: 12.h),
        _buildActionItem(
          icon: Icons.assignment_turned_in_outlined,
          label: "Perform an inspection",
          onTap: () {
            ref.read(goRouterProvider).push(AppRoutes.auditTemplateSelection);
          },
        ),
        SizedBox(height: 12.h),
        _buildActionItem(
          icon: Icons.description_outlined,
          label: "View inspection reports",
          onTap: () {
            // Handle view reports action
          },
        ),
        SizedBox(height: 12.h),
        _buildActionItem(
          icon: Icons.build_outlined,
          label: "View site actions",
          onTap: () {
            // Handle view site actions
          },
        ),
      ],
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(icon, size: 22.w, color: AppColors.primary),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: AppTextstyles.googleInter500LabelColor14.copyWith(
                  color: AppColors.black,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16.w, color: AppColors.black),
          ],
        ),
      ),
    );
  }
}
