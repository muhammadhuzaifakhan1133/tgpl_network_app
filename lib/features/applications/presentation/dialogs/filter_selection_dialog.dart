import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tgpl_network/common/providers/city_names_provider.dart';
import 'package:tgpl_network/common/providers/priorities_provider.dart';
import 'package:tgpl_network/common/providers/statuses_provider.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_images.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/applications/presentation/dialogs/filter_selection_dialog_controller.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/utils/custom_date_picker.dart';
import 'package:tgpl_network/utils/datetime_extension.dart';
import 'package:tgpl_network/utils/yes_no_enum_with_extension.dart';

Future<dynamic> filterSelectionDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return Consumer(
        builder: (context, ref, child) {
          final controller = ref.read(
            filterSelectionDialogControllerProvider.notifier,
          );
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(16),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    "Filters",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextstyles.googleInter700black28.copyWith(
                      color: AppColors.black2Color,
                      fontSize: 20,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ref.read(goRouterProvider).pop();
                  },
                  icon: SvgPicture.asset(AppImages.crossIconSvg),
                ),
              ],
            ),
            actions: [
              CustomButton(onPressed: () {}, text: "Clear All Filters"),
              const SizedBox(height: 12),
              CustomButton(
                onPressed: () {},
                text: "Apply",
                backgroundColor: AppColors.nextStep1Color,
              ),
            ],
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            content: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFieldWithTitle(
                            onTap: () {
                              customDatePicker(
                                context: context,
                                onUserSelectedDate: (date) {
                                  controller.fromDateController.text = date
                                      .formatToDDMMYYY();
                                },
                              );
                            },
                            title: "Date From",
                            hintText: "dd/mm/yyyy",
                            readOnly: true,
                            controller: controller.fromDateController,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomTextFieldWithTitle(
                            onTap: () {
                              customDatePicker(
                                context: context,
                                onUserSelectedDate: (date) {
                                  controller.toDateController.text = date
                                      .formatToDDMMYYY();
                                },
                              );
                            },
                            title: "Date To",
                            hintText: "dd/mm/yyyy",
                            readOnly: true,
                            controller: controller.toDateController,
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
                                hintText: "Status",
                                onChanged: (v) {
                                  if (v == null) return;
                                  controller.onChangeStatus(v);
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
                          child: CustomTextFieldWithTitle(
                            onTap: () {
                              customDatePicker(
                                context: context,
                                onUserSelectedDate: (date) {
                                  controller.receiveDateController.text = date
                                      .formatToDDMMYYY();
                                },
                              );
                            },
                            title: "Recev. Date",
                            hintText: "dd/mm/yyyy",
                            readOnly: true,
                            controller: controller.receiveDateController,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomTextFieldWithTitle(
                            onTap: () {
                              customDatePicker(
                                context: context,
                                onUserSelectedDate: (date) {
                                  controller.condDateController.text = date
                                      .formatToDDMMYYY();
                                },
                              );
                            },
                            title: "Cond. Date",
                            hintText: "dd/mm/yyyy",
                            readOnly: true,
                            controller: controller.condDateController,
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
                    const SizedBox(height: 6),
                    Divider(),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        _YesNoDropDownField(
                          title: "Survey Profile",
                          selectYesNoField: (s) => s.surveyProfile,
                          onChangeValue: (v) =>
                              controller.onChangeYesNoField(surveyProfile: v),
                        ),
                        const SizedBox(width: 10),
                        _YesNoDropDownField(
                          title: "Traffic Trade",
                          selectYesNoField: (s) => s.trafficTrade,
                          onChangeValue: (v) =>
                              controller.onChangeYesNoField(trafficTrade: v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Row(
                      children: [
                        _YesNoDropDownField(
                          title: "Feasibility",
                          selectYesNoField: (s) => s.feasibility,
                          onChangeValue: (v) =>
                              controller.onChangeYesNoField(feasibility: v),
                        ),
                        const SizedBox(width: 10),
                        _YesNoDropDownField(
                          title: "Negotiation",
                          selectYesNoField: (s) => s.negotiation,
                          onChangeValue: (v) =>
                              controller.onChangeYesNoField(negotiation: v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Row(
                      children: [
                        _YesNoDropDownField(
                          title: "MOU Sign",
                          selectYesNoField: (s) => s.mouSign,
                          onChangeValue: (v) =>
                              controller.onChangeYesNoField(mouSign: v),
                        ),
                        const SizedBox(width: 10),
                        _YesNoDropDownField(
                          title: "Joining Fee",
                          selectYesNoField: (s) => s.joiningFee,
                          onChangeValue: (v) =>
                              controller.onChangeYesNoField(joiningFee: v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Row(
                      children: [
                        _YesNoDropDownField(
                          title: "Franchise Agreement",
                          selectYesNoField: (s) => s.franchiseAgreement,
                          onChangeValue: (v) => controller.onChangeYesNoField(
                            franchiseAgreement: v,
                          ),
                        ),
                        const SizedBox(width: 10),
                        _YesNoDropDownField(
                          title: "Feasibility Finalization",
                          selectYesNoField: (s) => s.feasibilityFinalization,
                          onChangeValue: (v) => controller.onChangeYesNoField(
                            feasibilityFinalization: v,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Row(
                      children: [
                        _YesNoDropDownField(
                          title: "Explosive Layout",
                          selectYesNoField: (s) => s.explosiveLayout,
                          onChangeValue: (v) =>
                              controller.onChangeYesNoField(explosiveLayout: v),
                        ),
                        const SizedBox(width: 10),
                        _YesNoDropDownField(
                          title: "Drawing",
                          selectYesNoField: (s) => s.drawing,
                          onChangeValue: (v) =>
                              controller.onChangeYesNoField(drawing: v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Row(
                      children: [
                        _YesNoDropDownField(
                          title: "Topography",
                          selectYesNoField: (s) => s.topography,
                          onChangeValue: (v) =>
                              controller.onChangeYesNoField(topography: v),
                        ),
                        const SizedBox(width: 10),
                        _YesNoDropDownField(
                          title: "Issuance of Drawing",
                          selectYesNoField: (s) => s.issuanceOfDrawing,
                          onChangeValue: (v) => controller.onChangeYesNoField(
                            issuanceOfDrawing: v,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Row(
                      children: [
                        _YesNoDropDownField(
                          title: "Appl. in Expl.",
                          selectYesNoField: (s) => s.appliedInExplosive,
                          onChangeValue: (v) => controller.onChangeYesNoField(
                            appliedInExplosive: v,
                          ),
                        ),
                        const SizedBox(width: 10),
                        _YesNoDropDownField(
                          title: "DC NOC",
                          selectYesNoField: (s) => s.dcNoc,
                          onChangeValue: (v) =>
                              controller.onChangeYesNoField(dcNoc: v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Row(
                      children: [
                        _YesNoDropDownField(
                          title: "Capex",
                          selectYesNoField: (s) => s.capex,
                          onChangeValue: (v) =>
                              controller.onChangeYesNoField(capex: v),
                        ),
                        const SizedBox(width: 10),
                        _YesNoDropDownField(
                          title: "Lease Agreement",
                          selectYesNoField: (s) => s.leaseAgreement,
                          onChangeValue: (v) =>
                              controller.onChangeYesNoField(leaseAgreement: v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Row(
                      children: [
                        _YesNoDropDownField(
                          title: "HOTO",
                          selectYesNoField: (s) => s.hoto,
                          onChangeValue: (v) =>
                              controller.onChangeYesNoField(hoto: v),
                        ),
                        const SizedBox(width: 10),
                        _YesNoDropDownField(
                          title: "Construction",
                          selectYesNoField: (s) => s.construction,
                          onChangeValue: (v) =>
                              controller.onChangeYesNoField(construction: v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                    Row(
                      children: [
                        _YesNoDropDownField(
                          title: "Inauguration",
                          selectYesNoField: (s) => s.inauguration,
                          onChangeValue: (v) =>
                              controller.onChangeYesNoField(inauguration: v),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

class _YesNoDropDownField extends StatelessWidget {
  final YesNo? Function(FilterSelectionDialogState) selectYesNoField;
  final String title;
  final void Function(YesNo value) onChangeValue;
  const _YesNoDropDownField({
    required this.selectYesNoField,
    required this.title,
    required this.onChangeValue,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final selectedValue = ref.watch(
          filterSelectionDialogControllerProvider.select(
            (s) => selectYesNoField(s),
          ),
        );
        return Expanded(
          child: CustomDropDownWithTitle(
            title: title,
            items: YesNo.values,
            displayString: (item) => item.label,
            hintText: "Yes/No",
            onChanged: (v) {
              if (v == null) return;
              onChangeValue(v);
            },
            selectedItem: selectedValue,
          ),
        );
      },
    );
  }
}
