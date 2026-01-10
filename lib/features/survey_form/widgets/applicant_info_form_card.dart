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
import 'package:tgpl_network/features/station_form/presentation/forms/step3/site_location_selection/site_location_selection_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/routes/app_routes.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

class ApplicantInfoFormCard extends ConsumerWidget {
  const ApplicantInfoFormCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    Future<void> navigateToSiteLocationSelection() async {
      LocationData? selectedLocation = await ref
          .read(goRouterProvider)
          .push(AppRoutes.siteLocationSelection);
      if (selectedLocation != null) {
        // Handle selected location if needed
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
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Entry Code",
            hintText: "TGPL-2196",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Currently Presence",
            hintText: "Karachi",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Date Conducted",
            hintText: "01/01/2024",
            onTap: () {
              // Implement date picker logic here
            },
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Conducted By",
            hintText: "Asif",
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
              validator: (v) => v.validate(),
            ),
            Consumer(
              builder: (context, ref, child) {
                // final selectedCity = ref.watch(
                //   step2FormControllerProvider.select((s) => s.selectedCity),
                // );
                return CustomDropDownWithTitle(
                  title: "City",
                  hintText: "Select city",
                  enableSearch: true,
                  selectedItem: "Karachi", // selectedCity,
                  items: ref.read(cityNamesProvider),
                  onChanged: (value) {
                    if (value == null) return;
                    // controller.onCityChange(value.toString());
                  },
                  validator: (v) => v.validate(),
                );
              },
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (context, ref, child) {
                // final selectedStatus = ref.watch(
                //   step2FormControllerProvider.select(
                //     (s) => s.selectedSiteStatus,
                //   ),
                // );
                return CustomDropDownWithTitle(
                  title: "Site Status",
                  selectedItem: "New Plot", // selectedStatus,
                  hintText: "Select site status",
                  items: ref.read(siteStatusesProvider),
                  onChanged: (value) {
                    if (value == null) return;
                    // ref
                    //     .read(step2FormControllerProvider.notifier)
                    //     .onSiteStatusChange(value.toString());
                  },
                  validator: (v) => v.validate(),
                );
              },
            ),
            const SizedBox(height: 15),
            Consumer(
              builder: (context, ref, child) {
                // final selectedPriority = ref.watch(
                //   step2FormControllerProvider.select((s) => s.selectedPriority),
                // );
                return CustomDropDownWithTitle(
                  title: "Priority",
                  selectedItem: "High",
                  hintText: "Select site priority",
                  items: ref.read(prioritiesProvider),
                  onChanged: (value) {
                    if (value == null) return;
                    // ref
                    //     .read(step2FormControllerProvider.notifier)
                    //     .onPriorityChange(value.toString());
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
