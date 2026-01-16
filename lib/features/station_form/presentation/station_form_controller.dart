import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/station_form/presentation/station_form_assembler.dart';

final stationFormControllerProvider =
    NotifierProvider.autoDispose<StationFormController, StationFormState>(
  StationFormController.new,
);

final stationSubmissionProvider = AsyncNotifierProvider<
    StationSubmissionController, void>(
  StationSubmissionController.new,
);

class StationSubmissionController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // Initialization if needed
  }

  Future<void> submitStationForm() async {
    // Logic to submit the station form
    state = const AsyncValue.loading();
    try {
      // final stationFormData = StationFormAssembler.assemble(ref);
      // Simulate a network call or form submission
      await Future.delayed(const Duration(seconds: 2));
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

class StationFormController extends Notifier<StationFormState> {
  @override
  StationFormState build() {
    return const StationFormState(
      currentStep: 0,
      totalSteps: 3,
    );
  }

  void goToStep(int step) {
    if (step < 0 || step >= state.totalSteps) return;
    state = state.copyWith(currentStep: step);
  }

  void nextStep() {
    if (!state.isLastStep) {
      goToStep(state.currentStep + 1);
    }
  }

  void previousStep() {
    if (!state.isFirstStep) {
      goToStep(state.currentStep - 1);
    }
  }

  bool canSubmit() => state.isLastStep;
}


class StationFormState {
  final int currentStep;
  final int totalSteps;

  const StationFormState({
    required this.currentStep,
    required this.totalSteps,
  });

  bool get isFirstStep => currentStep == 0;
  bool get isLastStep => currentStep == totalSteps - 1;

  StationFormState copyWith({
    int? currentStep,
    int? totalSteps,
  }) {
    return StationFormState(
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
    );
  }
}

