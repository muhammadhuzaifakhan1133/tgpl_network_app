import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/traffic_trade_form_controller.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

class TrafficCountCardForm extends ConsumerWidget {
  const TrafficCountCardForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(trafficTradeFormControllerProvider.notifier);

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
                  title: "Truck",
                  hintText: "2196",
                  controller: controller.trafficCountTruckController,
                  validator: (v) => v.validate(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomTextFieldWithTitle(
                  title: "Car",
                  hintText: "1500",
                  controller: controller.trafficCountCarController,
                  validator: (v) => v.validate(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomTextFieldWithTitle(
                  title: "Bike",
                  hintText: "3000",
                  controller: controller.trafficCountBikeController,
                  validator: (v) => v.validate(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
