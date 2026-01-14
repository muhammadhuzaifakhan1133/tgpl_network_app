import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/features/application_detail/widgets/detail_section_card.dart';

class VolumAndFinancialEstimationCard extends StatelessWidget {
  const VolumAndFinancialEstimationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailSectionCard(
      title: "Volume & Financial Estimation",
      children: [
         CustomTextFieldWithTitle(
            readOnly: true,
            title: "Estimated Daily Diesel Sales",
            hintText: "0",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Estimated Daily Super Sales",
            hintText: "0",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Estimated Daily Lubricant Sales",
            hintText: "0",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Dealer Expectation of Lease Rental / month",
            hintText: "0",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Truck Port Potential",
            hintText: "No",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Salam Mart Potential",
            hintText: "No",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Resturant Potential",
            hintText: "No",
          ),
          const SizedBox(height: 10),
      ],
    );
  }
}
