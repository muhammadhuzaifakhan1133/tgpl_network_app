import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/features/application_detail/widgets/detail_section_card.dart';

class ApplicantInfoCard extends StatelessWidget {
  const ApplicantInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailSectionCard(
      title: "Applicant Info",
      children: [
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Applicant Name",
          hintText: "Huzaifa",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Contact Person",
          hintText: "Basit",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Currently Presence",
          hintText: "Karachi",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Contact Person",
          hintText: "Abu Bakar",
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "WhatsApp Number",
          hintText: "03001234567",
        ),
      ],
    );
  }
}
