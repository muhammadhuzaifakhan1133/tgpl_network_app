import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/application_form/data/app_form_dropdowns_remote_data_source.dart';
import 'package:tgpl_network/features/application_form/data/application_submission_data_source.dart';
import 'package:tgpl_network/features/application_form/models/app_form_dropdown_values_model.dart';
import 'package:tgpl_network/features/application_form/presentation/app_form_assembler.dart';

final appFormControllerProvider =
    NotifierProvider.autoDispose<AppFormController, AppFormState>(
  AppFormController.new,
);

final appFormSubmissionProvider = AsyncNotifierProvider<
    AppFormSubmissionController, void>(
  AppFormSubmissionController.new,
);

final formPrerequisiteValuesProvider = AsyncNotifierProvider<
    FormPrerequisiteValuesController, AppFormDropdownsValuesModel>(
  FormPrerequisiteValuesController.new,
);

class AppFormSubmissionController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> submitAppForm() async {
    state = const AsyncValue.loading();
    try {
      final appFormData = AppFormAssembler.assemble(ref);
      final response = await ref.read(applicationSubmissionDataSourceProvider).submitApplication(appFormData);
      if (response.success) {
        state = const AsyncValue.data(null);
        return true;
      } else {
        state = AsyncValue.error(
          Exception('Submission failed: ${response.message}'),
          StackTrace.current,
        );
        return false;
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return false;
    }
  }
}

class AppFormController extends Notifier<AppFormState> {
  @override
  AppFormState build() {
    return const AppFormState(
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

  void previousStep({required void Function() onBackFromFirstStep}) {
    if (!state.isFirstStep) {
      goToStep(state.currentStep - 1);
    } else {
      onBackFromFirstStep();
    }
  }

  bool canSubmit() => state.isLastStep;
}


class AppFormState {
  final int currentStep;
  final int totalSteps;

  const AppFormState({
    required this.currentStep,
    required this.totalSteps,
  });

  bool get isFirstStep => currentStep == 0;
  bool get isLastStep => currentStep == totalSteps - 1;

  AppFormState copyWith({
    int? currentStep,
    int? totalSteps,
  }) {
    return AppFormState(
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
    );
  }
}


class FormPrerequisiteValuesController extends AsyncNotifier<AppFormDropdownsValuesModel> {
  @override
  Future<AppFormDropdownsValuesModel> build() async {
    final prerequisiteValues = await ref
        .read(appFormDropdownsRemoteDataSourceProvider)
        .fetchAppFormDropdownValues();
    return prerequisiteValues;
  }
}