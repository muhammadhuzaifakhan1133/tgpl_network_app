import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_model.dart';
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

  RecommendationState.loadFromApplication(ApplicationModel app)
      : selectedTM = app.ttRecommendationTmName,
        selectedRM = app.ttRecommendationRmName,
        selectedTMRecommendation = app.ttTmRecommendation,
        selectedRMRecommendation = app.ttRmRecommendation,
        tmRemarks = app.ttTmRemarks,
        rmRemarks = app.ttRmRemarks;

  RecommendationState.loadFromTrafficTradeFormModel(TrafficTradeFormModel form)
      : selectedTM = form.selectedTM,
        selectedRM = form.selectedRM,
        selectedTMRecommendation = form.selectedTMRecommendation,
        selectedRMRecommendation = form.selectedRMRecommendation,
        tmRemarks = form.tmRemarks,
        rmRemarks = form.rmRemarks;
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

  void loadFromApplication(ApplicationModel app) {
    state = RecommendationState.loadFromApplication(app);
  }

  void loadFromTrafficTradeFormModel(TrafficTradeFormModel form) {
    state = RecommendationState.loadFromTrafficTradeFormModel(form);
  }
}