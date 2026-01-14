import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/features/application_detail/widgets/detail_section_card.dart';

class DealerProfileCard extends StatelessWidget {
  const DealerProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailSectionCard(
      title: "Dealer Profile",
      children: [
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Is this Dealer",
          hintText: "Yes",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Platform",
          hintText: "MF-DO (Rental)",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,

          title:
              "What other businesses does the dealer have, Mention # of business and types.",
          hintText: "0",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,

          title: "How involved is the dealer in petrol pump business?",
          hintText: "Low (Less than 1 hour on site daily)",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,

          title:
              "Is the dealer ready to inject working capital on site and operate on cash?",
          hintText: "Yes",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,

          title: "Why does the dealer want to convert to Taj?",
          hintText: "0",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,

          title:
              "In case it is an operational site, what is the current salary of attendant / month",
          hintText: "0",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,

          title:
              "Is the dealer agreed to follow all TGPL operating standards?*",
          hintText: "Yes",
        ),
      ],
    );
  }
}
