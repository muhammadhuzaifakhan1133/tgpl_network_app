import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class SiteDetailCard extends StatelessWidget {
  const SiteDetailCard({super.key});

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
            "Site Detail",
            style: AppTextstyles.googleInter700black28.copyWith(
              fontSize: 24,
              color: AppColors.black2Color,
            ),
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Entry Code", hintText:  "TGPL-SIN-76"),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Date Conducted", hintText:  "15/Sep/2022"),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
readOnly: true,

            title: "Google Location",
            hintText:  "25.915497,68.619792",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "City", hintText:  "Shahdadpur"),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "District", hintText:  "Sanghar"),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Priority", hintText:  "High"),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
readOnly: true,

            title: "Location Address",
            hintText:  "Sufi CNG, Shahdapur",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
readOnly: true,

            title: "Landmark",
            hintText:  "The Citizen English Grammer School",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Plot Area", hintText:  "300"),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CustomTextFieldWithTitle(
readOnly: true,

                  title: "Plot Front",
                  hintText:  "150",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomTextFieldWithTitle(
readOnly: true,

                  title: "Plot Depth",
                  hintText:  "150",
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            readOnly: true,
            title: "Nearest Depo", hintText:  "Habibabad"),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
readOnly: true,

            title: "Distance From Depo (Km)",
            hintText:  "593.00",
          ),
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
readOnly: true,

            title: "Type of Trade",
            hintText:  "High Populated Urban Area",
          ),
        ],
      ),
    );
  }
}
