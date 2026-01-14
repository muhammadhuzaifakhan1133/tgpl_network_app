import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/yes_no_na_values_provider.dart';
import 'package:tgpl_network/common/widgets/custom_dropdown_with_title.dart';
import 'package:tgpl_network/common/widgets/custom_textfield_with_title.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/constants/app_textstyles.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/traffic_trade_form_controller.dart';
import 'package:tgpl_network/utils/string_validation_extension.dart';

class VolumAndFinancialEstimationCardForm extends ConsumerWidget {
  const VolumAndFinancialEstimationCardForm({super.key});

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
            "Volume & Financial Estimation",
            style: AppTextstyles.googleInter700black28.copyWith(
              fontSize: 24,
              color: AppColors.black2Color,
            ),
          ),
          const SizedBox(height: 10),
          // Estimated Daily Diesel Sales
          CustomTextFieldWithTitle(
            title: "Estimated Daily Diesel Sales",
            hintText: "Enter estimated daily diesel sales",
            controller: controller.dailyDieselSalesController,
            validator: (v) => v.validate(),
          ),
          // Estimated Daily Super Sales
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Estimated Daily Super Sales",
            hintText: "Enter estimated daily super sales",
            controller: controller.dailySuperSalesController,
            validator: (v) => v.validate(),
          ),
          // Estimated Daily HOBC Sales
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Estimated Daily HOBC Sales",
            hintText: "Enter estimated daily HOBC sales",
            controller: controller.dailyHOBCSalesController,
            validator: (v) => v.validate(),
          ),
          // Estimated Daily Lubricant Sales
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Estimated Daily Lubricant Sales",
            hintText: "Enter estimated daily lubricant sales",
            controller: controller.dailyLubricantSalesController,
            validator: (v) => v.validate(),
          ),
          // Dealer expectation of Lease Rental / month?
          const SizedBox(height: 10),
          CustomTextFieldWithTitle(
            title: "Dealer expectation of Lease Rental / month?",
            hintText: "Enter dealer expectation of lease rental",
            controller: controller.rentExpectationController,
            validator: (v) => v.validate(),
          ),
          // Truck Port Potential? (dropdown)
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) {
              final selectedTruckPortPotential = ref.watch(
                trafficTradeFormControllerProvider.select(
                  (s) => s.truckPortPotential,
                ),
              );
              return CustomDropDownWithTitle(
                title: "Truck Port Potential?",
                hintText: "Select truck port potential",
                selectedItem: selectedTruckPortPotential,
                items: ref.read(yesNoNaValuesProvider),
                onChanged: (value) {
                  if (value == null) return;
                  controller.setTruckPortPotential(value.toString());
                },
                validator: (v) => v.validate(),
              );
            },
          ),
          // Salam Mart Potential? (dropdown)
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) {
              final selectedSalamMartPotential = ref.watch(
                trafficTradeFormControllerProvider.select(
                  (s) => s.salamMartPotential,
                ),
              );
              return CustomDropDownWithTitle(
                title: "Salam Mart Potential?",
                hintText: "Select salam mart potential",
                selectedItem: selectedSalamMartPotential,
                items: ref.read(yesNoNaValuesProvider),
                onChanged: (value) {
                  if (value == null) return;
                  controller.setSalamMartPotential(value.toString());
                },
                validator: (v) => v.validate(),
              );
            },
          ),
          // Restaurant Potential? (dropdown)
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) {
              final selectedResturantPotential = ref.watch(
                trafficTradeFormControllerProvider.select(
                  (s) => s.resturantPotential,
                ),
              );
              return CustomDropDownWithTitle(
                title: "Restaurant Potential?",
                hintText: "Select restaurant potential",
                selectedItem: selectedResturantPotential,
                items: ref.read(yesNoNaValuesProvider),
                onChanged: (value) {
                  if (value == null) return;
                  controller.setResturantPotential(value.toString());
                },
                validator: (v) => v.validate(),
              );
            },
          ),
        ],
      ),
    );
  }
}
