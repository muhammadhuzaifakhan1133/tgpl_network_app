import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/city_names_provider.dart';
import 'package:tgpl_network/common/providers/priorities_provider.dart';
import 'package:tgpl_network/common/providers/site_statuses_provider.dart';
import 'package:tgpl_network/common/widgets/action_container.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/site_location_selection/presentation/site_location_selection_controller.dart';
import 'package:tgpl_network/features/survey_form/presentation/survey_form_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';
import 'package:tgpl_network/utils/custom_date_picker.dart';
import 'package:tgpl_network/utils/datetime_extension.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

class ApplicantInfoFormCard extends ConsumerWidget {
  const ApplicantInfoFormCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(surveyFormControllerProvider.notifier);

    Future<void> navigateToSiteLocationSelection() async {
      LocationData? selectedLocation = await ref
          .read(goRouterProvider)
          .push(AppRoutes.siteLocationSelection);
      if (selectedLocation != null) {
        controller.googleLocationController.text =
            "${selectedLocation.position.latitude}, ${selectedLocation.position.longitude}";
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Applicant Info",
            style: AppTextstyles.googleInter700black28.copyWith(
              fontSize: 24,
              color: AppColors.black2Color,
            ),
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Applicant ID",
            hintText: "2196",
            controller: controller.applicantIdController,
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Entry Code",
            hintText: "TGPL-2196",
            controller: controller.entryCodeController,
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Date Conducted",
            hintText: "01/01/2024",
            onTap: () {
              customDatePicker(
                context: context,
                onUserSelectedDate: (date) {
                  controller.dateConductedController.text = date
                      .formatToDDMMYYY();
                },
              );
            },
            controller: controller.dateConductedController,
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Conducted By",
            hintText: "Asif",
            controller: controller.conductedByController,
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Google Location*",
            hintText: "Tap to select location",
            readOnly: true,
            onTap: navigateToSiteLocationSelection,
            suffixIcon: actionContainer(
              icon: AppImages.locationIconSvg,
              iconColor: AppColors.black,
              rightMargin: 5,
              onTap: navigateToSiteLocationSelection,
            ),
          ),
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) {
              final selectedCity = ref.watch(
                surveyFormControllerProvider.select((s) => s.selectedCity),
              );
              return CustomDropDownWithTitle(
                title: "City",
                hintText: "Select city",
                enableSearch: true,
                selectedItem: selectedCity,
                items: ref.read(cityNamesProvider),
                onChanged: (value) {
                  if (value == null) return;
                  controller.onChangeCity(value.toString());
                },
                validator: (v) => v.validate(),
              );
            },
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "District",
            hintText: "Lahore",
            controller: controller.districtController,
            validator: (v) => v.validate(),
          ),
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) {
              final selectedStatus = ref.watch(
                surveyFormControllerProvider.select((s) => s.siteStatus),
              );
              return CustomDropDownWithTitle(
                title: "Site Status",
                selectedItem: selectedStatus,
                hintText: "Select site status",
                items: ref.read(siteStatusesProvider),
                onChanged: (value) {
                  if (value == null) return;
                  controller.onChangeSiteStatus(value.toString());
                },
                validator: (v) => v.validate(),
              );
            },
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "NP. Name",
            hintText: "Kashif",
            controller: controller.npNameController,
            validator: (v) => v.validate(),
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Source",
            hintText: "Dealer",
            controller: controller.sourceController,
            validator: (v) => v.validate(),
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Source Name",
            hintText: "TGPL Dealer",
            controller: controller.sourceNameController,
            validator: (v) => v.validate(),
          ),
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) {
              final selectedPriority = ref.watch(
                surveyFormControllerProvider.select((s) => s.selectedPriority),
              );
              return CustomDropDownWithTitle(
                title: "Priority",
                selectedItem: selectedPriority,
                hintText: "Select site priority",
                items: ref.read(prioritiesProvider),
                onChanged: (value) {
                  if (value == null) return;
                  controller.onChangePriority(value.toString());
                },
                validator: (v) => v.validate(),
              );
            },
          ),
        ],
      ),
    );
  }
}
