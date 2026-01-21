import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/master_data/providers/city_names_provider.dart';
import 'package:tgpl_network/features/master_data/providers/priorities_provider.dart';
import 'package:tgpl_network/features/master_data/providers/statuses_provider.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/applications_filter/applications_filter_controller.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/features/applications_filter/widgets/yes_no_dropdown_field.dart';
import 'package:tgpl_network/utils/custom_date_picker.dart';
import 'package:tgpl_network/utils/datetime_extension.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(applicationFiltersProvider.notifier);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            CustomAppBar(
              title: "Filter",
              subtitle: "Refine your search",
              showBackButton: true,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Consumer(
                              builder: (context, ref, child) {
                                final selectedFromDate = ref.watch(
                                  applicationFiltersProvider.select(
                                    (s) => s.fromDate,
                                  ),
                                );
                                return CustomTextFieldWithTitle(
                                  onTap: () {
                                    customDatePicker(
                                      context: context,
                                      onUserSelectedDate: (date) {
                                        controller.updateDates(
                                          fromDate: date.formatToDDMMYYY(),
                                        );
                                      },
                                    );
                                  },
                                  title: "Date From",
                                  hintText: selectedFromDate.orDefault(
                                    "dd/mm/yyyy",
                                  ),
                                  showClearButton:
                                      !selectedFromDate.isNullOrEmpty,
                                  readOnly: true,
                                  onClear: () {
                                    controller.clearFields(["fromDate"]);
                                  },
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Consumer(
                              builder: (context, ref, child) {
                                final selectedToDate = ref.watch(
                                  applicationFiltersProvider.select(
                                    (s) => s.toDate,
                                  ),
                                );
                                return CustomTextFieldWithTitle(
                                  onTap: () {
                                    customDatePicker(
                                      context: context,
                                      onUserSelectedDate: (date) {
                                        controller.updateDates(
                                          toDate: date.formatToDDMMYYY(),
                                        );
                                      },
                                    );
                                  },
                                  title: "Date To",
                                  hintText: selectedToDate.orDefault(
                                    "dd/mm/yyyy",
                                  ),
                                  readOnly: true,
                                  onClear: () {
                                    controller.clearFields(["toDate"]);
                                  },
                                  showClearButton:
                                      !selectedToDate.isNullOrEmpty,
                                );
                              },
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
                                applicationFiltersProvider.select(
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
                                    controller.updateDropdown(city: v);
                                  },
                                  selectedItem: selectedCity,
                                  showClearButton: !selectedCity.isNullOrEmpty,
                                  onClear: () {
                                    controller.clearFields(["selectedCity"]);
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                          Consumer(
                            builder: (context, ref, child) {
                              final selectedPriority = ref.watch(
                                applicationFiltersProvider.select(
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
                                    controller.updateDropdown(priority: v);
                                  },
                                  selectedItem: selectedPriority,
                                  showClearButton:
                                      !selectedPriority.isNullOrEmpty,
                                  onClear: () {
                                    controller.clearFields([
                                      "selectedPriority",
                                    ]);
                                  },
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
                                applicationFiltersProvider.select(
                                  (s) => s.selectedStatus,
                                ),
                              );
                              return Expanded(
                                child: CustomDropDownWithTitle(
                                  title: "Status",
                                  items: ref.read(statusesProvider),
                                  hintText: "Status",
                                  onChanged: (v) {
                                    if (v == null) return;
                                    controller.updateDropdown(status: v);
                                  },
                                  selectedItem: selectedStatus,
                                  showClearButton:
                                      !selectedStatus.isNullOrEmpty,
                                  onClear: () {
                                    controller.clearFields(["selectedStatus"]);
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Site Name",
                              hintText: "Site Name",
                              onChanged: (v) {
                                controller.updateTextFields(siteName: v);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          Expanded(
                            child: Consumer(
                              builder: (context, ref, child) {
                                final selectedReceiveDate = ref.watch(
                                  applicationFiltersProvider.select(
                                    (s) => s.receiveDate,
                                  ),
                                );
                                return CustomTextFieldWithTitle(
                                  onTap: () {
                                    customDatePicker(
                                      context: context,
                                      onUserSelectedDate: (date) {
                                        controller.updateDates(
                                          receiveDate: date.formatToDDMMYYY(),
                                        );
                                      },
                                    );
                                  },
                                  title: "Recev. Date",
                                  hintText: selectedReceiveDate.orDefault(
                                    "dd/mm/yyyy",
                                  ),
                                  readOnly: true,
                                  onClear: () {
                                    controller.clearFields(["receiveDate"]);
                                  },
                                  showClearButton:
                                      !selectedReceiveDate.isNullOrEmpty,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Consumer(
                              builder: (context, ref, child) {
                                final selectedCondDate = ref.watch(
                                  applicationFiltersProvider.select(
                                    (s) => s.condDate,
                                  ),
                                );
                                return CustomTextFieldWithTitle(
                                  onTap: () {
                                    customDatePicker(
                                      context: context,
                                      onUserSelectedDate: (date) {
                                        controller.updateDates(
                                          condDate: date.formatToDDMMYYY(),
                                        );
                                      },
                                    );
                                  },
                                  title: "Cond. Date",
                                  hintText: selectedCondDate.orDefault(
                                    "dd/mm/yyyy",
                                  ),
                                  controller: TextEditingController(
                                    text: selectedCondDate ?? "",
                                  ),
                                  readOnly: true,
                                  onClear: () {
                                    controller.clearFields(["condDate"]);
                                  },
                                  showClearButton:
                                      !selectedCondDate.isNullOrEmpty,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Application #",
                              hintText: "Application #",
                              onChanged: (v) {
                                controller.updateTextFields(applicationId: v);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Entry Code",
                              hintText: "Entry Code",
                              onChanged: (v) {
                                controller.updateTextFields(entryCode: v);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Prepared By",
                              hintText: "Prepared By",
                              onChanged: (v) {
                                controller.updateTextFields(preparedBy: v);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "District",
                              hintText: "District",
                              onChanged: (v) {
                                controller.updateTextFields(district: v);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Dealer Name",
                              hintText: "Dealer Name",
                              onChanged: (v) {
                                controller.updateTextFields(dealerName: v);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Dealer Contact",
                              hintText: "Dealer Contact",
                              onChanged: (v) {
                                controller.updateTextFields(dealerContact: v);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Address",
                              hintText: "Address",
                              onChanged: (v) {
                                controller.updateTextFields(address: v);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Referred By",
                              hintText: "Referred By",
                              onChanged: (v) {
                                controller.updateTextFields(referredBy: v);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Source",
                              hintText: "Source",
                              onChanged: (v) {
                                controller.updateTextFields(source: v);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Source Name",
                              hintText: "Source Name",
                              onChanged: (v) {
                                controller.updateTextFields(sourceName: v);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Divider(),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "Survey Profile",
                            fieldName: "surveyProfile",
                            selectYesNoField: (s) => s.surveyProfile,
                            onChangeValue: (v) =>
                                controller.updateYesNo(surveyProfile: v),
                          ),
                          const SizedBox(width: 10),
                          YesNoDropDownField(
                            title: "Traffic Trade",
                            fieldName: "trafficTrade",
                            selectYesNoField: (s) => s.trafficTrade,
                            onChangeValue: (v) =>
                                controller.updateYesNo(trafficTrade: v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "Feasibility",
                            fieldName: "feasibility",
                            selectYesNoField: (s) => s.feasibility,
                            onChangeValue: (v) =>
                                controller.updateYesNo(feasibility: v),
                          ),
                          const SizedBox(width: 10),
                          YesNoDropDownField(
                            title: "Negotiation",
                            fieldName: "negotiation",
                            selectYesNoField: (s) => s.negotiation,
                            onChangeValue: (v) =>
                                controller.updateYesNo(negotiation: v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "MOU Sign",
                            fieldName: "mouSign",
                            selectYesNoField: (s) => s.mouSign,
                            onChangeValue: (v) =>
                                controller.updateYesNo(mouSign: v),
                          ),
                          const SizedBox(width: 10),
                          YesNoDropDownField(
                            title: "Joining Fee",
                            fieldName: "joiningFee",
                            selectYesNoField: (s) => s.joiningFee,
                            onChangeValue: (v) =>
                                controller.updateYesNo(joiningFee: v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "Franchise Agreement",
                            fieldName: "franchiseAgreement",
                            selectYesNoField: (s) => s.franchiseAgreement,
                            onChangeValue: (v) =>
                                controller.updateYesNo(franchiseAgreement: v),
                          ),
                          const SizedBox(width: 10),
                          YesNoDropDownField(
                            title: "Feasibility Finalization",
                            fieldName: "feasibilityFinalization",
                            selectYesNoField: (s) => s.feasibilityFinalization,
                            onChangeValue: (v) => controller.updateYesNo(
                              feasibilityFinalization: v,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "Explosive Layout",
                            fieldName: "explosiveLayout",
                            selectYesNoField: (s) => s.explosiveLayout,
                            onChangeValue: (v) =>
                                controller.updateYesNo(explosiveLayout: v),
                          ),
                          const SizedBox(width: 10),
                          YesNoDropDownField(
                            title: "Drawing",
                            fieldName: "drawing",
                            selectYesNoField: (s) => s.drawing,
                            onChangeValue: (v) =>
                                controller.updateYesNo(drawing: v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "Topography",
                            fieldName: "topography",
                            selectYesNoField: (s) => s.topography,
                            onChangeValue: (v) =>
                                controller.updateYesNo(topography: v),
                          ),
                          const SizedBox(width: 10),
                          YesNoDropDownField(
                            title: "Issuance of Drawing",
                            fieldName: "issuanceOfDrawing",
                            selectYesNoField: (s) => s.issuanceOfDrawing,
                            onChangeValue: (v) =>
                                controller.updateYesNo(issuanceOfDrawing: v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "Appl. in Expl.",
                            fieldName: "appliedInExplosive",
                            selectYesNoField: (s) => s.appliedInExplosive,
                            onChangeValue: (v) =>
                                controller.updateYesNo(appliedInExplosive: v),
                          ),
                          const SizedBox(width: 10),
                          YesNoDropDownField(
                            title: "DC NOC",
                            fieldName: "dcNoc",
                            selectYesNoField: (s) => s.dcNoc,
                            onChangeValue: (v) =>
                                controller.updateYesNo(dcNoc: v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "Capex",
                            fieldName: "capex",
                            selectYesNoField: (s) => s.capex,
                            onChangeValue: (v) =>
                                controller.updateYesNo(capex: v),
                          ),
                          const SizedBox(width: 10),
                          YesNoDropDownField(
                            title: "Lease Agreement",
                            fieldName: "leaseAgreement",
                            selectYesNoField: (s) => s.leaseAgreement,
                            onChangeValue: (v) =>
                                controller.updateYesNo(leaseAgreement: v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "HOTO",
                            fieldName: "hoto",
                            selectYesNoField: (s) => s.hoto,
                            onChangeValue: (v) =>
                                controller.updateYesNo(hoto: v),
                          ),
                          const SizedBox(width: 10),
                          YesNoDropDownField(
                            title: "Construction",
                            fieldName: "construction",
                            selectYesNoField: (s) => s.construction,
                            onChangeValue: (v) =>
                                controller.updateYesNo(construction: v),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "Inauguration",
                            fieldName: "inauguration",
                            selectYesNoField: (s) => s.inauguration,
                            onChangeValue: (v) =>
                                controller.updateYesNo(inauguration: v),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                onPressed: controller.clearAll,
                text: "Clear All",
                backgroundColor: AppColors.actionContainerColor,
                textStyle: AppTextstyles.neutra500white22.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "Apply Filters",
                backgroundColor: AppColors.nextStep1Color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
