import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/city_names_provider.dart';
import 'package:tgpl_network/common/providers/priorities_provider.dart';
import 'package:tgpl_network/common/providers/site_statuses_provider.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/station_form/forms/step2/step2_form_controller.dart';

class Step2FormView extends ConsumerWidget {
  const Step2FormView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Site Information",
              style: AppTextstyles.googleInter700black28.copyWith(fontSize: 24),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Tell us about your proposed site",
              style: AppTextstyles.googleInter400black16,
            ),
          ),
          const SizedBox(height: 24),
          Consumer(
            builder: (context, ref, child) {
              final selectedCity = ref.watch(
                step2FormControllerProvider.select((s) => s.selectedCity),
              );
              return CustomDropDownWithTitle(
                title: "City",
                hintText: "Select city",
                enableSearch: true,
                selectedItem: selectedCity,
                items: ref.read(cityNamesProvider),
                onChanged: (value) {
                  if (value == null) return;
                  ref
                      .read(step2FormControllerProvider.notifier)
                      .onCityChange(value.toString());
                },
              );
            },
          ),
          const SizedBox(height: 16),
          Consumer(
            builder: (context, ref, child) {
              final selectedStatus = ref.watch(
                step2FormControllerProvider.select((s) => s.selectedSiteStatus),
              );
              return CustomDropDownWithTitle(
                title: "Site Status",
                selectedItem: selectedStatus,
                hintText: "Select site status",
                items: ref.read(siteStatusesProvider),
                onChanged: (value) {
                  if (value == null) return;
                  ref
                      .read(step2FormControllerProvider.notifier)
                      .onSiteStatusChange(value.toString());
                },
              );
            },
          ),
          const SizedBox(height: 15),
          Consumer(
            builder: (context, ref, child) {
              final selectedPriority = ref.watch(
                step2FormControllerProvider.select((s) => s.selectedPriority),
              );
              return CustomDropDownWithTitle(
                title: "Priority",
                selectedItem: selectedPriority,
                hintText: "Select site priority",
                items: ref.read(prioritiesProvider),
                onChanged: (value) {
                  if (value == null) return;
                  ref
                      .read(step2FormControllerProvider.notifier)
                      .onPriorityChange(value.toString());
                },
              );
            },
          ),
          const SizedBox(height: 15),
          CustomTextFieldWithTitle(title: "Source*", hintText: "Source"),
          const SizedBox(height: 15),
          CustomTextFieldWithTitle(
            title: "Source Name*",
            hintText: "Source Name",
          ),
        ],
      ),
    );
  }
}
