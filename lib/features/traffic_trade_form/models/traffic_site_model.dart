import 'package:flutter/foundation.dart';

class TrafficSiteModel {
  final String id;
  final String? siteName;
  final String? estimatedDailyDieselSale;
  final String? estimatedDailySuperSale;
  final String? estimatedDailyLubricantSale;
  final String? omcName;
  final String? isNfrFacility;
  final List<String> nfrFacilities;

  TrafficSiteModel({
    this.siteName,
    this.estimatedDailyDieselSale,
    this.estimatedDailySuperSale,
    this.estimatedDailyLubricantSale,
    this.omcName,
    this.isNfrFacility,
    this.nfrFacilities = const [],
  }) : id = UniqueKey().toString();

  TrafficSiteModel copyWith({
    String? siteName,
    String? estimatedDailyDieselSale,
    String? estimatedDailySuperSale,
    String? estimatedDailyLubricantSale,
    String? omcName,
    String? isNfrFacility,
    List<String>? nfrFacilities,
  }) {
    return TrafficSiteModel(
      siteName: siteName ?? this.siteName,
      estimatedDailyDieselSale: estimatedDailyDieselSale ?? this.estimatedDailyDieselSale,
      estimatedDailySuperSale: estimatedDailySuperSale ?? this.estimatedDailySuperSale,
      estimatedDailyLubricantSale: estimatedDailyLubricantSale ?? this.estimatedDailyLubricantSale,
      omcName: omcName ?? this.omcName,
      isNfrFacility: isNfrFacility ?? this.isNfrFacility,
      nfrFacilities: nfrFacilities ?? this.nfrFacilities,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'siteName': siteName,
      'estimatedDailyDieselSale': estimatedDailyDieselSale,
      'estimatedDailySuperSale': estimatedDailySuperSale,
      'estimatedDailyLubricantSale': estimatedDailyLubricantSale,
      'omcName': omcName,
      'isNfrFacility': isNfrFacility,
      'nfrFacilities': nfrFacilities,
    };
  }

  factory TrafficSiteModel.fromJson(Map<String, dynamic> json) {
    return TrafficSiteModel(
      siteName: json['siteName'] as String?,
      estimatedDailyDieselSale: json['estimatedDailyDieselSale'] as String?,
      estimatedDailySuperSale: json['estimatedDailySuperSale'] as String?,
      estimatedDailyLubricantSale: json['estimatedDailyLubricantSale'] as String?,
      omcName: json['omcName'] as String?,
      isNfrFacility: json['isNfrFacility'] as String?,
      nfrFacilities: (json['nfrFacilities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  @override
  String toString() {
    return 'TrafficSiteModel(siteName: $siteName, estimatedDailyDieselSale: $estimatedDailyDieselSale, estimatedDailySuperSale: $estimatedDailySuperSale, estimatedDailyLubricantSale: $estimatedDailyLubricantSale, omcName: $omcName, isNfrFacility: $isNfrFacility, nfrFacilities: $nfrFacilities)';
  }
}