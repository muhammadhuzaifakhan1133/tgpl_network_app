import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/master_data/providers/city_names_provider.dart';
import 'package:tgpl_network/features/master_data/providers/priorities_provider.dart';
import 'package:tgpl_network/features/master_data/providers/site_statuses_provider.dart';
import 'package:tgpl_network/common/widgets/action_container.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/common/widgets/section_detail_card.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/features/site_location_selection/presentation/site_location_selection_controller.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/application_info/application_info_form_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';
import 'package:tgpl_network/utils/custom_date_picker.dart';
import 'package:tgpl_network/utils/extensions/datetime_extension.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

class ApplicantInfoFormCard extends ConsumerWidget {
  const ApplicantInfoFormCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(applicationInfoFormControllerProvider.notifier);
    final state = ref.watch(applicationInfoFormControllerProvider);
    final citiesState = ref.watch(cityNamesProvider);
    final prioritiesState = ref.watch(prioritiesProvider);
    return SectionDetailCard(
      title: "Applicant Info",
      children: [
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Applicant ID",
          hintText: state.applicantId ?? "2196",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Entry Code",
          hintText: state.entryCode ?? "TGPL-2196",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Date Conducted",
          hintText: "dd/mm/yyyy",
          controller: TextEditingController(text: state.dateConducted ?? ""),
          onTap: () {
            customDatePicker(
              context: context,
              onUserSelectedDate: (date) {
                controller.updateConductedInfo(
                  dateConducted: date.formatToDDMMYYY(),
                );
              },
            );
          },
          showClearButton: !state.dateConducted.isNullOrEmpty,
          onClear: () {
            controller.clearField('dateConducted');
          },
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Conducted By",
          hintText: "Asif",
          initialValue: state.conductedBy,
          validator: (v) => v.validate(),
          onChanged: (value) {
            controller.updateConductedInfo(conductedBy: value);
          },
          showClearButton: true,
          onClear: () {
            controller.clearField('conductedBy');
          },
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Google Location*",
          hintText: "Tap to select location",
          readOnly: true,
          controller: TextEditingController(text: state.googleLocation ?? ""),
          suffixIcon: actionContainer(
            icon: AppImages.locationIconSvg,
            iconColor: AppColors.black,
            rightMargin: 5,
            onTap: () async {
              LocationData? selectedLocation = await ref
                  .read(goRouterProvider)
                  .push(AppRoutes.siteLocationSelection);
              if (selectedLocation != null) {
                controller.updateLocation(
                  googleLocation:
                      "${selectedLocation.position.latitude}, ${selectedLocation.position.longitude}",
                );
              }
            },
          ),
        ),
        const SizedBox(height: 10),
        CustomDropDownWithTitle(
          title: "City",
          hintText: citiesState.isLoading ? "Loading Cities..." : "Select city",
          enableSearch: true,
          selectedItem: state.selectedCity,
          items: citiesState.when(
            data: (cities) => cities.map((city) => city.name).toList(),
            loading: () => <String>[],
            error: (_, _) => <String>[],
          ),
          onChanged: (value) {
            if (value == null) return;
            controller.updateLocation(city: value.toString());
          },
          validator: (v) => v.validate(),
          showClearButton: true,
          onClear: () {
            controller.clearField('selectedCity');
          },
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "District",
          hintText: "Lahore",
          initialValue: state.district,
          validator: (v) => v.validate(),
          onChanged: (value) {
            controller.updateLocation(district: value);
          },
          showClearButton: true,
          onClear: () {
            controller.clearField('district');
          },
        ),
        const SizedBox(height: 10),
        CustomDropDownWithTitle(
          title: "Site Status",
          selectedItem: state.siteStatus,
          hintText: "Select site status",
          items: ref.read(siteStatusesProvider),
          onChanged: (value) {
            if (value == null) return;
            controller.updateSiteInfo(status: value.toString());
          },
          showClearButton: !state.siteStatus.isNullOrEmpty,
          onClear: () {
            controller.clearField('siteStatus');
          },
          validator: (v) => v.validate(),
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "NP. Name",
          hintText: "Kashif",
          initialValue: state.npName,
          validator: (v) => v.validate(),
          onChanged: (value) {
            controller.updateNpName(value);
          },
          showClearButton: true,
          onClear: () {
            controller.clearField('npName');
          },
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Source",
          hintText: "Dealer",
          initialValue: state.source,
          validator: (v) => v.validate(),
          onChanged: (value) {
            controller.updateSourceInfo(source: value);
          },
          showClearButton: true,
          onClear: () {
            controller.clearField('source');
          },
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Source Name",
          hintText: "TGPL Dealer",
          initialValue: state.sourceName,
          validator: (v) => v.validate(),
          onChanged: (value) {
            controller.updateSourceInfo(sourceName: value);
          },
          showClearButton: true,
          onClear: () {
            controller.clearField('sourceName');
          },
        ),
        const SizedBox(height: 10),
        CustomDropDownWithTitle(
          title: "Priority",
          selectedItem: state.selectedPriority,
          hintText: prioritiesState.isLoading ? "Loading Priorities..." : "Select site priority",
          items: prioritiesState.when(
            data: (priorities) => priorities,
            loading: () => <String>[],
            error: (_, _) => <String>[],
          ),
          onChanged: (value) {
            if (value == null) return;
            controller.updateSiteInfo(priority: value.toString());
          },
          validator: (v) => v.validate(),
          showClearButton: true,
          onClear: () {
            controller.clearField('selectedPriority');
          },
        ),
      ],
    );
  }
}
