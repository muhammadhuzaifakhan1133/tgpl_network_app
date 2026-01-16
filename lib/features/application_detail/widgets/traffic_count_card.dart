import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/features/application_detail/application_detail_controller.dart';
import 'package:tgpl_network/common/widgets/section_detail_card.dart';

class TrafficCountCard extends ConsumerWidget {
  final String cars;
  final String bikes;
  final String trucks;

  const TrafficCountCard({
    super.key,
    required this.cars,
    required this.bikes,
    required this.trucks,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(
      applicationDetailControllerProvider.select(
        (state) => state.isTrafficCountCardExpanded,
      ),
    );
    return SectionDetailCard(
      title: "Traffic Count",
      isExpanded: isExpanded,
      onToggleExpanded: () {
        ref
            .read(applicationDetailControllerProvider.notifier)
            .toggleTrafficCountCardExpanded();
      },
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextFieldWithTitle(
                readOnly: true,
                title: "Cars",
                hintText: cars,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextFieldWithTitle(
                readOnly: true,
                title: "Bikes",
                hintText: bikes,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomTextFieldWithTitle(
                readOnly: true,
                title: "Trucks",
                hintText: trucks,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
