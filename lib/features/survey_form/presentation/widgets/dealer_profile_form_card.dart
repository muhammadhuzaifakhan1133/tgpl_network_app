import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/dealer_involvement_names_provider.dart';
import 'package:tgpl_network/common/providers/yes_no_na_values_provider.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/survey_form/presentation/survey_form_controller.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

class DealerProfileFormCard extends ConsumerWidget {
  const DealerProfileFormCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(surveyFormControllerProvider.notifier);

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
            "Dealer Profile",
            style: AppTextstyles.googleInter700black28.copyWith(
              fontSize: 24,
              color: AppColors.black2Color,
            ),
          ),
          // is this dealer (dropdown)
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) {
              final isThisDealer = ref.watch(
                surveyFormControllerProvider.select((s) => s.isThisDealer),
              );
              return CustomDropDownWithTitle(
                title: "Is this dealer?",
                hintText: "Select an option",
                selectedItem: isThisDealer,
                items: ref.read(yesNoNaValuesProvider),
                onChanged: (value) {
                  if (value == null) return;
                  controller.onChangeIsThisDealer(value.toString());
                },
                validator: (v) => v.validate(),
              );
            },
          ),
          // platform (textfield)
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Platform",
            hintText: "Enter platform",
            controller: controller.dealerPlatformController,
            validator: (v) => v.validate(),
          ),
          // BELOW ALL FIELDS ACTIVE ONLY WHEN IS THIS DEALER = YES
          // dealer businesses (textfield - multiline)
          Consumer(
            builder: (context, ref, child) {
              final isThisDealer = ref.watch(
                surveyFormControllerProvider.select((s) => s.isThisDealer),
              );
              if (isThisDealer != 'Yes') {
                return const SizedBox.shrink();
              }
              return Column(
                children: [
                  const SizedBox(height: 10),
                  CustomTextFieldWithTitle(
                    title:
                        "What other businesses does the dealer have, Mention # of business and types.",
                    hintText: "Enter dealer businesses",
                    controller: controller.dealerBusinessesController,
                    multiline: true,
                    minLines: 2,
                    maxLines: 3,
                    validator: (v) => v.validate(),
                  ),
                  // dealer involvement (dropdown)
                  const SizedBox(height: 10),
                  Consumer(
                    builder: (context, ref, child) {
                      final selectedDealerInvolvement = ref.watch(
                        surveyFormControllerProvider.select(
                          (s) => s.selectedDealerInvolvement,
                        ),
                      );
                      return CustomDropDownWithTitle(
                        title:
                            "How involved is the dealer in petrol pump business?",
                        hintText: "Select dealer involvement",
                        enableSearch: true,
                        selectedItem: selectedDealerInvolvement,
                        items: ref.read(dealerInvolvementNamesProvider),
                        onChanged: (value) {
                          if (value == null) return;
                          controller.onChangeDealerInvolvement(
                            value.toString(),
                          );
                        },
                        validator: (v) => v.validate(),
                      );
                    },
                  ),
                  // dealer ready to invest (dropdown)
                  const SizedBox(height: 10),
                  Consumer(
                    builder: (context, ref, child) {
                      final isDealerReadyToInvest = ref.watch(
                        surveyFormControllerProvider.select(
                          (s) => s.isDealerReadyToInvest,
                        ),
                      );
                      return CustomDropDownWithTitle(
                        title:
                            "Is the dealer ready to inject working capital on site and operate on cash?*",
                        hintText: "Select an option",
                        selectedItem: isDealerReadyToInvest,
                        items: ref.read(yesNoNaValuesProvider),
                        onChanged: (value) {
                          if (value == null) return;
                          controller.onChangeIsDealerReadyToInvest(
                            value.toString(),
                          );
                        },
                        validator: (v) => v.validate(),
                      );
                    },
                  ),
                  // dealer opinion  (textfield - multiline)
                  const SizedBox(height: 10),
                  CustomTextFieldWithTitle(
                    title: "Why does the dealer want to convert to Taj?",
                    hintText: "Enter dealer opinion",
                    controller: controller.dealerOpinionController,
                    multiline: true,
                    minLines: 2,
                    maxLines: 3,
                    validator: (v) => v.validate(),
                  ),
                  // monthly salary (textfield - number format)
                  const SizedBox(height: 10),
                  CustomTextFieldWithTitle(
                    title:
                        "In case it is an operational site, what is the current salary of attendant / month",
                    hintText: "Enter monthly salary",
                    keyboardType: TextInputType.number,
                    controller: controller.monthlySalaryController,
                    validator: (v) => v.validate(),
                  ),
                  // is dealer agree to standard (dropdown)
                  const SizedBox(height: 10),
                  Consumer(
                    builder: (context, ref, child) {
                      final isDealerAgreeToStandard = ref.watch(
                        surveyFormControllerProvider.select(
                          (s) => s.isDealerAgreedToFollowTgplStandards,
                        ),
                      );
                      return CustomDropDownWithTitle(
                        title:
                            "Is the dealer agreed to follow all TGPL operating standards?",
                        hintText: "Select an option",
                        selectedItem: isDealerAgreeToStandard,
                        items: ref.read(yesNoNaValuesProvider),
                        onChanged: (value) {
                          if (value == null) return;
                          controller
                              .onChangeIsDealerAgreedToFollowTgplStandards(
                                value.toString(),
                              );
                        },
                        validator: (v) => v.validate(),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
