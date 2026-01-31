import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/features/master_data/providers/depo_names_provider.dart';
import 'package:tgpl_network/features/master_data/providers/trade_area_names_provider.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/common/widgets/section_detail_card.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/contact_and_dealer/contact_and_dealer_form_controller.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

class ContactAndDealerFormCard extends ConsumerWidget {
  const ContactAndDealerFormCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(
      contactAndDealerFormControllerProvider.notifier,
    );
      final state = ref.read(contactAndDealerFormControllerProvider);
    return SectionDetailCard(
      title: "Contact & Dealer Detail",
      children: [
        CustomTextFieldWithTitle(
          title: "Dealer Name",
          hintText: "Enter dealer name",
          isRequired: true,
          initialValue: state.dealerName,
          onChanged: (value) {
            controller.updateDealerInfo(dealerName: value);
          },
          validator: (v) => v.validate(),
          showClearButton: true,
          onClear: () {
            controller.clearField('dealerName');
          },
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Dealer Contact",
          hintText: "Enter dealer contact number",
          keyboardType: TextInputType.phone,
          initialValue: state.dealerContact,
          isRequired: true,
          onChanged: (value) {
            controller.updateDealerInfo(dealerContact: value);
          },
          validator: (v) => v.validate(),
          showClearButton: true,
          onClear: () {
            controller.clearField('dealerContact');
          },
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Reference By",
          hintText: "Enter reference",
          initialValue: state.referenceBy,
          onChanged: (value) {
            controller.updateDealerInfo(referenceBy: value);
          },
          showClearButton: true,
          onClear: () {
            controller.clearField('referenceBy');
          },
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Location Address",
          hintText: "Enter location address",
          initialValue: state.locationAddress,
          isRequired: true,
          onChanged: (value) {
            controller.updateLocationInfo(locationAddress: value);
          },
          validator: (v) => v.validate(),
          showClearButton: true,
          onClear: () {
            controller.clearField('locationAddress');
          },
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Landmark",
          hintText: "Enter landmark",
          initialValue: state.landmark,
          isRequired: true,
          onChanged: (value) {
            controller.updateLocationInfo(landmark: value);
          },
          validator: (v) => v.validate(),
          showClearButton: true,
          onClear: () {
            controller.clearField('landmark');
          },
        ),
        const SizedBox(height: 10),
        Consumer(
          builder: (context, ref, child) {
            ref.watch(contactAndDealerFormControllerProvider.select((s)=>s.plotFront));
            ref.watch(contactAndDealerFormControllerProvider.select((s)=>s.plotDepth));
            final plotArea = ref.read(contactAndDealerFormControllerProvider).plotArea;
            return CustomTextFieldWithTitle(
              title: "Plot Area",
              readOnly: true,
              hintText: "Enter plot area",
              isRequired: true,
              controller: TextEditingController(text: plotArea ?? ""),
              keyboardType: TextInputType.number,
              validator: (v) => v.validate("Enter valid plot front or depth"),
            );
          }
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Plot Front",
          hintText: "Enter plot front",
          keyboardType: TextInputType.number,
          isRequired: true,
          initialValue: state.plotFront,
          onChanged: (value) {
            controller.updatePlotDimensions(front: value);
          },
          showClearButton: true,
          onClear: () {
            controller.clearField('plotFront');
          },
          validator: (v) => v.validateNumber(),
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Plot Depth",
          hintText: "Enter plot depth",
          keyboardType: TextInputType.number,
          initialValue: state.plotDepth,
          isRequired: true,
          onChanged: (value) {
            controller.updatePlotDimensions(depth: value);
          },
          showClearButton: true,
          onClear: () {
            controller.clearField('plotDepth');
          },
          validator: (v) => v.validateNumber(),
        ),
        const SizedBox(height: 10),
        Consumer(
          builder: (context, ref, child) {
            final nearestDepo = ref.watch(
              contactAndDealerFormControllerProvider.select((s) => s.nearestDepo),
            );
            return SmartCustomDropDownWithTitle(
              title: "Nearest Depo",
              hintText: "Select nearest depo",
              enableSearch: true,
              selectedItem: nearestDepo,
              isRequired: true,
              asyncProvider: depoNamesProvider,
              itemsBuilder: (depos) => depos,
              onChanged: (value) {
                if (value == null) return;
                controller.updateLocationInfo(nearestDepo: value.toString());
              },
              validator: (v) => v.validate(),
              showClearButton: true,
              onClear: () {
                controller.clearField('nearestDepo');
              },
            );
          }
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Distance from Depo",
          hintText: "Enter distance from depo",
          keyboardType: TextInputType.number,
          initialValue: state.distanceFromDepo,
          onChanged: (value) {
            controller.updateDistanceFromDepo(value);
          },
          validator: (v) => v.validate(),
          isRequired: true,
          showClearButton: true,
          onClear: () {
            controller.clearField('distanceFromDepo');
          },
        ),
        const SizedBox(height: 10),
        Consumer(
          builder: (context, ref, child) {
            final typeOfTradeArea = ref.watch(
              contactAndDealerFormControllerProvider.select((s) => s.typeOfTradeArea),
            );
            return SmartCustomDropDownWithTitle(
              title: "Type of Trade Area",
              hintText: "Select type of trade area",
              enableSearch: true,
              isRequired: true,
              validator: (v) => v.validate(),
              selectedItem: typeOfTradeArea,
              asyncProvider: tradeAreaNamesProvider,
              itemsBuilder: (tradeAreas) => tradeAreas,
              onChanged: (value) {
                if (value == null) return;
                controller.updateLocationInfo(typeOfTradeArea: value.toString());
              },
              showClearButton: true,
              onClear: () {
                controller.clearField('typeOfTradeArea');
              },
            );
          }
        ),
      ],
    );
  }
}
