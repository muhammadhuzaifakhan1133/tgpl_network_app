import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_textfield.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/station_form/presentation/forms/step3/step3_form_controller.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

class Step3FormView extends ConsumerWidget {
  const Step3FormView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(step3FormControllerProvider);
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Plot Details",
                style: AppTextstyles.googleInter700black28.copyWith(
                  fontSize: 24,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Provide plot dimensions and location",
                style: AppTextstyles.googleInter400black16,
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Plot Size (in feet)",
                style: AppTextstyles.googleJakarta500Grey12,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldWithTitle(
                    title: "Front*",
                    hintText: "60",
                    controller: controller.frontSizeController,
                    validator: (v) => v.validateNumber(),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextFieldWithTitle(
                    title: "Depth*",
                    hintText: "78",
                    controller: controller.depthSizeController,
                    validator: (v) => v.validateNumber(),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter dimensions in feet.",
                style: AppTextstyles.googleInter400LightGrey12,
              ),
            ),
            const SizedBox(height: 16),
            CustomTextFieldWithTitle(
              title: "Complete Site Address*",
              hintText: "Enter complete address with landmarks",
              controller: controller.addressController,
              validator: (v) => v.validate(),
              multiline: true,
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                ref.read(step3FormControllerProvider).locationController.text =
                    "Temporary location";
              },
              child: CustomTextFieldWithTitle(
                title: "Google Location*",
                hintText: "Tap to select locaiton",
                enabled: false,
                controller: controller.locationController,
                extraInformation: "Use GPS to mark exact location of your plot",
                suffixIcon: _locationSuffixIcon(ref),
                validator: (v) => v.validate(),
                isChangeStyleOnDisable: false,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onPressed: () {
                      controller.validateAndContinue();
                    },
                    text: "Submit",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _locationSuffixIcon(WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.extraInformationColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        Icons.location_on_outlined,
        // size: 16,
        color: AppColors.black,
      ),
    );
  }
}
