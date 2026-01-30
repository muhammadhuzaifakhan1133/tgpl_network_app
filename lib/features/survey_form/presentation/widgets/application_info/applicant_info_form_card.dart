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

class ApplicantInfoFormCard extends ConsumerStatefulWidget {
  const ApplicantInfoFormCard({super.key});

  @override
  ConsumerState<ApplicantInfoFormCard> createState() =>
      _ApplicantInfoFormCardState();
}

class _ApplicantInfoFormCardState extends ConsumerState<ApplicantInfoFormCard> {
  TextEditingController dateConductedController = TextEditingController();
  TextEditingController conductedByController = TextEditingController();
  TextEditingController googleLocationController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController npNameController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController sourceNameController = TextEditingController();

  @override
  void initState() {
    final state = ref.read(applicationInfoFormControllerProvider);
    dateConductedController.text =
        state.dateConducted?.formatFromIsoToDDMMYYY() ?? '';
    conductedByController.text = state.conductedBy ?? '';
    googleLocationController.text = state.googleLocation ?? '';
    districtController.text = state.district ?? '';
    npNameController.text = state.npName ?? '';
    sourceController.text = state.source ?? '';
    sourceNameController.text = state.sourceName ?? '';
    super.initState();
  }

  @override
  void dispose() {
    dateConductedController.dispose();
    conductedByController.dispose();
    googleLocationController.dispose();
    districtController.dispose();
    npNameController.dispose();
    sourceController.dispose();
    sourceNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.read(applicationInfoFormControllerProvider.notifier);
    final state = ref.read(applicationInfoFormControllerProvider);
    return SectionDetailCard(
      title: "Applicant Info",
      children: [
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Applicant ID",
          hintText: state.applicantId ?? "e.g. 2196",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Entry Code",
          hintText: state.entryCode ?? "e.g. TGPL-2196",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Date Conducted",
          hintText: "dd/mm/yyyy",
          controller: dateConductedController,
          onTap: () {
            customDatePicker(
              context: context,
              onUserSelectedDate: (date) {
                dateConductedController.text = date.formatToDDMMYYY();
                controller.updateConductedInfo(
                  dateConducted: date.toIso8601String(),
                );
              },
            );
          },
          showClearButton: true,
          onClear: () {
            dateConductedController.clear();
            controller.clearField('dateConducted');
          },
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Conducted By",
          hintText: "e.g. Asif",
          controller: conductedByController,
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
          hintText: "e.g. Tap to select location",
          readOnly: true,
          controller: googleLocationController,
          suffixIcon: actionContainer(
            icon: AppImages.locationIconSvg,
            iconColor: AppColors.black,
            rightMargin: 5,
            onTap: () async {
              LocationData? selectedLocation = await ref
                  .read(goRouterProvider)
                  .push(AppRoutes.siteLocationSelection);
              if (selectedLocation != null) {
                googleLocationController.text =
                    "${selectedLocation.position.latitude}, ${selectedLocation.position.longitude}";
                controller.updateLocation(
                  googleLocation: googleLocationController.text,
                );
              }
            },
          ),
        ),
        const SizedBox(height: 10),
        Consumer(
          builder: (context, ref, child) {
            final selectedCity = ref
                .watch(applicationInfoFormControllerProvider.select(
                    (state) => state.selectedCity));
            return SmartCustomDropDownWithTitle(
              title: "City",
              hintText: "e.g. Select city",
              enableSearch: true,
              selectedItem: selectedCity,
              asyncProvider: cityNamesProvider,
              itemsBuilder: (cities) => cities.map((city) => city.name).toList(),
              onChanged: (value) {
                if (value == null) return;
                controller.updateLocation(city: value.toString());
              },
              validator: (v) => v.validate(),
              showClearButton: true,
              onClear: () {
                controller.clearField('selectedCity');
              },
            );
          }
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "District",
          hintText: "e.g. Lahore",
          validator: (v) => v.validate(),
          controller: districtController,
          onChanged: (value) {
            controller.updateLocation(district: value);
          },
          showClearButton: true,
          onClear: () {
            controller.clearField('district');
          },
        ),
        const SizedBox(height: 10),
        Consumer(
          builder: (context, ref, child) {
            final selectedSiteStatus = ref
                .watch(applicationInfoFormControllerProvider.select(
                    (state) => state.siteStatus));
            return SmartCustomDropDownWithTitle(
              title: "Site Status",
              selectedItem: selectedSiteStatus,
              hintText: "e.g. Select site status",
              asyncProvider: siteStatusesProvider,
              itemsBuilder: (statuses) =>
                  statuses.map((status) => status.name).toList(),
              onChanged: (value) {
                if (value == null) return;
                controller.updateSiteInfo(status: value.toString());
              },
              showClearButton: true,
              onClear: () {
                controller.clearField('siteStatus');
              },
              validator: (v) => v.validate(),
            );
          }
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "NP. Name",
          hintText: "e.g. Kashif",
          controller: npNameController,
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
          hintText: "e.g. Dealer",
          controller: sourceController,
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
          hintText: "e.g. TGPL Dealer",
          controller: sourceNameController,
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
        Consumer(
          builder: (context, ref, child) {
            final selectedPriority = ref
                .watch(applicationInfoFormControllerProvider.select(
                    (state) => state.selectedPriority));
            return SmartCustomDropDownWithTitle(
              title: "Priority",
              selectedItem: selectedPriority,
              asyncProvider: prioritiesProvider,
              hintText: "e.g. Select site priority",
              itemsBuilder: (priorities) => priorities,
              onChanged: (value) {
                if (value == null) return;
                controller.updateSiteInfo(priority: value.toString());
              },
              validator: (v) => v.validate(),
              showClearButton: true,
              onClear: () {
                controller.clearField('selectedPriority');
              },
            );
          }
        ),
      ],
    );
  }
}
