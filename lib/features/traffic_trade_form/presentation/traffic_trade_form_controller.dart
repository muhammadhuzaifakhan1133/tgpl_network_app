import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_model.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/traffic_trade_form_assembler.dart';

final trafficTradeFormControllerProvider =
    AsyncNotifierProvider.autoDispose<TrafficTradeFormController, void>(
  TrafficTradeFormController.new,
);

class TrafficTradeFormController extends AsyncNotifier<void> {
  

  @override
  FutureOr<void> build() {
    // Initialize empty state
  }

  /// Initialize form with data (for edit mode)
  Future<void> initialize(String appId) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      // TODO: Fetch existing data from API if editing
      // Example:
      // final data = await ref.read(trafficTradeRepositoryProvider).getTrafficTradeForm(appId);
      // if (data != null) {
      //   _prefillFormData(data);
      // }

      // For now, just complete successfully
      await Future.delayed(const Duration(milliseconds: 500));
    });
  }

  /// Submit the traffic trade form
  Future<bool> submitTrafficTradeForm() async {
    // Validate form using FormKey
    

    state = const AsyncValue.loading();

    try {
      // Gather all form data
      final trafficTradeFormData = TrafficTradeFormAssembler.assemble(ref);

      // Additional custom validation if needed
      if (!_validateFormData(trafficTradeFormData)) {
        state = const AsyncValue.data(null);
        return false;
      }

      // TODO: Submit to API
      // Example:
      // await ref.read(trafficTradeRepositoryProvider).submitTrafficTradeForm(trafficTradeFormData);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      log('Traffic Trade Form Data: ${trafficTradeFormData.toJson()}');

      state = const AsyncValue.data(null);
      return true;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      log('Error submitting form: $e');
      return false;
    }
  }

  /// Additional custom validation (optional)
  bool _validateFormData(TrafficTradeFormModel data) {
    // Add custom validation logic here if needed

    // Example: Validate at least one nearby site exists
    if (data.nearbyTrafficSites.isEmpty) {
      log('Validation failed: At least one nearby site is required');
      return false;
    }

    // Add more custom validation as needed

    return true;
  }

  /// Prefill form data (for edit mode)
  // void _prefillFormData(TrafficTradeFormModel data) {
  //   // Prefill nearby sites
  //   ref.read(nearbySitesControllerProvider.notifier).prefillFormData(
  //         nearbyTrafficSites: data.nearbyTrafficSites,
  //       );

  //   // Prefill traffic count
  //   ref.read(trafficCountControllerProvider.notifier).prefillFormData(
  //         trafficCountTruck: data.trafficCountTruck ?? '',
  //         trafficCountCar: data.trafficCountCar ?? '',
  //         trafficCountBike: data.trafficCountBike ?? '',
  //       );

  //   // Prefill volume & financial
  //   ref.read(volumeFinancialControllerProvider.notifier).prefillFormData(
  //         dailyDieselSales: data.dailyDieselSales ?? '',
  //         dailySuperSales: data.dailySuperSales ?? '',
  //         dailyHOBCSales: data.dailyHOBCSales ?? '',
  //         dailyLubricantSales: data.dailyLubricantSales ?? '',
  //         rentExpectation: data.rentExpectation ?? '',
  //         truckPortPotential: data.truckPortPotential ?? '',
  //         salamMartPotential: data.salamMartPotential ?? '',
  //         restaurantPotential: data.restaurantPotential ?? '',
  //       );

  //   // Prefill recommendation
  //   ref.read(recommendationControllerProvider.notifier).prefillFormData(
  //         selectedTM: data.selectedTM ?? '',
  //         selectedRM: data.selectedRM ?? '',
  //         selectedTMRecommendation: data.selectedTMRecommendation ?? '',
  //         selectedRMRecommendation: data.selectedRMRecommendation ?? '',
  //         tmRemarks: data.tmRemarks ?? '',
  //         rmRemarks: data.rmRemarks ?? '',
  //       );
  // }
}