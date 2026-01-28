import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_model.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/nearby_sites/nearby_sites_form_controller.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/traffic_count/traffic_count_form_controller.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/traffic_recommendation/traffic_recommendation_controller.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/volume_and_financial_estimation/volume_and_financial_estimation_controller.dart';

class TrafficTradeFormAssembler {
  static void dessembleFromApp(Ref ref, ApplicationModel app) {
    ref.read(nearbySitesControllerProvider.notifier).loadFromApplication(app);
    ref.read(trafficCountControllerProvider.notifier).loadFromApplication(app);
    ref.read(volumeFinancialControllerProvider.notifier).loadFromApplication(app);
    ref.read(recommendationControllerProvider.notifier).loadFromApplication(app);
  }

  static void dessembleFromTrafficTradeFormModel(Ref ref, TrafficTradeFormModel form) {
    ref.read(nearbySitesControllerProvider.notifier).loadFromTrafficTradeFormModel(form);
    ref.read(trafficCountControllerProvider.notifier).loadFromTrafficTradeFormModel(form);
    ref.read(volumeFinancialControllerProvider.notifier).loadFromTrafficTradeFormModel(form);
    ref.read(recommendationControllerProvider.notifier).loadFromTrafficTradeFormModel(form);
  }
  
  static TrafficTradeFormModel assemble(Ref ref) {

   final nearbySites = ref.read(nearbySitesControllerProvider);
    final trafficCount = ref.read(trafficCountControllerProvider);
    final volumeFinancial = ref.read(volumeFinancialControllerProvider);
    final recommendation = ref.read(recommendationControllerProvider);

    return TrafficTradeFormModel(
      // Nearby Sites
      nearbyTrafficSites: nearbySites.nearbyTrafficSites,

      // Traffic Count
      trafficCountTruck: trafficCount.trafficCountTruck,
      trafficCountCar: trafficCount.trafficCountCar,
      trafficCountBike: trafficCount.trafficCountBike,

      // Volume & Financial Estimation
      dailyDieselSales: volumeFinancial.dailyDieselSales,
      dailySuperSales: volumeFinancial.dailySuperSales,
      dailyHOBCSales: volumeFinancial.dailyHOBCSales,
      dailyLubricantSales: volumeFinancial.dailyLubricantSales,
      rentExpectation: volumeFinancial.rentExpectation,
      truckPortPotential: volumeFinancial.truckPortPotential,
      salamMartPotential: volumeFinancial.salamMartPotential,
      restaurantPotential: volumeFinancial.restaurantPotential,

      // Recommendation
      selectedTM: recommendation.selectedTM,
      selectedRM: recommendation.selectedRM,
      selectedTMRecommendation: recommendation.selectedTMRecommendation,
      selectedRMRecommendation: recommendation.selectedRMRecommendation,
      tmRemarks: recommendation.tmRemarks,
      rmRemarks: recommendation.rmRemarks,
    );
  }

}