import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/applications/presentation/application_controller.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';
import 'package:tgpl_network/utils/extensions/datetime_extension.dart';
import 'package:tgpl_network/utils/map_utils.dart';

class ApplicationStatusContainer extends ConsumerWidget {
  final int index;
  final bool isExpanded;
  final ApplicationModel application;
  const ApplicationStatusContainer({
    super.key,
    required this.isExpanded,
    required this.application,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStatuses = ref.read(appStatusesProvider(index));
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.4.r),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  application.entryCode.toString(),
                  style: AppTextstyles.googleInter400LightGrey12.copyWith(
                    color: AppColors.subHeadingColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.r),
                  color: AppColors.getPriorityColor(
                    application.priority.toString(),
                  ).withOpacity(0.082),
                ),
                child: Center(
                  child: Text(
                    application.priority.toString(),
                    style: AppTextstyles.googleInter400LightGrey12.copyWith(
                      color: AppColors.getPriorityColor(
                        application.priority.toString(),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              AnimatedRotation(
                turns: isExpanded ? 0.5 : 0,
                duration: const Duration(milliseconds: 500),
                child: Icon(
                  Icons.expand_more,
                  color: AppColors.subHeadingColor,
                ),
              ),
            ],
          ),
          Text(
            application.dealerName.toString(),
            style: AppTextstyles.googleInter700black28.copyWith(fontSize: 20.sp),
          ),
          Row(
            children: [
              SvgPicture.asset(
                AppImages.locationIconSvg,
                color: AppColors.subHeadingColor,
              ),
              SizedBox(width: 5.w),
              Text(
                application.cityName.toString(),
                style: AppTextstyles.googleInter400Grey14.copyWith(
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(width: 10.w),
              SvgPicture.asset(
                AppImages.calendarIconSvg,
                color: AppColors.subHeadingColor,
              ),
              SizedBox(width: 5.w),
              Text(
                application.addDate.toString().formatTodMMMyyyy(),
                style: AppTextstyles.googleInter400Grey14.copyWith(
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              for (int i = 0; i < appStatuses.length; i++)
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 5.w),
                    decoration: BoxDecoration(
                      color: appStatuses[i].status
                          ? AppColors.nextStep2Color
                          : AppColors.inactiveStatusColor,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    height: 6,
                  ),
                ),
            ],
          ),
          SizedBox(height: 10.h),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(color: AppColors.lightGrey),
                      SizedBox(height: 2.h),
                      Text(
                        "Process Status",
                        style: AppTextstyles.googleInter600black18,
                      ),
                      for (int i = 0; i < appStatuses.length; i++)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.h),
                          child: Row(
                            children: [
                              Expanded(child: Text(appStatuses[i].title)),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.r),
                                  color: appStatuses[i].status
                                      ? AppColors.nextStep2Color.withOpacity(
                                          0.082,
                                        )
                                      : AppColors.emailUsIconColor.withOpacity(
                                          0.082,
                                        ),
                                ),
                                child: Text(
                                  appStatuses[i].status ? "Yes" : "No",
                                  style: AppTextstyles.googleInter600black18
                                      .copyWith(
                                        fontSize: 12.sp,
                                        color: appStatuses[i].status
                                            ? AppColors.nextStep2Color
                                            : AppColors.emailUsIconColor,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 2.h),
                      Divider(color: AppColors.lightGrey),
                      SizedBox(height: 5.h),
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
                              height: 41,
                              text: "",
                              topPadding: 10,
                              bottomPadding: 10,
                              rightPadding: 0,
                              leftPadding: 0,
                              backgroundColor: AppColors.actionContainerColor,
                              child: Text(
                                "Directions",
                                style: AppTextstyles.googleInter500LabelColor14
                                    .copyWith(color: AppColors.black2Color),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: CustomButton(
                              onPressed: () {
                                ref
                                    .read(goRouterProvider)
                                    .push(
                                      AppRoutes.applicationDetail(
                                        application.applicationId?.toString() ??
                                            '',
                                      ),
                                    );
                              },
                              height: 41,
                              text: "",
                              topPadding: 10,
                              bottomPadding: 10,
                              rightPadding: 0,
                              leftPadding: 0,
                              backgroundColor: AppColors.nextStep1Color,
                              child: Text(
                                "View Details",
                                style: AppTextstyles.googleInter500LabelColor14
                                    .copyWith(color: AppColors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
