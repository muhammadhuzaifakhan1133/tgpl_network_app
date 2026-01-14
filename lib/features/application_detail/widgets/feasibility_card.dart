import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/features/application_detail/widgets/detail_section_card.dart';

class FeasibilityCard extends StatelessWidget {
  const FeasibilityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailSectionCard(
      title: "Feasibility",
      children: [
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Is this Conversion Pump",
          hintText: "Yes",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Current OMC Name",
          hintText: "Shell",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Is this Dealer Invested Site",
          hintText: "Yes",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Number of Operation Year",
          hintText: "5",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Is Currently Operational",
          hintText: "Yes",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Current Lease Expired",
          hintText: "Yes",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Diesel UGT Size Litre",
          hintText: "5000",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Super UGT SIze Litre",
          hintText: "3000",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Number of Diesel Dispenser",
          hintText: "4",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Number of Super Dispenser",
          hintText: "2",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Currently Canopy Condition",
          hintText: "Good",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Condition of Dispensors",
          hintText: "Good",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Condition of Forecourt",
          hintText: "Good",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Recommendation",
          hintText: "Recommended",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Recommendation Detail",
          hintText: "",
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
