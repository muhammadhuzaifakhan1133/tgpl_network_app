import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
              borderRadius: BorderRadius.circular(18.25),
            ),
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "Your Application ID",
                    style: AppTextstyles.googleInter400LightGrey12.copyWith(
                      fontSize: 9.89,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    applicationId,
                    style: AppTextstyles.googleInter700black28.copyWith(
                      fontSize: 24.33,
                      color: AppColors.black2Color,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "Please save this ID for future reference. You can use it to track your application status.",
                    textAlign: TextAlign.center,
                    style: AppTextstyles.neutra500white18.copyWith(
                      fontSize: 12.17,
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
