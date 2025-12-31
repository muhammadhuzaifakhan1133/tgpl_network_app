import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/city_names_provider.dart';
import 'package:tgpl_network/common/providers/priorities_provider.dart';
import 'package:tgpl_network/common/providers/statuses_provider.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/applications/presentation/dialogs/filter_selection_dialog_controller.dart';
import 'package:tgpl_network/utils/datetime_extension.dart';

Future<dynamic> filterSelectionDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        title: Text(
          "Filters",
          style: AppTextstyles.googleInter700black28.copyWith(
            color: AppColors.black2Color,
            fontSize: 20,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        content: Consumer(
          builder: (context, ref, child) {
            final controller = ref.read(
              filterSelectionDialogControllerProvider.notifier,
            );
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.onSelectDate(
                            context: context,
                            onUserSelectedDate: (date) {
                              controller.fromDateController.text = date
                                  .formatToDDMMYYY();
                            },
                          );
                        },
                        child: CustomTextFieldWithTitle(
                          title: "Date From",
                          hintText: "dd/mm/yyyy",
                          enabled: false,
                          controller: controller.fromDateController,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.onSelectDate(
                            context: context,
                            onUserSelectedDate: (date) {
                              controller.toDateController.text = date
                                  .formatToDDMMYYY();
                            },
                          );
                        },
                        child: CustomTextFieldWithTitle(
                          title: "Date To",
                          hintText: "dd/mm/yyyy",
                          enabled: false,
                          controller: controller.toDateController,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                Row(
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        final selectedCity = ref.watch(
                          filterSelectionDialogControllerProvider.select(
                            (s) => s.selectedCity,
                          ),
                        );
                        return Expanded(
                          child: CustomDropDownWithTitle(
                            title: "City",
                            items: ref.read(cityNamesProvider),
                            enableSearch: true,
                            hintText: "City",
                            onChanged: (v) {
                              if (v == null) return;
                              controller.onChangeCity(v);
                            },
                            selectedItem: selectedCity,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    Consumer(
                      builder: (context, ref, child) {
                        final selectedPriority = ref.watch(
                          filterSelectionDialogControllerProvider.select(
                            (s) => s.selectedPriority,
                          ),
                        );
                        return Expanded(
                          child: CustomDropDownWithTitle(
                            title: "Priority",
                            items: ref.read(prioritiesProvider),
                            hintText: "Priority",
                            onChanged: (v) {
                              if (v == null) return;
                              controller.onChangePriority(v);
                            },
                            selectedItem: selectedPriority,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                Row(
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        final selectedStatus = ref.watch(
                          filterSelectionDialogControllerProvider.select(
                            (s) => s.selectedStatus,
                          ),
                        );
                        return Expanded(
                          child: CustomDropDownWithTitle(
                            title: "Status",
                            items: ref.read(statusesProvider),
                            enableSearch: true,
                            hintText: "Status",
                            onChanged: (v) {
                              if (v == null) return;
                              controller.onChangeCity(v);
                            },
                            selectedItem: selectedStatus,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextFieldWithTitle(
                        title: "Site Name",
                        hintText: "Site Name",
                        controller: controller.siteNameController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.onSelectDate(
                            context: context,
                            onUserSelectedDate: (date) {
                              controller.receiveDateController.text = date
                                  .formatToDDMMYYY();
                            },
                          );
                        },
                        child: CustomTextFieldWithTitle(
                          title: "Recev. Date",
                          hintText: "dd/mm/yyyy",
                          enabled: false,
                          controller: controller.receiveDateController,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.onSelectDate(
                            context: context,
                            onUserSelectedDate: (date) {
                              controller.condDateController.text = date
                                  .formatToDDMMYYY();
                            },
                          );
                        },
                        child: CustomTextFieldWithTitle(
                          title: "Cond. Date",
                          hintText: "dd/mm/yyyy",
                          enabled: false,
                          controller: controller.condDateController,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldWithTitle(
                        title: "Application #",
                        hintText: "Application #",
                        controller: controller.applicationIdController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextFieldWithTitle(
                        title: "Entry Code",
                        hintText: "Entry Code",
                        controller: controller.entryCodeController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldWithTitle(
                        title: "Prepared By",
                        hintText: "Prepared By",
                        controller: controller.preparedByController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextFieldWithTitle(
                        title: "District",
                        hintText: "District",
                        controller: controller.districtController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldWithTitle(
                        title: "Dealer Name",
                        hintText: "Dealer Name",
                        controller: controller.dealerNameController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextFieldWithTitle(
                        title: "Dealer Contact",
                        hintText: "Dealer Contact",
                        controller: controller.dealerContactController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldWithTitle(
                        title: "Address",
                        hintText: "Address",
                        controller: controller.addressController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextFieldWithTitle(
                        title: "Referred By",
                        hintText: "Referred By",
                        controller: controller.referredByController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 13),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldWithTitle(
                        title: "Source",
                        hintText: "Source",
                        controller: controller.sourceController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextFieldWithTitle(
                        title: "Source Name",
                        hintText: "Source Name",
                        controller: controller.sourceNameController,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
