import 'package:flutter_riverpod/flutter_riverpod.dart';

final surveyRecommendationFormControllerProvider = NotifierProvider<
    SurveyRecommendationFormController,
    SurveyRecommendationFormState>(SurveyRecommendationFormController.new);

class SurveyRecommendationFormState {
  final String? selectedTM;
  final String? selectedRM;
  final String? selectedTMRecommendation;
  final String? selectedRMRecommendation;
  final String? tmRemarks;
  final String? rmRemarks;

  const SurveyRecommendationFormState({
    this.selectedTM,
    this.selectedRM,
    this.selectedTMRecommendation,
    this.selectedRMRecommendation,
    this.tmRemarks,
    this.rmRemarks,
  });

  SurveyRecommendationFormState copyWith({
    String? selectedTM,
    String? selectedRM,
    String? selectedTMRecommendation,
    String? selectedRMRecommendation,
    String? tmRemarks,
    String? rmRemarks,
  }) {
    return SurveyRecommendationFormState(
      selectedTM: selectedTM ?? this.selectedTM,
      selectedRM: selectedRM ?? this.selectedRM,
      selectedTMRecommendation:
          selectedTMRecommendation ?? this.selectedTMRecommendation,
      selectedRMRecommendation:
          selectedRMRecommendation ?? this.selectedRMRecommendation,
      tmRemarks: tmRemarks ?? this.tmRemarks,
      rmRemarks: rmRemarks ?? this.rmRemarks,
    );
  }

  @override
  String toString() {
    return 'SurveyRecommendationFormState(selectedTM: $selectedTM, selectedRM: $selectedRM, selectedTMRecommendation: $selectedTMRecommendation, selectedRMRecommendation: $selectedRMRecommendation, tmRemarks: $tmRemarks, rmRemarks: $rmRemarks)';
  }
}

class SurveyRecommendationFormController
    extends Notifier<SurveyRecommendationFormState> {
  @override
  SurveyRecommendationFormState build() {
    return const SurveyRecommendationFormState();
  }

  void onChangeTM(String tm) {
    state = state.copyWith(selectedTM: tm);
  }

  void onChangeRM(String rm) {
    state = state.copyWith(selectedRM: rm);
  }

  void onChangeTMRecommendation(String recommendation) {
    state = state.copyWith(selectedTMRecommendation: recommendation);
  }

  void onChangeRMRecommendation(String recommendation) {
    state = state.copyWith(selectedRMRecommendation: recommendation);
  }

  void updateTMRemarks(String remarks) {
    state = state.copyWith(tmRemarks: remarks);
  }

  void updateRMRemarks(String remarks) {
    state = state.copyWith(rmRemarks: remarks);
  }

  void prefillFormData({
    required String selectedTM,
    required String selectedRM,
    required String selectedTMRecommendation,
    required String selectedRMRecommendation,
    required String tmRemarks,
    required String rmRemarks,
  }) {
    state = state.copyWith(
      selectedTM: selectedTM,
      selectedRM: selectedRM,
      selectedTMRecommendation: selectedTMRecommendation,
      selectedRMRecommendation: selectedRMRecommendation,
      tmRemarks: tmRemarks,
      rmRemarks: rmRemarks,
    );
  }
}