import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/city_names_provider.dart';
import 'package:tgpl_network/common/providers/priorities_provider.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/applications/presentation/dialogs/filter_selection_dialog_controller.dart';

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
                        child: CustomTextFieldWithTitle(
                          title: "Date From",
                          hintText: "dd/mm/yyyy",
                          enabled: false,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        child: CustomTextFieldWithTitle(
                          title: "Date To",
                          hintText: "dd/mm/yyyy",
                          enabled: false,
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
              ],
            );
          },
        ),
      );
    },
  );
}
