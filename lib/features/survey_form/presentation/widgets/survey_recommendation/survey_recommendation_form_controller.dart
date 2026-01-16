import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final surveyRecommendationFormControllerProvider =
    NotifierProvider<SurveyRecommendationFormController,
        SurveyRecommendationFormState>(
        SurveyRecommendationFormController.new);

class SurveyRecommendationFormState {
  final String? selectedTM;
  final String? selectedRM;
  final String? selectedTMRecommendation;
  final String? selectedRMRecommendation;

  const SurveyRecommendationFormState({
    this.selectedTM,
    this.selectedRM,
    this.selectedTMRecommendation,
    this.selectedRMRecommendation,
  });

  SurveyRecommendationFormState copyWith({
    String? selectedTM,
    String? selectedRM,
    String? selectedTMRecommendation,
    String? selectedRMRecommendation,
  }) {
    return SurveyRecommendationFormState(
      selectedTM: selectedTM ?? this.selectedTM,
      selectedRM: selectedRM ?? this.selectedRM,
      selectedTMRecommendation:
          selectedTMRecommendation ?? this.selectedTMRecommendation,
      selectedRMRecommendation:
          selectedRMRecommendation ?? this.selectedRMRecommendation,
    );
  }
}

class SurveyRecommendationFormController
    extends Notifier<SurveyRecommendationFormState> {
  final tmRemarksController = TextEditingController();
  final rmRemarksController = TextEditingController();

  @override
  SurveyRecommendationFormState build() {
    ref.onDispose(_disposeControllers);
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

  void _disposeControllers() {
    tmRemarksController.dispose();
    rmRemarksController.dispose();
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
    );
    
    tmRemarksController.text = tmRemarks;
    rmRemarksController.text = rmRemarks;
  }
}