import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/features/master_data/providers/tm_rm_names_provider.dart';
import 'package:tgpl_network/features/master_data/providers/yes_no_na_values_provider.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/common/widgets/section_detail_card.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/traffic_recommendation/traffic_recommendation_controller.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

class TrafficRecommendationCardForm extends ConsumerWidget {
  const TrafficRecommendationCardForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(recommendationControllerProvider.notifier);
    final state = ref.read(recommendationControllerProvider);
    return SectionDetailCard(
      title: "Recommendation",
      children: [
        Consumer(
          builder: (context, ref, _) {
            final selectedTM = ref.watch(
              recommendationControllerProvider.select(
                (state) => state.selectedTM,
              ),
            );
            return SmartCustomDropDownWithTitle(
              title: "TM",
              hintText: "Select TM",
              enableSearch: true,
              selectedItem: selectedTM,
              items: ref.read(tmNamesProvider),
              onChanged: (value) {
                if (value == null) return;
                controller.onChangeTM(value.toString());
              },
              validator: (v) => v.validate(),
              isRequired: true,
              showClearButton: true,
              onClear: () {
                controller.clearField('selectedTM');
              },
            );
          },
        ),
        SizedBox(height: 10.h),
        Consumer(
          builder: (context, ref, _) {
            final selectedTMRecommendation = ref.watch(
              recommendationControllerProvider.select(
                (state) => state.selectedTMRecommendation,
              ),
            );
            return SmartCustomDropDownWithTitle(
              title: "TM Recommendation",
              hintText: "Select an option",
              selectedItem: selectedTMRecommendation,
              asyncProvider: yesNoNaValuesProvider,
              itemsBuilder: (values) => values,
              onChanged: (value) {
                if (value == null) return;
                controller.onChangeTMRecommendation(value.toString());
              },
              validator: (v) => v.validate(),
              isRequired: true,
              showClearButton: true,
              onClear: () {
                controller.clearField('selectedTMRecommendation');
              },
            );
          },
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          title: "TM Remarks",
          hintText: "Enter TM remarks",
          initialValue: state.tmRemarks,
          onChanged: (value) {
            controller.updateTMRemarks(value);
          },
          validator: (v) => v.validate(),
          isRequired: true,
          showClearButton: true,
          onClear: () {
            controller.clearField('tmRemarks');
          },
        ),
        SizedBox(height: 10.h),
        Consumer(
          builder: (context, ref, _) {
            final selectedRM = ref.watch(
              recommendationControllerProvider.select(
                (state) => state.selectedRM,
              ),
            );
            return SmartCustomDropDownWithTitle(
              title: "RM",
              hintText: "Select RM",
              enableSearch: true,
              selectedItem: selectedRM,
              items: ref.read(rmNamesProvider),
              onChanged: (value) {
                if (value == null) return;
                controller.onChangeRM(value.toString());
              },
              validator: (v) => v.validate(),
              isRequired: true,
              showClearButton: true,
              onClear: () {
                controller.clearField('selectedRM');
              },
            );
          },
        ),
        SizedBox(height: 10.h),
        Consumer(
          builder: (context, ref, _) {
            final selectedRMRecommendation = ref.watch(
              recommendationControllerProvider.select(
                (state) => state.selectedRMRecommendation,
              ),
            );
            return SmartCustomDropDownWithTitle(
              title: "RM Recommendation",
              hintText: "Select an option",
              selectedItem: selectedRMRecommendation,
              asyncProvider: yesNoNaValuesProvider,
              itemsBuilder: (values) => values,
              onChanged: (value) {
                if (value == null) return;
                controller.onChangeRMRecommendation(value.toString());
              },
              validator: (v) => v.validate(),
              isRequired: true,
              showClearButton: true,
              onClear: () {
                controller.clearField('selectedRMRecommendation');
              },
            );
          },
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          title: "RM Remarks",
          hintText: "Enter RM remarks",
          initialValue: state.rmRemarks,
          onChanged: (value) {
            controller.updateRMRemarks(value);
          },
          validator: (v) => v.validate(),
          isRequired: true,
          showClearButton: true,
          onClear: () {
            controller.clearField('rmRemarks');
          },
        ),
      ],
    );
  }
}
