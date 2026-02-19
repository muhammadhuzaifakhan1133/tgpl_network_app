import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  late final TextEditingController _emailController;
  late final TextEditingController _contactPersonController;
  late final TextEditingController _currentlyPresenceController;
  late final TextEditingController _contactNumberController;
  late final TextEditingController _whatsappNumberController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(step1FormControllerProvider);

    _applicantNameController = TextEditingController(text: state.applicantName);
    _emailController = TextEditingController(text: state.email);
    _contactPersonController = TextEditingController(text: state.contactPerson);
    _currentlyPresenceController = TextEditingController(
      text: state.currentlyPresence,
    );
    _contactNumberController = TextEditingController(text: state.contactNumber);
    _whatsappNumberController = TextEditingController(
      text: state.whatsappNumber,
    );
  }

  @override
  void dispose() {
    _applicantNameController.dispose();
    _emailController.dispose();
    _contactPersonController.dispose();
    _currentlyPresenceController.dispose();
    _contactNumberController.dispose();
    _whatsappNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final step1Controller = ref.read(step1FormControllerProvider.notifier);
    final appFormController = ref.read(appFormControllerProvider.notifier);
    final autoValidate = ref.watch(
      step1FormControllerProvider.select((s) => s.autoValidate),
    );
    return Form(
      key: _formKey,
      autovalidateMode: autoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Basic Details",
              style: AppTextstyles.googleInter700black28.copyWith(
                fontSize: 24.sp,
              ),
            ),
          ),
          SizedBox(height: 24.h),

          CustomTextFieldWithTitle(
            title: "Applicant Name*",
            controller: _applicantNameController,
            hintText: "Enter applicant name",
            validator: (v) => v.validate(),
            onChanged: step1Controller.updateApplicantName,
            showClearButton: true,
            isRequired: true,
            onClear: () => step1Controller.clearField('applicantName'),
          ),

          SizedBox(height: 16.h),

          CustomTextFieldWithTitle(
            title: "Email*",
            controller: _emailController,
            hintText: "Enter email",
            validator: (v) => v.validate(),
            onChanged: step1Controller.updateEmail,
            showClearButton: true,
            isRequired: true,
            onClear: () => step1Controller.clearField('email'),
          ),

          SizedBox(height: 16.h),

          CustomTextFieldWithTitle(
            title: "Contact Person*",
            controller: _contactPersonController,
            hintText: "Enter contact person",
            validator: (v) => v.validate(),
            onChanged: step1Controller.updateContactPerson,
            showClearButton: true,
            isRequired: true,
            onClear: () => step1Controller.clearField('contactPerson'),
          ),

          SizedBox(height: 16.h),

          CustomTextFieldWithTitle(
            title: "Currently Presence*",
            controller: _currentlyPresenceController,
            hintText: "Enter currently presence",
            validator: (v) => v.validate(),
            onChanged: step1Controller.updateCurrentlyPresence,
            showClearButton: true,
            isRequired: true,
            onClear: () => step1Controller.clearField('currentlyPresence'),
          ),

          SizedBox(height: 16.h),

          CustomTextFieldWithTitle(
            title: "Contact Number*",
            controller: _contactNumberController,
            hintText: "Enter contact number",
            validator: (v) => v.validatePhoneNumber(),
            onChanged: step1Controller.updateContactNumber,
            showClearButton: true,
            isRequired: true,
            onClear: () => step1Controller.clearField('contactNumber'),
          ),

          SizedBox(height: 16.h),

          CustomTextFieldWithTitle(
            title: "WhatsApp Number*",
            controller: _whatsappNumberController,
            hintText: "Enter WhatsApp number",
            validator: (v) => v.validatePhoneNumber(),
            onChanged: step1Controller.updateWhatsappNumber,
            showClearButton: true,
            isRequired: true,
            onClear: () => step1Controller.clearField('whatsappNumber'),
          ),

          SizedBox(height: 20.h),

          CustomButton(
            text: "Next",
            onPressed: () {
              if (!autoValidate) {
                ref
                    .read(step1FormControllerProvider.notifier)
                    .updateAutoValidate(true);
              }
              if (_formKey.currentState != null &&
                  _formKey.currentState!.validate()) {
                appFormController.nextStep();
              }
            },
          ),
        ],
      ),
    );
  }
}
