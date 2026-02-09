import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/utils/extensions/nullable_fields_helper.dart';

final step2FormControllerProvider =
    NotifierProvider<Step2FormController, Step2FormState>(
  Step2FormController.new,
);

class Step2FormState {
  final String? selectedCity;
  final String? selectedSiteStatus;
  final String? selectedPriority;
  final String? source;
  final String? sourceName;
  final bool autoValidate;

  const Step2FormState({
    this.selectedCity,
    this.selectedSiteStatus,
    this.selectedPriority,
    this.source,
    this.sourceName,
    this.autoValidate = false,
  });

  Step2FormState copyWith({
    String? selectedCity,
    String? selectedSiteStatus,
    String? selectedPriority,
    String? source,
    String? sourceName,
    bool? autoValidate,
    List<String>? fieldsToNull,
  }) {
    return Step2FormState(
      selectedCity: fieldsToNull.apply('selectedCity', selectedCity, this.selectedCity),
      selectedSiteStatus: fieldsToNull.apply('selectedSiteStatus', selectedSiteStatus, this.selectedSiteStatus),
      selectedPriority: fieldsToNull.apply('selectedPriority', selectedPriority, this.selectedPriority),
      source: fieldsToNull.apply('source', source, this.source),
      sourceName: fieldsToNull.apply('sourceName', sourceName, this.sourceName),
      autoValidate: autoValidate ?? this.autoValidate
    );
  }
}

class Step2FormController extends Notifier<Step2FormState> {
  @override
  Step2FormState build() {
    return const Step2FormState();
  }

  void updateCity(String value) {
    state = state.copyWith(selectedCity: value);
  }

  void updateSiteStatus(String value) {
    state = state.copyWith(selectedSiteStatus: value);
  }

  void updatePriority(String value) {
    state = state.copyWith(selectedPriority: value);
  }

  void updateSource(String value) {
    state = state.copyWith(source: value);
  }

  void updateSourceName(String value) {
    state = state.copyWith(sourceName: value);
  }

  void updateAutoValidate(bool value) {
    state = state.copyWith(autoValidate: value);
  }

  void clearField(String fieldName) {
    state = state.copyWith(fieldsToNull: [fieldName]);
  }

  void reset() {
    state = const Step2FormState();
  }
}
