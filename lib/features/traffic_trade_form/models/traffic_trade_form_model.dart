import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_site_model.dart';

class TrafficTradeFormModel {
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

  const TrafficTradeFormModel({
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
  });

  Map<String, dynamic> toJson() {
    return {
      'nearbyTrafficSites': nearbyTrafficSites
          .map((site) => site.toJson())
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

  factory TrafficTradeFormModel.fromJson(Map<String, dynamic> json) {
    return TrafficTradeFormModel(
      nearbyTrafficSites:
          (json['nearbyTrafficSites'] as List<dynamic>?)
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
    );
  }

  @override
  String toString() {
    return 'TrafficTradeFormModel(nearbyTrafficSites: $nearbyTrafficSites, trafficCountTruck: $trafficCountTruck, trafficCountCar: $trafficCountCar, trafficCountBike: $trafficCountBike, dailyDieselSales: $dailyDieselSales, dailySuperSales: $dailySuperSales, dailyHOBCSales: $dailyHOBCSales, dailyLubricantSales: $dailyLubricantSales, rentExpectation: $rentExpectation, truckPortPotential: $truckPortPotential, salamMartPotential: $salamMartPotential, restaurantPotential: $restaurantPotential, selectedTM: $selectedTM, selectedRM: $selectedRM, selectedTMRecommendation: $selectedTMRecommendation, selectedRMRecommendation: $selectedRMRecommendation, tmRemarks: $tmRemarks, rmRemarks: $rmRemarks)';
  }

  static String get createSQLTableQuery {
    final idType = DatabaseHelper.idType;
    final textType = DatabaseHelper.textType;
    final intType = DatabaseHelper.intType;
    return '''
  CREATE TABLE traffic_trade_forms (
    id $idType,
    applicationId $textType,
    nearbyTrafficSites $textType,
    trafficCountTruck $textType,
    trafficCountCar $textType,
    trafficCountBike $textType,
    dailyDieselSales $textType,
    dailySuperSales $textType,
    dailyHOBCSales $textType,
    dailyLubricantSales $textType,
    rentExpectation $textType,
    truckPortPotential $textType,
    salamMartPotential $textType,
    restaurantPotential $textType,
    selectedTM $textType,
    selectedRM $textType,
    selectedTMRecommendation $textType,
    selectedRMRecommendation $textType,
    tmRemarks $textType,
    rmRemarks $textType,
    isSynced $intType DEFAULT 0,
    createdAt $textType,
    updatedAt $textType
  )
''';
  }
}
