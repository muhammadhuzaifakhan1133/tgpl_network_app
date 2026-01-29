import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/utils/extensions/nullable_fields_helper.dart';

final step1FormControllerProvider =
    NotifierProvider<Step1FormController, Step1FormState>(
  Step1FormController.new,
);

class Step1FormState {
  final String? applicantName;
  final String? contactPerson;
  final String? currentlyPresence;
  final String? contactNumber;
  final String? whatsappNumber;

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
    List<String>? fieldsToNull,
  }) {
    return Step1FormState(
      applicantName: fieldsToNull.apply('applicantName', applicantName, this.applicantName),
      contactPerson: fieldsToNull.apply('contactPerson', contactPerson, this.contactPerson),
      currentlyPresence: fieldsToNull.apply('currentlyPresence', currentlyPresence, this.currentlyPresence),
      contactNumber: fieldsToNull.apply('contactNumber', contactNumber, this.contactNumber),
      whatsappNumber: fieldsToNull.apply('whatsappNumber', whatsappNumber, this.whatsappNumber),
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

  void clearField(String fieldName) {
    state = state.copyWith(fieldsToNull: [fieldName]);
  }
}

