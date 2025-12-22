import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/features/station_form/station_form_controller.dart';

class FormStepsIndicator extends ConsumerWidget {
  const FormStepsIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(stationFormControllerProvider).currentStep;
    final totalSteps = ref
        .read(stationFormControllerProvider.notifier)
        .steps
        .length;
    return Row(
      children: [
        for (int i = 0; i < totalSteps; i++)
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              decoration: BoxDecoration(
                color: i <= currentStep
                    ? AppColors.primary
                    : AppColors.inactiveColor,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
      ],
    );
  }
}