import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/utils/extensions/nullable_fields_helper.dart';

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
    List<String>? fieldsToNull,
  }) {
    return SurveyRecommendationFormState(
      selectedTM: fieldsToNull
          .apply('selectedTM', selectedTM, this.selectedTM),
      selectedRM: fieldsToNull
          .apply('selectedRM', selectedRM, this.selectedRM),
      selectedTMRecommendation: fieldsToNull.apply(
          'selectedTMRecommendation',
          selectedTMRecommendation,
          this.selectedTMRecommendation),
      selectedRMRecommendation: fieldsToNull.apply(
          'selectedRMRecommendation',
          selectedRMRecommendation,
          this.selectedRMRecommendation),
      tmRemarks: fieldsToNull.apply('tmRemarks', tmRemarks, this.tmRemarks),
      rmRemarks: fieldsToNull.apply('rmRemarks', rmRemarks, this.rmRemarks),
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

  void clearField(String fieldName) {
    state = state.copyWith(fieldsToNull: [fieldName]);
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