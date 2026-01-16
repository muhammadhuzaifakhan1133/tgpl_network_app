import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/city_names_provider.dart';
import 'package:tgpl_network/common/providers/priorities_provider.dart';
import 'package:tgpl_network/common/providers/site_statuses_provider.dart';
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
import 'package:tgpl_network/utils/datetime_extension.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

class ApplicantInfoFormCard extends ConsumerWidget {
  const ApplicantInfoFormCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(applicationInfoFormControllerProvider.notifier);
    final state = ref.watch(applicationInfoFormControllerProvider);

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
  hintText: state.dateConducted ?? "01/01/2024",
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
)
,
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Conducted By",
          hintText: "Asif",
          initialValue: state.conductedBy,
          validator: (v) => v.validate(),
          onChanged: (value) {
            controller.updateConductedInfo(conductedBy: value);
          },
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
  title: "Google Location*",
  hintText: state.googleLocation ?? "Tap to select location",
  readOnly: true,
  suffixIcon: actionContainer(
    icon: AppImages.locationIconSvg,
    iconColor: AppColors.black,
    rightMargin: 5,
    onTap: () async {
      final selectedLocation = await ref
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
)
,
        const SizedBox(height: 10),
        CustomDropDownWithTitle(
          title: "City",
          hintText: "Select city",
          enableSearch: true,
          selectedItem: state.selectedCity,
          items: ref.read(cityNamesProvider),
          onChanged: (value) {
            if (value == null) return;
            controller.updateLocation(city: value.toString());
          },
          validator: (v) => v.validate(),
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
        ),
        const SizedBox(height: 10),
        CustomDropDownWithTitle(
          title: "Priority",
          selectedItem: state.selectedPriority,
          hintText: "Select site priority",
          items: ref.read(prioritiesProvider),
          onChanged: (value) {
            if (value == null) return;
            controller.updateSiteInfo(priority: value.toString());
          },
          validator: (v) => v.validate(),
        ),
      ],
    );
  }
}
