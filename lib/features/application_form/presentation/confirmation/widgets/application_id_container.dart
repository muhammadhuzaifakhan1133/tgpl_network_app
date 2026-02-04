import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class ApplicationIdContainer extends ConsumerWidget {
  final String applicationId;
  const ApplicationIdContainer({super.key, required this.applicationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: Card(
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColors.whiteGreyColor),
              borderRadius: BorderRadius.circular(18.25.r),
            ),
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
              child: Column(
                children: [
                  Text(
                    "Your Application ID",
                    style: AppTextstyles.googleInter400LightGrey12.copyWith(
                      fontSize: 9.89.sp,
                    ),
                  ),
                  // SizedBox(height: 3.h),
                  Text(
                    applicationId,
                    style: AppTextstyles.googleInter700black28.copyWith(
                      fontSize: 24.33.sp,
                      color: AppColors.black2Color,
                    ),
                  ),
                  // SizedBox(height: 3.h),
                  Text(
                    "Please save this ID for future reference. You can use it to track your application status.",
                    textAlign: TextAlign.center,
                    style: AppTextstyles.neutra500white18.copyWith(
                      fontSize: 12.17.sp,
                      color: AppColors.subHeadingColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
