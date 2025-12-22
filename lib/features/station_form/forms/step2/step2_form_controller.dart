import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final step2FormControllerProvider = NotifierProvider.autoDispose<Step2FormController, Step2FormState>(() => Step2FormController());

class Step2FormState {
  String? selectedCity;
  String? selectedSiteStatus;
  String? selectedPriority;

  Step2FormState({
    this.selectedCity,
    this.selectedPriority,
    this.selectedSiteStatus,
  });

  Step2FormState copyWith({
    String? selectedCity,
    String? selectedPriority,
    String? selectedSiteStatus,
  }) {
    return Step2FormState(
      selectedCity: selectedCity ?? this.selectedCity,
      selectedPriority: selectedPriority ?? this.selectedPriority,
      selectedSiteStatus: selectedSiteStatus ?? this.selectedSiteStatus,
    );
  }
}

class Step2FormController extends Notifier<Step2FormState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController sourceController = TextEditingController();
  TextEditingController sourceNameController = TextEditingController();

  @override
  Step2FormState build() {
    return Step2FormState();
  }

  void onCityChange(String newCity) {
    state = state.copyWith(selectedCity: newCity);
  }

  void onSiteStatusChange(String newSiteStatus) {
    state = state.copyWith(selectedSiteStatus: newSiteStatus);
  }

  void onPriorityChange(String newPriority) {
    state = state.copyWith(selectedPriority: newPriority);
  }
}
