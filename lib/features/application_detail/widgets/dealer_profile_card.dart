import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class DealerProfileCard extends StatelessWidget {
  const DealerProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
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
            "Dealer Profile",
            style: AppTextstyles.googleInter700black28.copyWith(
              fontSize: 24,
              color: AppColors.black2Color,
            ),
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Is this Dealer", hintText:  "Yes"),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Platform", hintText:  "MF-DO (Rental)"),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
readOnly: true,

            title:
                "What other businesses does the dealer have, Mention # of business and types.",
            hintText:  "0",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
readOnly: true,

            title:
                "How involved is the dealer in petrol pump business? (High: 4-6 hours on site, Medium 2-3 hours on site, Low: less than 1 hour on site, Not Involved)",
            hintText:  "Low (Less than 1 hour on site daily)",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
readOnly: true,

            title:
                "Is the dealer ready to inject working capital on site and operate on cash?",
            hintText:  "Yes",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
readOnly: true,

            title: "Why does the dealer want to convert to Taj?",
            hintText:  "0",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
readOnly: true,

            title:
                "In case it is an operational site, what is the current salary of attendant / month",
            hintText:  "0",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
readOnly: true,

            title:
                "Is the dealer agreed to follow all TGPL operating standards?*",
            hintText:  "Yes",
          ),
        ],
      ),
    );
  }
}
