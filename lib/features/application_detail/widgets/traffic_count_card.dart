import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';

class TrafficCountCard extends StatelessWidget {
  const TrafficCountCard({super.key});

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
            "Traffic Count",
            style: AppTextstyles.googleInter700black28.copyWith(
              fontSize: 24,
              color: AppColors.black2Color,
            ),
          ),
          const SizedBox(height: 10),
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
      ),
    );
  }
}
