import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/station_form/presentation/forms/step1/step1_form_controller.dart';
import 'package:tgpl_network/features/station_form/presentation/forms/step1/step1_form_view.dart';
import 'package:tgpl_network/features/station_form/presentation/forms/step2/step2_form_controller.dart';
import 'package:tgpl_network/features/station_form/presentation/forms/step2/step2_form_view.dart';
import 'package:tgpl_network/features/station_form/presentation/forms/step3/step3_form_controller.dart';
import 'package:tgpl_network/features/station_form/presentation/forms/step3/step3_form_view.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';

final stationFormControllerProvider =
    NotifierProvider.autoDispose<StationFormController, StationFormState>(() {
      return StationFormController();
    });

class StationFormController extends Notifier<StationFormState> {
  late final PageController _pageController;

  PageController get pageController => _pageController;

  String? applicationId;

  List<Widget> get steps => const [
    Step1FormView(),
    Step2FormView(),
    Step3FormView(),
  ];

  @override
  StationFormState build() {
    _pageController = PageController();
    ref.onDispose((){
      _pageController.dispose();
    });
    return StationFormState(currentStep: 0);
  }

  // max step 3
  void goToStep(int step) {
    state = state.copyWith(currentStep: step);
  }

  void onPreviousButtonPressed() {
    if (state.currentStep > 0) {
      goToStep(state.currentStep - 1);
      _pageController.animateToPage(
        state.currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      ref.read(goRouterProvider).pop();
    }
  }

  void onActionButtonPressed() {
    if (state.currentStep < 2) {
      goToStep(state.currentStep + 1);
      _pageController.animateToPage(
        state.currentStep,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // final step1Controller = ref.read(step1FormControllerProvider);
      // final step2State = ref.read(step2FormControllerProvider);
      // final step2Controller = ref.read(step2FormControllerProvider.notifier);
      // final step3Controller = ref.read(step3FormControllerProvider);
      // submit the form
      // save application Id coming from server to applicationId
      ref.read(goRouterProvider).replace(AppRoutes.stationFormConfirmation);
    }
  }
}

class StationFormState {
  final int currentStep;

  StationFormState({required this.currentStep});

  StationFormState copyWith({int? currentStep}) {
    return StationFormState(currentStep: currentStep ?? this.currentStep);
  }
}
