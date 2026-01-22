// {
//     "Id": 59,
//     "ApplicationId": 2121,
//     "ProposedSiteName": "0",
//     "EstimateDailyDieselSale": 0,
//     "EstimateDailySuperSale": 0,
//     "EstimateLubricantSale": 0,
//     "ExpectedLeaseRentPerManth": null,
//     "NFRFacility": "NFR 1",
//     "NFRName": "0",
//     "NFLFacilityAvailable": "No"
// }

import 'package:tgpl_network/constants/app_database.dart';
import 'package:tgpl_network/core/database/database_helper.dart';

class TrafficTradesModel {
  final int? id;
  final int trafficTradeId;
  final int applicationId;
  final String proposedSiteName;
  final int estimateDailyDieselSale;
  final int estimateDailySuperSale;
  final int estimateLubricantSale;
  final int? expectedLeaseRentPerManth;
  final String nfrFacility;
  final String nfrName;
  final String nflFacilityAvailable;

  TrafficTradesModel({
    this.id,
    required this.trafficTradeId,
    required this.applicationId,
    required this.proposedSiteName,
    required this.estimateDailyDieselSale,
    required this.estimateDailySuperSale,
    required this.estimateLubricantSale,
    this.expectedLeaseRentPerManth,
    required this.nfrFacility,
    required this.nfrName,
    required this.nflFacilityAvailable,
  });

  factory TrafficTradesModel.fromAPIResponseMap(Map<String, dynamic> map) {
    return TrafficTradesModel(
      trafficTradeId: map['Id'],
      applicationId: map['ApplicationId'],
      proposedSiteName: map['ProposedSiteName'],
      estimateDailyDieselSale: map['EstimateDailyDieselSale'],
      estimateDailySuperSale: map['EstimateDailySuperSale'],
      estimateLubricantSale: map['EstimateLubricantSale'],
      expectedLeaseRentPerManth: map['ExpectedLeaseRentPerManth'],
      nfrFacility: map['NFRFacility'],
      nfrName: map['NFRName'],
      nflFacilityAvailable: map['NFLFacilityAvailable'],
    );
  }

  static String get createSQLTableQuery {
    final idType = DatabaseHelper.idType;
    final textType = DatabaseHelper.textType;
    final intType = DatabaseHelper.intType;
    return '''
    CREATE TABLE IF NOT EXISTS ${AppDatabase.trafficTradeTable} (
      id $idType,
      trafficTradeId $intType,
      applicationId $intType,
      proposedSiteName $textType,
      estimateDailyDieselSale $intType,
      estimateDailySuperSale $intType,
      estimateLubricantSale $intType,
      expectedLeaseRentPerManth $intType,
      nfrFacility $textType,
      nfrName $textType,
      nflFacilityAvailable $textType
    )
  ''';
  }

  factory TrafficTradesModel.fromDatabaseMap(Map<String, dynamic> map) {
    return TrafficTradesModel(
      id: map['id'],
      trafficTradeId: map['trafficTradeId'],
      applicationId: map['applicationId'],
      proposedSiteName: map['proposedSiteName'],
      estimateDailyDieselSale: map['estimateDailyDieselSale'],
      estimateDailySuperSale: map['estimateDailySuperSale'],
      estimateLubricantSale: map['estimateLubricantSale'],
      expectedLeaseRentPerManth: map['expectedLeaseRentPerManth'],
      nfrFacility: map['nfrFacility'],
      nfrName: map['nfrName'],
      nflFacilityAvailable: map['nflFacilityAvailable'],
    );
  }

  Map<String, dynamic> toDatabaseMap() {
    return {
      'id': id,
      'trafficTradeId': trafficTradeId,
      'applicationId': applicationId,
      'proposedSiteName': proposedSiteName,
      'estimateDailyDieselSale': estimateDailyDieselSale,
      'estimateDailySuperSale': estimateDailySuperSale,
      'estimateLubricantSale': estimateLubricantSale,
      'expectedLeaseRentPerManth': expectedLeaseRentPerManth,
      'nfrFacility': nfrFacility,
      'nfrName': nfrName,
      'nflFacilityAvailable': nflFacilityAvailable,
    };
  }
}
