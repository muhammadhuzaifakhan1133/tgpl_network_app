import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/station_form/presentation/forms/step1/step1_form_controller.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

class Step1FormView extends ConsumerWidget {
  const Step1FormView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(step1FormControllerProvider);
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Basic Details",
              style: AppTextstyles.googleInter700black28.copyWith(
                fontSize: 24,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Let's start with your contact information",
              style: AppTextstyles.googleInter400black16,
            ),
          ),
          const SizedBox(height: 24),
          CustomTextFieldWithTitle(
            title: "Applicant Name*",
            hintText: "M Huzaifa Khan",
            controller: controller.applicantNameController,
            validator: (v) => v.validate(),
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 16),
          CustomTextFieldWithTitle(
            title: "Contact Person*",
            hintText: "Basit",
            controller: controller.contactPersonController,
            validator: (v) => v.validate(),
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 15),
          CustomTextFieldWithTitle(
            title: "Currently Presence*",
            hintText: "Currently Presence",
            controller: controller.currentlyPresenceController,
            validator: (v) => v.validate(),
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 15),
          CustomTextFieldWithTitle(
            title: "Contact Number*",
            hintText: "03001234567",
            controller: controller.contactNumberController,
            validator: (v) => v.validatePhoneNumber(),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 15),
          CustomTextFieldWithTitle(
            title: "WhatsApp Number*",
            hintText: "03725847514",
            controller: controller.whatsappNumberController,
            validator: (v) => v.validatePhoneNumber(),
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            extraInformation: "We'll use WhatsApp for quick updates",
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    controller.validateAndContinue();
                  },
                  text: "Next",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
