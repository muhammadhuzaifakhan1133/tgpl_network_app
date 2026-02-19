import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/features/master_data/providers/dealer_involvement_names_provider.dart';
import 'package:tgpl_network/features/master_data/providers/yes_no_na_values_provider.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/common/widgets/section_detail_card.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/dealer_profile/dealer_profile_form_controller.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

class DealerProfileFormCard extends ConsumerWidget {
  const DealerProfileFormCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(dealerProfileFormControllerProvider.notifier);
    final state = ref.read(dealerProfileFormControllerProvider);
    final isThisDealer = ref.watch(
      dealerProfileFormControllerProvider.select((s) => s.isThisDealer),
    );
    return SectionDetailCard(
      title: "Dealer Profile",
      children: [
        SmartCustomDropDownWithTitle(
          title: "Is this dealer?",
          hintText: "Select an option",
          selectedItem: isThisDealer,
          asyncProvider: yesNoNaValuesProvider,
          itemsBuilder: (values) => values,
          isRequired: true,
          onChanged: (value) {
            if (value == null) return;
            controller.onChangeIsThisDealer(value.toString());
          },
          validator: (v) => v.validate(),
          showClearButton: true,
          onClear: () {
            controller.clearField('isThisDealer');
          },
        ),
        SizedBox(height: 10.h),
        CustomTextFieldWithTitle(
          title: "Platform",
          hintText: "Enter platform",
          isRequired: true,
          initialValue: state.dealerPlatform,
          onChanged: (value) {
            controller.updateDealerPlatform(value);
          },
          validator: (v) => v.validate(),
          showClearButton: true,
          onClear: () {
            controller.clearField('dealerPlatform');
          },
        ),
        // BELOW ALL FIELDS ACTIVE ONLY WHEN IS THIS DEALER = YES
        if (isThisDealer == 'Yes') ...[
          SizedBox(height: 10.h),
          CustomTextFieldWithTitle(
            title:
                "What other businesses does the dealer have, Mention # of business and types.",
            hintText: "Enter dealer businesses",
            initialValue: state.dealerBusinesses,
            isRequired: true,
            onChanged: (value) {
              controller.updateDealerBusinesses(value);
            },
            multiline: true,
            minLines: 2,
            maxLines: 3,
            validator: (v) => v.validate(),
            showClearButton: true,
            onClear: () {
              controller.clearField('dealerBusinesses');
            },
          ),
          SizedBox(height: 10.h),
          Consumer(
            builder: (context, ref, child) {
              final selectedDealerInvolvement = ref.watch(
                dealerProfileFormControllerProvider.select(
                  (s) => s.selectedDealerInvolvement,
                ),
              );
              return SmartCustomDropDownWithTitle(
                title: "How involved is the dealer in petrol pump business?",
                hintText: "Select dealer involvement",
                selectedItem: selectedDealerInvolvement,
                asyncProvider: dealerInvolvementNamesProvider,
                itemsBuilder: (values) => values,
                isRequired: true,
                onChanged: (value) {
                  if (value == null) return;
                  controller.onChangeDealerInvolvement(value.toString());
                },
                validator: (v) => v.validate(),
                showClearButton: true,
                onClear: () {
                  controller.clearField('selectedDealerInvolvement');
                },
              );
            },
          ),
          SizedBox(height: 10.h),
          Consumer(
            builder: (context, ref, _) {
              final isDealerReadyToInvest = ref.watch(
                dealerProfileFormControllerProvider.select(
                  (s) => s.isDealerReadyToInvest,
                ),
              );
              return SmartCustomDropDownWithTitle(
                title:
                    "Is the dealer ready to inject working capital on site and operate on cash?*",
                hintText: "Select an option",
                selectedItem: isDealerReadyToInvest,
                asyncProvider: yesNoNaValuesProvider,
                itemsBuilder: (values) => values,
                isRequired: true,
                onChanged: (value) {
                  if (value == null) return;
                  controller.onChangeIsDealerReadyToInvest(value.toString());
                },
                validator: (v) => v.validate(),
                showClearButton: true,
                onClear: () {
                  controller.clearField('isDealerReadyToInvest');
                },
              );
            },
          ),
          SizedBox(height: 10.h),
          CustomTextFieldWithTitle(
            title: "Why does the dealer want to convert to Taj?",
            hintText: "Enter dealer opinion",
            initialValue: state.dealerOpinion,
            onChanged: (value) {
              controller.updateDealerOpinion(value);
            },
            multiline: true,
            minLines: 2,
            maxLines: 3,
            showClearButton: true,
            onClear: () {
              controller.clearField('dealerOpinion');
            },
          ),
          SizedBox(height: 10.h),
          CustomTextFieldWithTitle(
            title:
                "In case it is an operational site, what is the current salary of attendant / month",
            hintText: "Enter monthly salary",
            keyboardType: TextInputType.number,
            initialValue: state.monthlySalary,
            onChanged: (value) {
              controller.updateMonthlySalary(value);
            },
            showClearButton: true,
            onClear: () {
              controller.clearField('monthlySalary');
            },
          ),
          SizedBox(height: 10.h),
          Consumer(
            builder: (context, ref, _) {
              final isDealerAgreedToFollowTgplStandards = ref.watch(
                dealerProfileFormControllerProvider.select(
                  (s) => s.isDealerAgreedToFollowTgplStandards,
                ),
              );
              return SmartCustomDropDownWithTitle(
                title:
                    "Is the dealer agreed to follow all TGPL operating standards?",
                hintText: "Select an option",
                selectedItem: isDealerAgreedToFollowTgplStandards,
                asyncProvider: yesNoNaValuesProvider,
                itemsBuilder: (values) => values,
                isRequired: true,
                onChanged: (value) {
                  if (value == null) return;
                  controller.onChangeIsDealerAgreedToFollowTgplStandards(
                    value.toString(),
                  );
                },
                validator: (v) => v.validate(),
                showClearButton: true,
                onClear: () {
                  controller.clearField('isDealerAgreedToFollowTgplStandards');
                },
              );
            },
          ),
        ],
      ],
    );
  }
}
