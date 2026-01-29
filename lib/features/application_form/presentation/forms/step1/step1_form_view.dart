import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/application_form/presentation/forms/step1/step1_form_controller.dart';
import 'package:tgpl_network/features/application_form/presentation/app_form_controller.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

class Step1FormView extends ConsumerStatefulWidget {
  const Step1FormView({super.key});

  @override
  ConsumerState<Step1FormView> createState() => _Step1FormViewState();
}

class _Step1FormViewState extends ConsumerState<Step1FormView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _applicantNameController;
  late final TextEditingController _contactPersonController;
  late final TextEditingController _currentlyPresenceController;
  late final TextEditingController _contactNumberController;
  late final TextEditingController _whatsappNumberController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(step1FormControllerProvider);

    _applicantNameController =
        TextEditingController(text: state.applicantName);
    _contactPersonController =
        TextEditingController(text: state.contactPerson);
    _currentlyPresenceController =
        TextEditingController(text: state.currentlyPresence);
    _contactNumberController =
        TextEditingController(text: state.contactNumber);
    _whatsappNumberController =
        TextEditingController(text: state.whatsappNumber);
  }

  @override
  void dispose() {
    _applicantNameController.dispose();
    _contactPersonController.dispose();
    _currentlyPresenceController.dispose();
    _contactNumberController.dispose();
    _whatsappNumberController.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  final step1Controller =
      ref.read(step1FormControllerProvider.notifier);
  final appFormController =
      ref.read(appFormControllerProvider.notifier);

  return Form(
    key: _formKey,
    child: Column(
      children: [
        Text(
          "Basic Details",
          style: AppTextstyles.googleInter700black28.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 24),

        CustomTextFieldWithTitle(
          title: "Applicant Name*",
          controller: _applicantNameController,
          hintText: "Enter applicant name",
          validator: (v) => v.validate(),
          onChanged: step1Controller.updateApplicantName,
          showClearButton: true,
          onClear: () => step1Controller.clearField('applicantName'),
        ),

        const SizedBox(height: 16),

        CustomTextFieldWithTitle(
          title: "Contact Person*",
          controller: _contactPersonController,
          hintText: "Enter contact person",
          validator: (v) => v.validate(),
          onChanged: step1Controller.updateContactPerson,
          showClearButton: true,
          onClear: () => step1Controller.clearField('contactPerson'),
        ),

        const SizedBox(height: 16),

        CustomTextFieldWithTitle(
          title: "Currently Presence*",
          controller: _currentlyPresenceController,
          hintText: "Enter currently presence",
          validator: (v) => v.validate(),
          onChanged: step1Controller.updateCurrentlyPresence,
          showClearButton: true,
          onClear: () => step1Controller.clearField('currentlyPresence'),
        ),

        const SizedBox(height: 16),

        CustomTextFieldWithTitle(
          title: "Contact Number*",
          controller: _contactNumberController,
          hintText: "Enter contact number",
          validator: (v) => v.validatePhoneNumber(),
          onChanged: step1Controller.updateContactNumber,
          showClearButton: true,
          onClear: () => step1Controller.clearField('contactNumber'),
        ),

        const SizedBox(height: 16),

        CustomTextFieldWithTitle(
          title: "WhatsApp Number*",
          controller: _whatsappNumberController,
          hintText: "Enter WhatsApp number",
          validator: (v) => v.validatePhoneNumber(),
          onChanged: step1Controller.updateWhatsappNumber,
          showClearButton: true,
          onClear: () => step1Controller.clearField('whatsappNumber'),
        ),

        const SizedBox(height: 20),

        CustomButton(
          text: "Next",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              appFormController.nextStep();
            }
          },
        ),
      ],
    ),
  );
}

}