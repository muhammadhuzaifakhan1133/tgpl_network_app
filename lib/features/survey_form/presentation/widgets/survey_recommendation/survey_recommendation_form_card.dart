import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/tm_names_provider.dart';
import 'package:tgpl_network/common/providers/yes_no_na_values_provider.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/common/widgets/section_detail_card.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/survey_recommendation/survey_recommendation_form_controller.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

class SurveyRecommendationFormCard extends ConsumerWidget {
  const SurveyRecommendationFormCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(surveyRecommendationFormControllerProvider.notifier);
    return SectionDetailCard(
      title: "Recommendation",
      children: [
        Consumer(
            builder: (context, ref, child) {
              final selectedTm = ref.watch(
                surveyRecommendationFormControllerProvider.select((s) => s.selectedTM),
              );
              return CustomDropDownWithTitle(
                title: "TM",
                hintText: "Select TM",
                enableSearch: true,
                selectedItem: selectedTm,
                items: ref.read(tmNamesProvider),
                onChanged: (value) {
                  if (value == null) return;
                  controller.onChangeTM(value.toString());
                },
                validator: (v) => v.validate(),
              );
            },
          ),
          // tm recommend (dropdown)
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) {
              final tmRecommend = ref.watch(
                surveyRecommendationFormControllerProvider.select(
                  (s) => s.selectedTMRecommendation,
                ),
              );
              return CustomDropDownWithTitle(
                title: "TM Recommendation",
                hintText: "Select an option",
                selectedItem: tmRecommend,
                items: ref.read(yesNoNaValuesProvider),
                onChanged: (value) {
                  if (value == null) return;
                  controller.onChangeTMRecommendation(value.toString());
                },
                validator: (v) => v.validate(),
              );
            },
          ),
          // Tm Remarks (textfield)
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "TM Remarks",
            hintText: "Enter TM remarks",
            controller: controller.tmRemarksController,
            validator: (v) => v.validate(),
          ),
          // Rm (dropdwon)
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) {
              final selectedRm = ref.watch(
                surveyRecommendationFormControllerProvider.select((s) => s.selectedRM),
              );
              return CustomDropDownWithTitle(
                title: "RM",
                hintText: "Select RM",
                enableSearch: true,
                selectedItem: selectedRm,
                items: ref.read(tmNamesProvider),
                onChanged: (value) {
                  if (value == null) return;
                  controller.onChangeRM(value.toString());
                },
                validator: (v) => v.validate(),
              );
            },
          ),
          // rm recommend (dropdown)
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) {
              final rmRecommend = ref.watch(
                surveyRecommendationFormControllerProvider.select(
                  (s) => s.selectedRMRecommendation,
                ),
              );
              return CustomDropDownWithTitle(
                title: "RM Recommendation",
                hintText: "Select an option",
                selectedItem: rmRecommend,
                items: ref.read(yesNoNaValuesProvider),
                onChanged: (value) {
                  if (value == null) return;
                  controller.onChangeRMRecommendation(value.toString());
                },
                validator: (v) => v.validate(),
              );
            },
          ),
          // Rm Remarks (textfield)
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "RM Remarks",
            hintText: "Enter RM remarks",
            controller: controller.rmRemarksController,
            validator: (v) => v.validate(),
          ),
      ],
    );
  }
}
