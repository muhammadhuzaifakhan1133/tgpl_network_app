import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/features/application_detail/application_detail_controller.dart';
import 'package:tgpl_network/common/widgets/section_detail_card.dart';

class FeasibilityCard extends ConsumerWidget {
  final String isConversionPump;
  final String currentOMCName;
  final String isDealerInvestedSite;
  final String numberOfOperationYear;
  final String isCurrentlyOperational;
  final String currentLeaseExpired;
  final String dieselUGTSizeLitre;
  final String superUGTSizeLitre;
  final String numberOfDieselDispenser;
  final String numberOfSuperDispenser;
  final String currentlyCanopyCondition;
  final String conditionOfDispensors;
  final String conditionOfForecourt;
  final String recommendation;
  final String recommendationDetail;
  const FeasibilityCard({
    super.key,
    required this.isConversionPump,
    required this.currentOMCName,
    required this.isDealerInvestedSite,
    required this.numberOfOperationYear,
    required this.isCurrentlyOperational,
    required this.currentLeaseExpired,
    required this.dieselUGTSizeLitre,
    required this.superUGTSizeLitre,
    required this.numberOfDieselDispenser,
    required this.numberOfSuperDispenser,
    required this.currentlyCanopyCondition,
    required this.conditionOfDispensors,
    required this.conditionOfForecourt,
    required this.recommendation,
    required this.recommendationDetail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(
      applicationDetailControllerProvider.select(
        (state) => state.isFeasibilityCardExpanded,
      ),
    );
    return SectionDetailCard(
      title: "Feasibility",
      isExpanded: isExpanded,
      onToggleExpanded: () {
        ref
            .read(applicationDetailControllerProvider.notifier)
            .toggleFeasibilityCardExpanded();
      },
      children: [
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Is this Conversion Pump",
          hintText: isConversionPump,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Current OMC Name",
          hintText: currentOMCName,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Is this Dealer Invested Site",
          hintText: isDealerInvestedSite,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Number of Operation Year",
          hintText: numberOfOperationYear,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Is Currently Operational",
          hintText: isCurrentlyOperational,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Current Lease Expired",
          hintText: currentLeaseExpired,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Diesel UGT Size Litre",
          hintText: dieselUGTSizeLitre,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Super UGT SIze Litre",
          hintText: superUGTSizeLitre,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Number of Diesel Dispenser",
          hintText: numberOfDieselDispenser,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Number of Super Dispenser",
          hintText: numberOfSuperDispenser,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Currently Canopy Condition",
          hintText: currentlyCanopyCondition,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Condition of Dispensors",
          hintText: conditionOfDispensors,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Condition of Forecourt",
          hintText: conditionOfForecourt,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Recommendation",
          hintText: recommendation,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Recommendation Detail",
          hintText: recommendationDetail,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
