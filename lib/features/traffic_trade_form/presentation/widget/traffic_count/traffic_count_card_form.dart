import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/common/widgets/section_detail_card.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/traffic_count/traffic_count_form_controller.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

class TrafficCountCardForm extends ConsumerWidget {
  const TrafficCountCardForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(trafficCountControllerProvider.notifier);
    final state = ref.watch(trafficCountControllerProvider);
    return SectionDetailCard(title: "Traffic Count", children: [
      Row(
            children: [
              Expanded(
                child: CustomTextFieldWithTitle(
                  title: "Truck",
                  hintText: "2196",
                  initialValue: state.trafficCountTruck,
                  onChanged: (value) {
                    controller.updateTrafficCountTruck(value);
                  },
                  validator: (v) => v.validate(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomTextFieldWithTitle(
                  title: "Car",
                  hintText: "1500",
                  initialValue: state.trafficCountCar,
                  onChanged: (value) {
                    controller.updateTrafficCountCar(value);
                  },
                  validator: (v) => v.validate(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomTextFieldWithTitle(
                  title: "Bike",
                  hintText: "3000",
                  initialValue: state.trafficCountBike,
                  onChanged: (value) {
                    controller.updateTrafficCountBike(value);
                  },
                  validator: (v) => v.validate(),
                ),
              ),
            ],
          ),
    ]);
  }
}