import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/station_form/station_form_controller.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

final step1FormControllerProvider = Provider<Step1FormController>((ref) {
  return Step1FormController(ref);
});

class Step1FormController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController applicantNameController = TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController currentlyPresenceController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController whatsappNumberController = TextEditingController();
  late Ref ref;

  Step1FormController(this.ref);

  void goToNextStep() {
    // if (formKey.currentState!.validate()) {
    ref.read(stationFormControllerProvider.notifier).onActionButtonPressed();
    // }
  }

  String? validateName(String? value, [key = "applicant"]) {
    if (value == null || value.isEmpty) {
      return 'Please enter $key name';
    }
    return null;
  }

  String? validateContactNumber(String? value, [key = "contact"]) {
    if (value == null || value.isEmpty) {
      return 'Please enter $key number';
    }
    if (!value.isValidPhoneNumber()) {
      return 'Please enter a valid $key number';
    }
    return null;
  }
}
