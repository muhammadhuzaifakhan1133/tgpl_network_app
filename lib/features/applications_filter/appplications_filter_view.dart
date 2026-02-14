import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/utils/custom_date_picker.dart';
import 'package:tgpl_network/utils/extensions/datetime_extension.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(filterSelectionProvider.notifier);
    final state = ref.read(filterSelectionProvider);
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
            SizedBox(height: 10.h),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Consumer(
                              builder: (context, ref, child) {
                                final selectedFromDate = ref.watch(
                                  filterSelectionProvider.select(
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
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Consumer(
                              builder: (context, ref, child) {
                                final selectedToDate = ref.watch(
                                  filterSelectionProvider.select(
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
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              final selectedCity = ref.watch(
                                filterSelectionProvider.select(
                                  (s) => s.selectedCity,
                                ),
                              );
                              return Expanded(
                                child: SmartCustomDropDownWithTitle(
                                  title: "City",
                                  asyncProvider: cityNamesProvider,
                                  itemsBuilder: (city) =>
                                      city.map((e) => e.name).toList(),
                                  enableSearch: true,
                                  hintText: "Select City",
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
                          SizedBox(width: 10.w),
                          Consumer(
                            builder: (context, ref, child) {
                              final selectedPriority = ref.watch(
                                filterSelectionProvider.select(
                                  (s) => s.selectedPriority,
                                ),
                              );
                              return Expanded(
                                child: SmartCustomDropDownWithTitle(
                                  title: "Priority",
                                  asyncProvider: prioritiesProvider,
                                  itemsBuilder: (data) => data,
                                  hintText: "Select Priority",
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
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              final statuses = ref.read(statusesProvider);
                              final selectedStatus = ref.watch(
                                filterSelectionProvider.select(
                                  (s) => s.selectedStatusId,
                                ),
                              );
                              return Expanded(
                                child: SmartCustomDropDownWithTitle(
                                  title: "Status",
                                  items: statuses.entries
                                      .map((e) => e.key)
                                      .toList(),
                                  hintText: "Status",
                                  onChanged: (v) {
                                    if (v == null) return;
                                    controller.updateDropdown(
                                      statusId: statuses[v]!,
                                    );
                                  },
                                  selectedItem: selectedStatus != null
                                      ? statuses.entries
                                            .firstWhere(
                                              (entry) =>
                                                  entry.value == selectedStatus,
                                            )
                                            .key
                                      : null,
                                  showClearButton:
                                      !selectedStatus.isNullOrEmpty,
                                  onClear: () {
                                    controller.clearFields([
                                      "selectedStatusId",
                                    ]);
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Site Name",
                              hintText: "Site Name",
                              initialValue: state.siteName,
                              onChanged: (v) {
                                controller.updateTextFields(siteName: v);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Dealer Name",
                              hintText: "Dealer Name",
                              initialValue: state.dealerName,
                              onChanged: (v) {
                                controller.updateTextFields(dealerName: v);
                              },
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Dealer Contact",
                              hintText: "Dealer Contact",
                              initialValue: state.dealerContact,
                              onChanged: (v) {
                                controller.updateTextFields(dealerContact: v);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Application #",
                              hintText: "Application #",
                              initialValue: state.applicationId,
                              onChanged: (v) {
                                controller.updateTextFields(applicationId: v);
                              },
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Entry Code",
                              hintText: "Entry Code",
                              initialValue: state.entryCode,
                              onChanged: (v) {
                                controller.updateTextFields(entryCode: v);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Prepared By",
                              hintText: "Prepared By",
                              initialValue: state.preparedBy,
                              onChanged: (v) {
                                controller.updateTextFields(preparedBy: v);
                              },
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "District",
                              hintText: "District",
                              initialValue: state.district,
                              onChanged: (v) {
                                controller.updateTextFields(district: v);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Address",
                              hintText: "Address",
                              initialValue: state.address,
                              onChanged: (v) {
                                controller.updateTextFields(address: v);
                              },
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Referred By",
                              hintText: "Referred By",
                              initialValue: state.referredBy,
                              onChanged: (v) {
                                controller.updateTextFields(referredBy: v);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Source",
                              hintText: "Source",
                              initialValue: state.source,
                              onChanged: (v) {
                                controller.updateTextFields(source: v);
                              },
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: CustomTextFieldWithTitle(
                              showClearButton: true,
                              title: "Source Name",
                              hintText: "Source Name",
                              initialValue: state.sourceName,
                              onChanged: (v) {
                                controller.updateTextFields(sourceName: v);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Divider(),
                      SizedBox(height: 7.h),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "Survey Profile",
                            fieldName: "surveyProfile",
                            selectYesNoField: (s) => s.surveyProfile,
                            onChangeValue: (v) =>
                                controller.updateYesNo(surveyProfile: v),
                          ),
                          SizedBox(width: 10.w),
                          YesNoDropDownField(
                            title: "Traffic Trade",
                            fieldName: "trafficTrade",
                            selectYesNoField: (s) => s.trafficTrade,
                            onChangeValue: (v) =>
                                controller.updateYesNo(trafficTrade: v),
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "Feasibility",
                            fieldName: "feasibility",
                            selectYesNoField: (s) => s.feasibility,
                            onChangeValue: (v) =>
                                controller.updateYesNo(feasibility: v),
                          ),
                          SizedBox(width: 10.w),
                          YesNoDropDownField(
                            title: "Negotiation",
                            fieldName: "negotiation",
                            selectYesNoField: (s) => s.negotiation,
                            onChangeValue: (v) =>
                                controller.updateYesNo(negotiation: v),
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "MOU Sign",
                            fieldName: "mouSign",
                            selectYesNoField: (s) => s.mouSign,
                            onChangeValue: (v) =>
                                controller.updateYesNo(mouSign: v),
                          ),
                          SizedBox(width: 10.w),
                          YesNoDropDownField(
                            title: "Joining Fee",
                            fieldName: "joiningFee",
                            selectYesNoField: (s) => s.joiningFee,
                            onChangeValue: (v) =>
                                controller.updateYesNo(joiningFee: v),
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "Franchise Agreement",
                            fieldName: "franchiseAgreement",
                            selectYesNoField: (s) => s.franchiseAgreement,
                            onChangeValue: (v) =>
                                controller.updateYesNo(franchiseAgreement: v),
                          ),
                          SizedBox(width: 10.w),
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
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "Explosive Layout",
                            fieldName: "explosiveLayout",
                            selectYesNoField: (s) => s.explosiveLayout,
                            onChangeValue: (v) =>
                                controller.updateYesNo(explosiveLayout: v),
                          ),
                          SizedBox(width: 10.w),
                          YesNoDropDownField(
                            title: "Drawing",
                            fieldName: "drawing",
                            selectYesNoField: (s) => s.drawing,
                            onChangeValue: (v) =>
                                controller.updateYesNo(drawing: v),
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "Topography",
                            fieldName: "topography",
                            selectYesNoField: (s) => s.topography,
                            onChangeValue: (v) =>
                                controller.updateYesNo(topography: v),
                          ),
                          SizedBox(width: 10.w),
                          YesNoDropDownField(
                            title: "Issuance of Drawing",
                            fieldName: "issuanceOfDrawing",
                            selectYesNoField: (s) => s.issuanceOfDrawing,
                            onChangeValue: (v) =>
                                controller.updateYesNo(issuanceOfDrawing: v),
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "Appl. in Expl.",
                            fieldName: "appliedInExplosive",
                            selectYesNoField: (s) => s.appliedInExplosive,
                            onChangeValue: (v) =>
                                controller.updateYesNo(appliedInExplosive: v),
                          ),
                          SizedBox(width: 10.w),
                          YesNoDropDownField(
                            title: "DC NOC",
                            fieldName: "dcNoc",
                            selectYesNoField: (s) => s.dcNoc,
                            onChangeValue: (v) =>
                                controller.updateYesNo(dcNoc: v),
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "Capex",
                            fieldName: "capex",
                            selectYesNoField: (s) => s.capex,
                            onChangeValue: (v) =>
                                controller.updateYesNo(capex: v),
                          ),
                          SizedBox(width: 10.w),
                          YesNoDropDownField(
                            title: "Lease Agreement",
                            fieldName: "leaseAgreement",
                            selectYesNoField: (s) => s.leaseAgreement,
                            onChangeValue: (v) =>
                                controller.updateYesNo(leaseAgreement: v),
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
                      Row(
                        children: [
                          YesNoDropDownField(
                            title: "HOTO",
                            fieldName: "hoto",
                            selectYesNoField: (s) => s.hoto,
                            onChangeValue: (v) =>
                                controller.updateYesNo(hoto: v),
                          ),
                          SizedBox(width: 10.w),
                          YesNoDropDownField(
                            title: "Construction",
                            fieldName: "construction",
                            selectYesNoField: (s) => s.construction,
                            onChangeValue: (v) =>
                                controller.updateYesNo(construction: v),
                          ),
                        ],
                      ),
                      SizedBox(height: 13.h),
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                onPressed: () {
                  controller.clearAll();
                  ref.read(goRouterProvider).pop(false);
                },
                text: "Clear All",
                backgroundColor: AppColors.actionContainerColor,
                textStyle: AppTextstyles.neutra500white22.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CustomButton(
                onPressed: () {
                  ref.read(goRouterProvider).pop(true);
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
