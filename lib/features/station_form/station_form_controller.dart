import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/station_form/forms/step1/step1_form_view.dart';
import 'package:tgpl_network/features/station_form/forms/step2/step2_form_view.dart';
import 'package:tgpl_network/features/station_form/forms/step3/step3_form_view.dart';
import 'package:tgpl_network/routes/app_router.dart';

final stationFormControllerProvider =
    NotifierProvider.autoDispose<StationFormController, StationFormState>(() {
      return StationFormController();
    });

class StationFormController extends Notifier<StationFormState> {
  late final PageController _pageController;

  PageController get pageController => _pageController;

  List<Widget> get steps => const [
    Step1FormView(),
    Step2FormView(),
    Step3FormView(),
  ];

  @override
  StationFormState build() {
    _pageController = PageController();
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
