import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/application_form/presentation/app_form_controller.dart';

class FormStepsTitle extends ConsumerWidget {
  const FormStepsTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(appFormControllerProvider).currentStep;
    final totalSteps = ref.watch(appFormControllerProvider).totalSteps;
    return Text(
      "Step ${currentStep + 1} of $totalSteps",
      textAlign: TextAlign.center,
      style: AppTextstyles.googleInter400black16.copyWith(fontSize: 16.sp),
    );
  }
}
