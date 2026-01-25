import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/utils/extensions/nullable_fields_helper.dart';

final recommendationControllerProvider =
    NotifierProvider<RecommendationController, RecommendationState>(
  RecommendationController.new,
);

class RecommendationState {
  final String? selectedTM;
  final String? selectedRM;
  final String? selectedTMRecommendation;
  final String? selectedRMRecommendation;
  final String? tmRemarks;
  final String? rmRemarks;

  const RecommendationState({
    this.selectedTM,
    this.selectedRM,
    this.selectedTMRecommendation,
    this.selectedRMRecommendation,
    this.tmRemarks,
    this.rmRemarks,
  });

  RecommendationState copyWith({
    String? selectedTM,
    String? selectedRM,
    String? selectedTMRecommendation,
    String? selectedRMRecommendation,
    String? tmRemarks,
    String? rmRemarks,
    List<String>? fieldsToNull,
  }) {
    return RecommendationState(
      selectedTM: fieldsToNull.apply("selectedTM", selectedTM, this.selectedTM),
      selectedRM: fieldsToNull.apply("selectedRM", selectedRM, this.selectedRM),
      selectedTMRecommendation: fieldsToNull.apply("selectedTMRecommendation", selectedTMRecommendation, this.selectedTMRecommendation),
      selectedRMRecommendation: fieldsToNull.apply("selectedRMRecommendation", selectedRMRecommendation, this.selectedRMRecommendation),
      tmRemarks: fieldsToNull.apply("tmRemarks", tmRemarks, this.tmRemarks),
      rmRemarks: fieldsToNull.apply("rmRemarks", rmRemarks, this.rmRemarks),
    );
  }

  @override
  String toString() {
    return 'RecommendationState(selectedTM: $selectedTM, selectedRM: $selectedRM, selectedTMRecommendation: $selectedTMRecommendation, selectedRMRecommendation: $selectedRMRecommendation, tmRemarks: $tmRemarks, rmRemarks: $rmRemarks)';
  }
}

class RecommendationController extends Notifier<RecommendationState> {
  @override
  RecommendationState build() {
    return const RecommendationState();
  }

  void onChangeTM(String value) {
    state = state.copyWith(selectedTM: value);
  }

  void onChangeRM(String value) {
    state = state.copyWith(selectedRM: value);
  }

  void onChangeTMRecommendation(String value) {
    state = state.copyWith(selectedTMRecommendation: value);
  }

  void onChangeRMRecommendation(String value) {
    state = state.copyWith(selectedRMRecommendation: value);
  }

  void updateTMRemarks(String value) {
    state = state.copyWith(tmRemarks: value);
  }

  void updateRMRemarks(String value) {
    state = state.copyWith(rmRemarks: value);
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