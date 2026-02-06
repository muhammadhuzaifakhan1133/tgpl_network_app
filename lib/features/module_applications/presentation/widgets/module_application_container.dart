import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/common/providers/user_provider.dart';
// import 'package:tgpl_network/common/models/application_model.dart';
import 'package:tgpl_network/common/widgets/action_container.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/module_applications/presentation/widgets/document_bottom_sheet.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';
import 'package:tgpl_network/utils/extensions/datetime_extension.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';
import 'package:tgpl_network/utils/map_utils.dart';

class ModuleApplicationContainer extends ConsumerWidget {
  final ApplicationModel application;
  final String submoduleName;
  const ModuleApplicationContainer({
    super.key,
    required this.application,
    required this.submoduleName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).requireValue!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 8.h),
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.4.r),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                application.entryCode ?? '',
                style: AppTextstyles.googleInter400Grey14,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 8.w),
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
          SizedBox(height: 5.h),
          Text(
            "${application.dealerName}${application.proposedSiteName1 == null ? '' : ' | ${application.proposedSiteName1}'}",
            style: AppTextstyles.googleInter700black28.copyWith(
              fontSize: 20.sp,
              color: AppColors.black2Color,
            ),
          ),
          if (!application.sourceName.isNullOrEmpty)
            Text(
              application.sourceName ?? '',
              style: AppTextstyles.googleInter400Grey14,
            ),
          SizedBox(height: 8.h),
          Divider(color: AppColors.lightGrey),
          SizedBox(height: 6.75.h),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.phoneIconSvg,
                      color: AppColors.subHeadingColor,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        application.dealerContact ?? '',
                        style: AppTextstyles.googleInter400Grey14.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.locationIconSvg,
                      color: AppColors.subHeadingColor,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        application.cityName ?? '',
                        style: AppTextstyles.googleInter400Grey14.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 6.75.h),
          Divider(color: AppColors.lightGrey),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Received: ${application.addDate?.formatTodMMMyyyy() ?? 'N/A'}",
                  style: AppTextstyles.googleInter400LightGrey12,
                ),
              ),
              actionContainer(
                icon: AppImages.locationIconSvg,
                onTap: () {
                  MapUtils.openGoogleMap(
                    application.latitude,
                    application.longitude,
                  );
                },
              ),
              SizedBox(width: 8.w),
              actionContainer(
                icon: AppImages.eyeIconSvg,
                onTap: () {
                  // send section to the detail view
                  ref
                      .read(goRouterProvider)
                      .push(
                        AppRoutes.applicationDetail(
                          application.applicationId?.toString() ?? '',
                        ),
                      );
                },
              ),
              if (submoduleName == "Survey & Dealer Profile" &&
                  user.hasSurveyFormAccess) ...[
                SizedBox(width: 8.w),
                actionContainer(
                  icon: AppImages.formIconSvg,
                  onTap: () {
                    ref
                        .read(goRouterProvider)
                        .push(
                          AppRoutes.surveyForm(
                            application.applicationId?.toString() ?? '',
                          ),
                        );
                  },
                ),
              ],
              if (submoduleName == "Traffic & Trade" &&
                  user.hasTrafficTradeFormAccess) ...[
                SizedBox(width: 8.w),
                actionContainer(
                  icon: AppImages.formIconSvg,
                  onTap: () {
                    ref
                        .read(goRouterProvider)
                        .push(
                          AppRoutes.trafficTradeForm(
                            application.applicationId?.toString() ?? '',
                          ),
                        );
                  },
                ),
              ],
              SizedBox(width: 8.w),
              actionContainer(
                icon: AppImages.uploadIconSvg,
                onTap: () {
                  documentBottomSheet(
                    context: context,
                    application: application,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
