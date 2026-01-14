import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/action_container.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/site_location_selection/presentation/site_location_selection_controller.dart';
import 'package:tgpl_network/features/station_form/presentation/forms/step3/step3_form_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

class Step3FormView extends ConsumerWidget {
  const Step3FormView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(step3FormControllerProvider);

    Future<void> navigateToSiteLocationSelection() async {
      LocationData? selectedLocation = await ref
          .read(goRouterProvider)
          .push(AppRoutes.siteLocationSelection);
      if (selectedLocation != null) {
        controller.locationController.text =
            "${selectedLocation.position.latitude.toStringAsFixed(6)}, ${selectedLocation.position.longitude.toStringAsFixed(6)}";
        controller.addressController.text = selectedLocation.address ?? '';
      }
    }

    return Form(
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
            title: "Google Location*",
            hintText: "Tap to select locaiton",
            readOnly: true,
            controller: controller.locationController,
            extraInformation: "Use GPS to mark exact location of your plot",
            onTap: navigateToSiteLocationSelection,
            suffixIcon: actionContainer(
              icon: AppImages.locationIconSvg,
              iconColor: AppColors.black,
              rightMargin: 5,
              onTap: navigateToSiteLocationSelection,
            ),
            validator: (v) => v.validate(),
          ),
          const SizedBox(height: 16),
          CustomTextFieldWithTitle(
            title: "Complete Site Address*",
            hintText: "Enter complete address with landmarks",
            controller: controller.addressController,
            validator: (v) => v.validate(),
            multiline: true,
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
    );
  }
}
