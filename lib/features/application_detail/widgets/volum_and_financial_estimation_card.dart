import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/features/application_detail/application_detail_controller.dart';
import 'package:tgpl_network/common/widgets/section_detail_card.dart';

class VolumAndFinancialEstimationCard extends ConsumerWidget {
  final String estimatedDailyDieselSales;
  final String estimatedDailySuperSales;
  final String estimatedDailyLubricantSales;
  final String dealerExpectationOfLeaseRentalPerMonth;
  final String truckPortPotential;
  final String salamMartPotential;
  final String restaurantPotential;

  const VolumAndFinancialEstimationCard({
    super.key,
    required this.estimatedDailyDieselSales,
    required this.estimatedDailySuperSales,
    required this.estimatedDailyLubricantSales,
    required this.dealerExpectationOfLeaseRentalPerMonth,
    required this.truckPortPotential,
    required this.salamMartPotential,
    required this.restaurantPotential,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(
      applicationDetailControllerProvider.select(
        (state) => state.isVolumeAndFinancialEstimationCardExpanded,
      ),
    );
    return SectionDetailCard(
      title: "Volume & Financial Estimation",
      isExpanded: isExpanded,
      onToggleExpanded: () {
        ref
            .read(applicationDetailControllerProvider.notifier)
            .toggleVolumeAndFinancialEstimationCardExpanded();
      },
      children: [
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Estimated Daily Diesel Sales",
          hintText: estimatedDailyDieselSales,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Estimated Daily Super Sales",
          hintText: estimatedDailySuperSales,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Estimated Daily Lubricant Sales",
          hintText: estimatedDailyLubricantSales,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Dealer Expectation of Lease Rental / month",
          hintText: dealerExpectationOfLeaseRentalPerMonth,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Truck Port Potential",
          hintText: truckPortPotential,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Salam Mart Potential",
          hintText: salamMartPotential,
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          readOnly: true,
          title: "Resturant Potential",
          hintText: restaurantPotential,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
