import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class ContactDealerTGPLCard extends ConsumerWidget {
  const ContactDealerTGPLCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            "Contact (Dealer & TGPL)",
            style: AppTextstyles.googleInter700black28.copyWith(
              fontSize: 24,
              color: AppColors.black2Color,
            ),
          ),
          const SizedBox(height: 10),
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
      ),
    );
  }
}
