import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/master_data/providers/tm_names_provider.dart';
import 'package:tgpl_network/features/master_data/providers/yes_no_na_values_provider.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/common/widgets/section_detail_card.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/survey_recommendation/survey_recommendation_form_controller.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

class SurveyRecommendationFormCard extends ConsumerStatefulWidget {
  const SurveyRecommendationFormCard({super.key});

  @override
  ConsumerState<SurveyRecommendationFormCard> createState() => _SurveyRecommendationFormCardState();
}

class _SurveyRecommendationFormCardState extends ConsumerState<SurveyRecommendationFormCard> {
  
  TextEditingController tmRemarksController = TextEditingController();
  TextEditingController rmRemarksController = TextEditingController();

  @override
  void dispose() {
    tmRemarksController.dispose();
    rmRemarksController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final state = ref.read(surveyRecommendationFormControllerProvider);

    tmRemarksController.text = state.tmRemarks ?? "";
    rmRemarksController.text = state.rmRemarks ?? "";
  }
  
  @override
  Widget build(BuildContext context) {
    final controller = ref.read(
      surveyRecommendationFormControllerProvider.notifier,
    );
    final state = ref.watch(surveyRecommendationFormControllerProvider);

    return SectionDetailCard(
      title: "Recommendation",
      children: [
        SmartCustomDropDownWithTitle(
          title: "TM",
          hintText: "Select TM",
          enableSearch: true,
          selectedItem: state.selectedTM,
          items: ref.read(tmNamesProvider),
          onChanged: (value) {
            if (value == null) return;
            controller.onChangeTM(value.toString());
          },
          validator: (v) => v.validate(),
          showClearButton: true,
          onClear: () {
            controller.clearField('selectedTM');
          },
        ),
        const SizedBox(height: 10),
        SmartCustomDropDownWithTitle(
          title: "TM Recommendation",
          hintText: "Select an option",
          selectedItem: state.selectedTMRecommendation,
          asyncProvider: yesNoNaValuesProvider,
          itemsBuilder: (values) => values,
          onChanged: (value) {
            if (value == null) return;
            controller.onChangeTMRecommendation(value.toString());
          },
          validator: (v) => v.validate(),
          showClearButton: true,
          onClear: () {
            controller.clearField('selectedTMRecommendation');
          },
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "TM Remarks",
          hintText: "Enter TM remarks",
          controller: tmRemarksController,
          onChanged: (value) {
            controller.updateTMRemarks(value);
          },
          validator: (v) => v.validate(),
          showClearButton: true,
          onClear: () {
            controller.clearField('tmRemarks');
          },
        ),
        const SizedBox(height: 10),
        SmartCustomDropDownWithTitle(
          title: "RM",
          hintText: "Select RM",
          enableSearch: true,
          selectedItem: state.selectedRM,
          items: ref.read(tmNamesProvider),
          onChanged: (value) {
            if (value == null) return;
            controller.onChangeRM(value.toString());
          },
          validator: (v) => v.validate(),
          showClearButton: true,
          onClear: () {
            controller.clearField('selectedRM');
          },
        ),
        const SizedBox(height: 10),
        SmartCustomDropDownWithTitle(
          title: "RM Recommendation",
          hintText: "Select an option",
          selectedItem: state.selectedRMRecommendation,
          asyncProvider: yesNoNaValuesProvider,
          itemsBuilder: (values) => values,
          onChanged: (value) {
            if (value == null) return;
            controller.onChangeRMRecommendation(value.toString());
          },
          validator: (v) => v.validate(),
          showClearButton: true,
          onClear: () {
            controller.clearField('selectedRMRecommendation');
          },
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "RM Remarks",
          hintText: "Enter RM remarks",
          controller: rmRemarksController,
          onChanged: (value) {
            controller.updateRMRemarks(value);
          },
          validator: (v) => v.validate(),
          showClearButton: true,
          onClear: () {
            controller.clearField('rmRemarks');
          },
        ),
      ],
    );
  }
}
