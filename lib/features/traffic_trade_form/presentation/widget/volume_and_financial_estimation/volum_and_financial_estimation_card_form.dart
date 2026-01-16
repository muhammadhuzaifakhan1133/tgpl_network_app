import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/yes_no_na_values_provider.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/common/widgets/section_detail_card.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/volume_and_financial_estimation/volume_and_financial_estimation_controller.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

class VolumAndFinancialEstimationCardForm extends ConsumerWidget {
  const VolumAndFinancialEstimationCardForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(volumeFinancialControllerProvider.notifier);
    final state = ref.watch(volumeFinancialControllerProvider);

    return SectionDetailCard(
      title: "Volume & Financial Estimation",
      children: [
        CustomTextFieldWithTitle(
          title: "Estimated Daily Diesel Sales",
          hintText: "Enter estimated daily diesel sales",
          initialValue: state.dailyDieselSales,
          onChanged: (value) {
            controller.updateDailyDieselSales(value);
          },
          validator: (v) => v.validate(),
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Estimated Daily Super Sales",
          hintText: "Enter estimated daily super sales",
          initialValue: state.dailySuperSales,
          onChanged: (value) {
            controller.updateDailySuperSales(value);
          },
          validator: (v) => v.validate(),
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Estimated Daily HOBC Sales",
          hintText: "Enter estimated daily HOBC sales",
          initialValue: state.dailyHOBCSales,
          onChanged: (value) {
            controller.updateDailyHOBCSales(value);
          },
          validator: (v) => v.validate(),
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Estimated Daily Lubricant Sales",
          hintText: "Enter estimated daily lubricant sales",
          initialValue: state.dailyLubricantSales,
          onChanged: (value) {
            controller.updateDailyLubricantSales(value);
          },
          validator: (v) => v.validate(),
        ),
        const SizedBox(height: 10),
        CustomTextFieldWithTitle(
          title: "Dealer expectation of Lease Rental / month?",
          hintText: "Enter dealer expectation of lease rental",
          initialValue: state.rentExpectation,
          onChanged: (value) {
            controller.updateRentExpectation(value);
          },
          validator: (v) => v.validate(),
        ),
        const SizedBox(height: 10),
        CustomDropDownWithTitle(
          title: "Truck Port Potential?",
          hintText: "Select truck port potential",
          selectedItem: state.truckPortPotential,
          items: ref.read(yesNoNaValuesProvider),
          onChanged: (value) {
            if (value == null) return;
            controller.setTruckPortPotential(value.toString());
          },
          validator: (v) => v.validate(),
        ),
        const SizedBox(height: 10),
        CustomDropDownWithTitle(
          title: "Salam Mart Potential?",
          hintText: "Select salam mart potential",
          selectedItem: state.salamMartPotential,
          items: ref.read(yesNoNaValuesProvider),
          onChanged: (value) {
            if (value == null) return;
            controller.setSalamMartPotential(value.toString());
          },
          validator: (v) => v.validate(),
        ),
        const SizedBox(height: 10),
        CustomDropDownWithTitle(
          title: "Restaurant Potential?",
          hintText: "Select restaurant potential",
          selectedItem: state.restaurantPotential,
          items: ref.read(yesNoNaValuesProvider),
          onChanged: (value) {
            if (value == null) return;
            controller.setRestaurantPotential(value.toString());
          },
          validator: (v) => v.validate(),
        ),
      ],
    );
  }
}
