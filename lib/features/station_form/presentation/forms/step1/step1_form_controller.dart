import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/station_form/presentation/station_form_controller.dart';

final step1FormControllerProvider = Provider<Step1FormController>((ref) {
  final controller =  Step1FormController(ref);
  ref.onDispose(controller.dispose);
  return controller;
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

  void dispose() {
    applicantNameController.dispose();
    contactPersonController.dispose();
    currentlyPresenceController.dispose();
    contactNumberController.dispose();
    whatsappNumberController.dispose();
  }

  void validateAndContinue() {
    if (formKey.currentState!.validate()) {
      ref.read(stationFormControllerProvider.notifier).onActionButtonPressed();
    }
  }
}
