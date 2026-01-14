import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/features/application_detail/widgets/detail_section_card.dart';

class ContactDealerTGPLCard extends StatelessWidget {
  const ContactDealerTGPLCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailSectionCard(
      title: "Contact (Dealer & TGPL)",
      children: [
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "NP. Name",
          hintText: "Shadman",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Source",
          hintText: "NW Manager (North & KPK)",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Source Name",
          hintText: "Shadman Khattak",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Conducted By",
          hintText: "Shadman",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Dealer Name",
          hintText: "Qamar Alam",
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: CustomTextFieldWithTitle(
                readOnly: true,
                title: "Dealer Contact",
                hintText: "03349342026",
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextFieldWithTitle(
                readOnly: true,
                title: "Reference By",
                hintText: "Shadman",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
