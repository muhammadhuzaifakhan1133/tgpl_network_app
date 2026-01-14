import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/features/application_detail/widgets/detail_section_card.dart';

class TrafficCountCard extends StatelessWidget {
  const TrafficCountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailSectionCard(
      title: "Traffic Count",
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextFieldWithTitle(
                readOnly: true,
                title: "Cars",
                hintText: "1,250",
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextFieldWithTitle(
                readOnly: true,
                title: "Bikes",
                hintText: "850",
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextFieldWithTitle(
                readOnly: true,
                title: "Trucks",
                hintText: "320",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
