import 'dart:convert';

import 'package:tgpl_network/features/traffic_trade_form/models/traffic_site_model.dart';

class TrafficTradeFormModel {
  final String? applicationId;
  // Nearby Sites
  final List<TrafficSiteModel> nearbyTrafficSites;

  // Traffic Count
  final String? trafficCountTruck;
  final String? trafficCountCar;
  final String? trafficCountBike;

  // Volume & Financial Estimation
  final String? dailyDieselSales;
  final String? dailySuperSales;
  final String? dailyHOBCSales;
  final String? dailyLubricantSales;
  final String? rentExpectation;
  final String? truckPortPotential;
  final String? salamMartPotential;
  final String? restaurantPotential;

  // Recommendation
  final String? selectedTM;
  final String? selectedRM;
  final String? selectedTMRecommendation;
  final String? selectedRMRecommendation;
  final String? tmRemarks;
  final String? rmRemarks;

  final bool isSubmitting;
  final String errorMessage;
  final String createdAt;
  final String updatedAt;

  const TrafficTradeFormModel({
    this.applicationId,
    this.nearbyTrafficSites = const [],
    this.trafficCountTruck,
    this.trafficCountCar,
    this.trafficCountBike,
    this.dailyDieselSales,
    this.dailySuperSales,
    this.dailyHOBCSales,
    this.dailyLubricantSales,
    this.rentExpectation,
    this.truckPortPotential,
    this.salamMartPotential,
    this.restaurantPotential,
    this.selectedTM,
    this.selectedRM,
    this.selectedTMRecommendation,
    this.selectedRMRecommendation,
    this.tmRemarks,
    this.rmRemarks,
    this.isSubmitting = false,
    this.errorMessage = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  Map<String, dynamic> toDatabaseMap() {
    return {
      'applicationId': applicationId,
      'nearbyTrafficSites': nearbyTrafficSites
          .map((site) => site.toDatabaseMap())
          .toList(),
      'trafficCountTruck': trafficCountTruck,
      'trafficCountCar': trafficCountCar,
      'trafficCountBike': trafficCountBike,
      'dailyDieselSales': dailyDieselSales,
      'dailySuperSales': dailySuperSales,
      'dailyHOBCSales': dailyHOBCSales,
      'dailyLubricantSales': dailyLubricantSales,
      'rentExpectation': rentExpectation,
      'truckPortPotential': truckPortPotential,
      'salamMartPotential': salamMartPotential,
      'restaurantPotential': restaurantPotential,
      'selectedTM': selectedTM,
      'selectedRM': selectedRM,
      'selectedTMRecommendation': selectedTMRecommendation,
      'selectedRMRecommendation': selectedRMRecommendation,
      'tmRemarks': tmRemarks,
      'rmRemarks': rmRemarks,
    };
  }

  factory TrafficTradeFormModel.fromDatabaseMap(Map<String, dynamic> json) {
    return TrafficTradeFormModel(
      applicationId: json['applicationId'] as String?,
      nearbyTrafficSites:
          (jsonDecode((json['nearbyTrafficSites'])) as List<dynamic>?)
              ?.map(
                (site) =>
                    TrafficSiteModel.fromJson(site as Map<String, dynamic>),
              )
              .toList() ??
          [],
      trafficCountTruck: json['trafficCountTruck'] as String?,
      trafficCountCar: json['trafficCountCar'] as String?,
      trafficCountBike: json['trafficCountBike'] as String?,
      dailyDieselSales: json['dailyDieselSales'] as String?,
      dailySuperSales: json['dailySuperSales'] as String?,
      dailyHOBCSales: json['dailyHOBCSales'] as String?,
      dailyLubricantSales: json['dailyLubricantSales'] as String?,
      rentExpectation: json['rentExpectation'] as String?,
      truckPortPotential: json['truckPortPotential'] as String?,
      salamMartPotential: json['salamMartPotential'] as String?,
      restaurantPotential: json['restaurantPotential'] as String?,
      selectedTM: json['selectedTM'] as String?,
      selectedRM: json['selectedRM'] as String?,
      selectedTMRecommendation: json['selectedTMRecommendation'] as String?,
      selectedRMRecommendation: json['selectedRMRecommendation'] as String?,
      tmRemarks: json['tmRemarks'] as String?,
      rmRemarks: json['rmRemarks'] as String?,
      errorMessage: json['errorMessage'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }

  TrafficTradeFormModel copyWith({
    List<TrafficSiteModel>? nearbyTrafficSites,
    String? trafficCountTruck,
    String? trafficCountCar,
    String? trafficCountBike,
    String? dailyDieselSales,
    String? dailySuperSales,
    String? dailyHOBCSales,
    String? dailyLubricantSales,
    String? rentExpectation,
    String? truckPortPotential,
    String? salamMartPotential,
    String? restaurantPotential,
    String? selectedTM,
    String? selectedRM,
    String? selectedTMRecommendation,
    String? selectedRMRecommendation,
    String? tmRemarks,
    String? rmRemarks,
    bool? isSubmitting,
    String? errorMessage,
  }) {
    return TrafficTradeFormModel(
      nearbyTrafficSites: nearbyTrafficSites ?? this.nearbyTrafficSites,
      trafficCountTruck: trafficCountTruck ?? this.trafficCountTruck,
      trafficCountCar: trafficCountCar ?? this.trafficCountCar,
      trafficCountBike: trafficCountBike ?? this.trafficCountBike,
      dailyDieselSales: dailyDieselSales ?? this.dailyDieselSales,
      dailySuperSales: dailySuperSales ?? this.dailySuperSales,
      dailyHOBCSales: dailyHOBCSales ?? this.dailyHOBCSales,
      dailyLubricantSales: dailyLubricantSales ?? this.dailyLubricantSales,
      rentExpectation: rentExpectation ?? this.rentExpectation,
      truckPortPotential: truckPortPotential ?? this.truckPortPotential,
      salamMartPotential: salamMartPotential ?? this.salamMartPotential,
      restaurantPotential: restaurantPotential ?? this.restaurantPotential,
      selectedTM: selectedTM ?? this.selectedTM,
      selectedRM: selectedRM ?? this.selectedRM,
      selectedTMRecommendation:
          selectedTMRecommendation ?? this.selectedTMRecommendation,
      selectedRMRecommendation:
          selectedRMRecommendation ?? this.selectedRMRecommendation,
      tmRemarks: tmRemarks ?? this.tmRemarks,
      rmRemarks: rmRemarks ?? this.rmRemarks,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'TrafficTradeFormModel(nearbyTrafficSites: $nearbyTrafficSites, trafficCountTruck: $trafficCountTruck, trafficCountCar: $trafficCountCar, trafficCountBike: $trafficCountBike, dailyDieselSales: $dailyDieselSales, dailySuperSales: $dailySuperSales, dailyHOBCSales: $dailyHOBCSales, dailyLubricantSales: $dailyLubricantSales, rentExpectation: $rentExpectation, truckPortPotential: $truckPortPotential, salamMartPotential: $salamMartPotential, restaurantPotential: $restaurantPotential, selectedTM: $selectedTM, selectedRM: $selectedRM, selectedTMRecommendation: $selectedTMRecommendation, selectedRMRecommendation: $selectedRMRecommendation, tmRemarks: $tmRemarks, rmRemarks: $rmRemarks)';
  }

  Map<String, dynamic> toApiMap() {
    return {
      "applicationId": applicationId,
      "nearbyTrafficSites": nearbyTrafficSites
          .map((site) => site.toApiMap())
          .toList(),
      "trafficCountTruck": trafficCountTruck,
      "trafficCountCar": trafficCountCar,
      "trafficCountBike": trafficCountBike,
      "dailyDieselSales": dailyDieselSales,
      "dailySuperSales": dailySuperSales,
      "dailyHOBCSales": dailyHOBCSales,
      "dailyLubricantSales": dailyLubricantSales,
      "rentExpectation": rentExpectation,
      "truckPortPotential": truckPortPotential,
      "salamMartPotential": salamMartPotential,
      "restaurantPotential": restaurantPotential,
      "selectedTM": selectedTM,
      "selectedRM": selectedRM,
      "selectedTMRecommendation": selectedTMRecommendation,
      "selectedRMRecommendation": selectedRMRecommendation,
      "tmRemarks": tmRemarks,
      "rmRemarks": rmRemarks,
    };
  }

  String? get validate {
    // TODO: add custom validation logic
    return null;
  }
}
