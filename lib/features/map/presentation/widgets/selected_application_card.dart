import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';
import 'package:tgpl_network/utils/map_utils.dart';

class SelectedApplicationCard extends ConsumerWidget {
  final ApplicationModel application;
  const SelectedApplicationCard({super.key, required this.application});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${application.entryCode} ${application.proposedSiteName1 != null ? '(${application.proposedSiteName1})' : ''}",
                style: AppTextstyles.googleInter400Grey14.copyWith(
                  fontSize: 12.sp,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 5.h,
                  horizontal: 15.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  color: AppColors.getPriorityColor(
                    application.priority ?? '',
                  ).withOpacity(0.08),
                ),
                child: Text(
                  application.priority ?? '',
                  style: AppTextstyles.googleInter500LabelColor14.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.getPriorityColor(
                      application.priority ?? '',
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            application.applicantName ?? "N/A",
            style: AppTextstyles.googleInter700black28.copyWith(
              fontSize: 20.sp,
              color: AppColors.black2Color,
            ),
          ),
          Row(
            children: [
              const Icon(Icons.location_on_outlined),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  application.siteAddress ?? "N/A",
                  style: AppTextstyles.googleInter400Grey14,
                ),
              ),
            ],
          ),
          SizedBox(height: 13.h),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    MapUtils.openGoogleMap(
                      application.latitude,
                      application.longitude,
                    );
                  },
                  text: "Directions",
                  leftPadding: 0,
                  rightPadding: 0,
                  height: 41,
                  backgroundColor: AppColors.actionContainerColor,
                  textStyle: AppTextstyles.googleInter500LabelColor14.copyWith(
                    color: AppColors.black2Color,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    ref
                        .read(goRouterProvider)
                        .push(
                          AppRoutes.applicationDetail(
                            application.applicationId?.toString() ?? '',
                          ),
                        );
                  },
                  text: "View Details",
                  leftPadding: 0,
                  rightPadding: 0,
                  height: 41,
                  backgroundColor: AppColors.nextStep1Color,
                  textStyle: AppTextstyles.googleInter500LabelColor14.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
