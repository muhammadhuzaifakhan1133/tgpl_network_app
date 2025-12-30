import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/station_form/presentation/station_form_controller.dart';

final step3FormControllerProvider = Provider<Step3FormController>((ref) {
  final controller =  Step3FormController(ref);
  ref.onDispose(controller.dispose);
  return controller;
});

class Step3FormController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController frontSizeController = TextEditingController();
  TextEditingController depthSizeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  late Ref ref;

  Step3FormController(this.ref);

  void dispose() {
    frontSizeController.dispose();
    depthSizeController.dispose();
    addressController.dispose();
    locationController.dispose();
  }

  void validateAndContinue() {
    if (formKey.currentState!.validate()) {
      ref.read(stationFormControllerProvider.notifier).onActionButtonPressed();
    }
  }
}
