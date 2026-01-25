import 'dart:math';
import 'package:tgpl_network/utils/extensions/nullable_fields_helper.dart';

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
    String? id,
    this.siteName,
    this.estimatedDailyDieselSale,
    this.estimatedDailySuperSale,
    this.estimatedDailyLubricantSale,
    this.omcName,
    this.isNfrFacility,
    this.nfrFacilities = const [],
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString() + Random().nextInt(10000).toString();

  TrafficSiteModel copyWith({
    String? siteName,
    String? estimatedDailyDieselSale,
    String? estimatedDailySuperSale,
    String? estimatedDailyLubricantSale,
    String? omcName,
    String? isNfrFacility,
    List<String>? nfrFacilities,
    List<String>? fieldsToNull,
  }) {
    return TrafficSiteModel(
      siteName: fieldsToNull
          .apply('siteName', siteName, this.siteName),
      estimatedDailyDieselSale: fieldsToNull.apply(
          'estimatedDailyDieselSale',
          estimatedDailyDieselSale,
          this.estimatedDailyDieselSale),
      estimatedDailySuperSale: fieldsToNull.apply(
          'estimatedDailySuperSale',
          estimatedDailySuperSale,
          this.estimatedDailySuperSale),
      estimatedDailyLubricantSale: fieldsToNull.apply(
          'estimatedDailyLubricantSale',
          estimatedDailyLubricantSale,
          this.estimatedDailyLubricantSale),
      omcName: fieldsToNull.apply('omcName', omcName, this.omcName),
      isNfrFacility: fieldsToNull.apply('isNfrFacility', isNfrFacility, this.isNfrFacility),
      nfrFacilities: fieldsToNull.apply(
          'nfrFacilities',
          nfrFacilities,
          this.nfrFacilities) ?? [],
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