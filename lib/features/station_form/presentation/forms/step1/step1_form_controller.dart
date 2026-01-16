import 'package:flutter_riverpod/flutter_riverpod.dart';

final step1FormControllerProvider =
    NotifierProvider.autoDispose<Step1FormController, Step1FormState>(
  Step1FormController.new,
);

class Step1FormState {
  final String applicantName;
  final String contactPerson;
  final String currentlyPresence;
  final String contactNumber;
  final String whatsappNumber;

  const Step1FormState({
    this.applicantName = '',
    this.contactPerson = '',
    this.currentlyPresence = '',
    this.contactNumber = '',
    this.whatsappNumber = '',
  });

  Step1FormState copyWith({
    String? applicantName,
    String? contactPerson,
    String? currentlyPresence,
    String? contactNumber,
    String? whatsappNumber,
  }) {
    return Step1FormState(
      applicantName: applicantName ?? this.applicantName,
      contactPerson: contactPerson ?? this.contactPerson,
      currentlyPresence: currentlyPresence ?? this.currentlyPresence,
      contactNumber: contactNumber ?? this.contactNumber,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
    );
  }
}

class Step1FormController extends Notifier<Step1FormState> {
  @override
  Step1FormState build() {
    return const Step1FormState();
  }

  void updateApplicantName(String value) {
    state = state.copyWith(applicantName: value);
  }

  void updateContactPerson(String value) {
    state = state.copyWith(contactPerson: value);
  }

  void updateCurrentlyPresence(String value) {
    state = state.copyWith(currentlyPresence: value);
  }

  void updateContactNumber(String value) {
    state = state.copyWith(contactNumber: value);
  }

  void updateWhatsappNumber(String value) {
    state = state.copyWith(whatsappNumber: value);
  }

  bool isValid() {
    return state.applicantName.isNotEmpty &&
        state.contactPerson.isNotEmpty &&
        state.currentlyPresence.isNotEmpty &&
        state.contactNumber.isNotEmpty &&
        state.whatsappNumber.isNotEmpty;
  }
}

