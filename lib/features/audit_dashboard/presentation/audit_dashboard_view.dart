import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/audit_dashboard/presentation/widgets/audit_dashboard_actions_section.dart';
import 'package:tgpl_network/features/audit_dashboard/presentation/widgets/audit_dashboard_count_containers.dart';

class AuditDashboardView extends StatelessWidget {
  const AuditDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.window_sharp, size: 25.w, color: AppColors.primary),
                SizedBox(width: 8.w),
                Text(
                  "Audit Dashboard",
                  style: AppTextstyles.googleInter700black28.copyWith(fontSize: 22.sp),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            AuditDashboardCountContainers(),
            SizedBox(height: 20.h),
            AuditDashboardActionsSection(),
            SizedBox(height: 20.h),
            AuditDashboardDraftAuditsSection(),
          ],
        ),
      ),
    );
  }
}

class AuditDashboardDraftAuditsSection extends StatelessWidget {
  const AuditDashboardDraftAuditsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Draft Audits",
          style: AppTextstyles.googleInter700black28.copyWith(fontSize: 18.sp),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 180.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              return _draftInspectionContainer(index);
            },
          ),
        ),
      ],
    );
  }

  Container _draftInspectionContainer(int index) {
    return Container(
              width: 270.w,
              padding: EdgeInsets.all(16.w),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.description_outlined, size: 14.w, color: AppColors.primary),
                      SizedBox(width: 8.w),
                      Text("INSPECTION", style: AppTextstyles.googleInter500LabelColor14.copyWith(
                        color: AppColors.primary,
                        fontSize: 12.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "T-140 / Hyderabad / Tariq Ahmed / 20 May 2024",
                    style: AppTextstyles.googleInter700black28.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Customer Experience Review",
                    style: AppTextstyles.googleInter400Grey14.copyWith(fontSize: 14.sp),
                  ),
                  // last modify ago along with icon
                  SizedBox(height: 8.h),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.access_time_filled_outlined, size: 14.w, color: AppColors.grey),
                        SizedBox(width: 4.w),
                        Text("Last modified 2 hours ago", style: AppTextstyles.googleInter400Grey14.copyWith(fontSize: 12.sp)),
                      ],
                    ),
                  ),
                ],
              ),
            );
  }
}