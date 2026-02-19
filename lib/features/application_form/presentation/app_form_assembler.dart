import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/application_form/models/applicaiton_form_model.dart';
import 'package:tgpl_network/features/application_form/presentation/forms/step1/step1_form_controller.dart';
import 'package:tgpl_network/features/application_form/presentation/forms/step2/step2_form_controller.dart';
import 'package:tgpl_network/features/application_form/presentation/forms/step3/step3_form_controller.dart';

class AppFormAssembler {
  static ApplicationFormModel assemble(Ref ref) {
    final step1Form = ref.read(step1FormControllerProvider);
    final step2Form = ref.read(step2FormControllerProvider);
    final step3Form = ref.read(step3FormControllerProvider);

    return ApplicationFormModel(
      applicantName: step1Form.applicantName,
      emailAddress: step1Form.email,
      contactPerson: step1Form.contactPerson,
      currentlyPresence: step1Form.currentlyPresence,
      contactNumber: step1Form.contactNumber,
      whatsappNumber: step1Form.whatsappNumber,
      selectedCity: step2Form.selectedCity,
      selectedSiteStatus: step2Form.selectedSiteStatus,
      selectedPriority: step2Form.selectedPriority,
      source: step2Form.source,
      sourceName: step2Form.sourceName,
      frontSize: step3Form.frontSize,
      depthSize: step3Form.depthSize,
      googleLocation: step3Form.googleLocation,
      address: step3Form.address,
    );
  }

  static void clearForm(Ref ref) {
    ref.read(step1FormControllerProvider.notifier).reset();
    ref.read(step2FormControllerProvider.notifier).reset();
    ref.read(step3FormControllerProvider.notifier).reset();
  }
}
