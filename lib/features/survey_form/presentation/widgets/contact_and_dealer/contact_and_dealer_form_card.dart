import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/depo_names_provider.dart';
import 'package:tgpl_network/common/providers/trade_area_names_provider.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/common/widgets/section_detail_card.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/contact_and_dealer/contact_and_dealer_form_controller.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

class ContactAndDealerFormCard extends ConsumerWidget {
  const ContactAndDealerFormCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(contactAndDealerFormControllerProvider.notifier);
    final state = ref.watch(contactAndDealerFormControllerProvider);

    return SectionDetailCard(
      title: "Contact & Dealer Detail",
      children: [
        CustomTextFieldWithTitle(
          title: "Dealer Name",
          hintText: "Enter dealer name",
          initialValue: state.dealerName,
          onChanged: (value) {
            controller.updateDealerInfo(dealerName: value);
          },
          validator: (v) => v.validate(),
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Dealer Contact",
          hintText: "Enter dealer contact number",
          keyboardType: TextInputType.phone,
          initialValue: state.dealerContact,
          onChanged: (value) {
            controller.updateDealerInfo(dealerContact: value);
          },
          validator: (v) => v.validate(),
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Reference By",
          hintText: "Enter reference",
          initialValue: state.referenceBy,
          onChanged: (value) {
            controller.updateDealerInfo(referenceBy: value);
          },
          validator: (v) => v.validate(),
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Location Address",
          hintText: "Enter location address",
          initialValue: state.locationAddress,
          onChanged: (value) {
            controller.updateLocationInfo(locationAddress: value);
          },
          validator: (v) => v.validate(),
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Landmark",
          hintText: "Enter landmark",
          initialValue: state.landmark,
          onChanged: (value) {
            controller.updateLocationInfo(landmark: value);
          },
          validator: (v) => v.validate(),
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Plot Area",
          readOnly: true,
          hintText: "Enter plot area",
          controller: TextEditingController(text: state.plotArea ?? ""),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Plot Front",
          hintText: "Enter plot front",
          keyboardType: TextInputType.number,
          initialValue: state.plotFront,
          onChanged: (value) {
            controller.updatePlotDimensions(front: value);
          },
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Plot Depth",
          hintText: "Enter plot depth",
          keyboardType: TextInputType.number,
          initialValue: state.plotDepth,
          onChanged: (value) {
            controller.updatePlotDimensions(depth: value);
          },
        ),
        const SizedBox(height: 10),
        CustomDropDownWithTitle(
          title: "Nearest Depo",
          hintText: "Select nearest depo",
          enableSearch: true,
          selectedItem: state.nearestDepo,
          items: ref.read(depoNamesProvider),
          onChanged: (value) {
            if (value == null) return;
            controller.updateLocationInfo(nearestDepo: value.toString());
          },
          validator: (v) => v.validate(),
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
        ),
        const SizedBox(height: 10),
        CustomDropDownWithTitle(
          title: "Type of Trade Area",
          hintText: "Select type of trade area",
          enableSearch: true,
          selectedItem: state.typeOfTradeArea,
          items: ref.read(tradeAreaNamesProvider),
          onChanged: (value) {
            if (value == null) return;
            controller.updateLocationInfo(typeOfTradeArea: value.toString());
          },
          validator: (v) => v.validate(),
        ),
      ],
    );
  }
}