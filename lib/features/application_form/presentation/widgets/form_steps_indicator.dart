import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/features/application_form/presentation/app_form_controller.dart';

class FormStepsIndicator extends ConsumerWidget {
  const FormStepsIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(appFormControllerProvider).currentStep;
    final totalSteps = ref.watch(appFormControllerProvider).totalSteps;
    return Row(
      children: [
        for (int i = 0; i < totalSteps; i++)
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              height: 6.h,
              decoration: BoxDecoration(
                color: i <= currentStep
                    ? AppColors.primary
                    : AppColors.inactiveColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
      ],
    );
  }
}
