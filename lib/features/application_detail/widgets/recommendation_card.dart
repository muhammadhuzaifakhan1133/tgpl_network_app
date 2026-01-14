import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/features/application_detail/widgets/detail_section_card.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailSectionCard(
      title: "Recommendation",
      children: [
        CustomTextFieldWithTitle(
            readOnly: true,
            title: "TM",
            hintText: "TM Hyderabad(TM)",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "TM Recommend",
            hintText: "Yes",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "TM Remarks",
            hintText: "Good Site",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "RM",
            hintText: "RM Hyderabad(RM)",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "RM Recommend",
            hintText: "Yes",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,

            title: "RM Remarks",
            hintText: "It has Potential",
          ),
          const SizedBox(height: 10),
      ],
    );
  }
}
