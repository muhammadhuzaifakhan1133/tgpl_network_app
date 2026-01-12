import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/depo_names_provider.dart';
import 'package:tgpl_network/common/providers/trade_area_names_provider.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/survey_form/presentation/survey_form_controller.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

class ContactAndDealerFormCard extends ConsumerWidget {
  const ContactAndDealerFormCard({super.key});

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
            "Contact & Dealer Detail",
            style: AppTextstyles.googleInter700black28.copyWith(
              fontSize: 24,
              color: AppColors.black2Color,
            ),
          ),
          // dealer name (textfield)
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Dealer Name",
            hintText: "Enter dealer name",
            controller: controller.dealerNameController,
            validator: (v) => v.validate(),
          ),
          // dealer contact number (textfield - number format)
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Dealer Contact",
            hintText: "Enter dealer contact number",
            keyboardType: TextInputType.phone,
            controller: controller.dealerContactController,
            validator: (v) => v.validate(),
          ),
          // dealer Reference By (textfield)
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Reference By",
            hintText: "Enter reference",
            controller: controller.referencyByController,
            validator: (v) => v.validate(),
          ),
          // dealer Address (textfield)
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Location Address",
            hintText: "Enter location address",
            controller: controller.locationAddressController,
            validator: (v) => v.validate(),
          ),
          // dealer landmark (textfield)
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Landmark",
            hintText: "Enter landmark",
            controller: controller.landmarkController,
            validator: (v) => v.validate(),
          ),
          // plot area (textfield - number format)
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Plot Area",
            readOnly: true,
            hintText: "Enter plot area",
            keyboardType: TextInputType.number,
            controller: controller.plotAreaController,
          ),
          // plot front (textfield - number format)
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Plot Front",
            hintText: "Enter plot front",
            keyboardType: TextInputType.number,
            controller: controller.plotFrontController,
            onChanged: (value) {
              controller.onChangePlotFrontAndDepth();
            },
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Plot Depth",
            hintText: "Enter plot depth",
            keyboardType: TextInputType.number,
            controller: controller.plotDepthController,
            onChanged: (value) {
              controller.onChangePlotFrontAndDepth();
            },
          ),
          // nearest depo (dropdown)
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) {
              final selectedNearestDepo = ref.watch(
                surveyFormControllerProvider.select(
                  (s) => s.selectedNearestDepo,
                ),
              );
              return CustomDropDownWithTitle(
                title: "Nearest Depo",
                hintText: "Select nearest depo",
                enableSearch: true,
                selectedItem: selectedNearestDepo,
                items: ref.read(depoNamesProvider),
                onChanged: (value) {
                  if (value == null) return;
                  controller.onChangeNearestDepo(value.toString());
                },
                validator: (v) => v.validate(),
              );
            },
          ),
          // distance from depo (textfield - number format)
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Distance from Depo",
            hintText: "Enter distance from depo",
            keyboardType: TextInputType.number,
            controller: controller.distanceFromDepoController,
            validator: (v) => v.validate(),
          ),
          // type of trade area (dropdown)
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) {
              final selectedTypeOfTradeArea = ref.watch(
                surveyFormControllerProvider.select(
                  (s) => s.selectedTypeOfTradeArea,
                ),
              );
              return CustomDropDownWithTitle(
                title: "Type of Trade Area",
                hintText: "Select type of trade area",
                enableSearch: true,
                selectedItem: selectedTypeOfTradeArea,
                items: ref.read(tradeAreaNamesProvider),
                onChanged: (value) {
                  if (value == null) return;
                  controller.onChangeTypeOfTradeArea(value.toString());
                },
                validator: (v) => v.validate(),
              );
            },
          ),
        ],
      ),
    );
  }
}
