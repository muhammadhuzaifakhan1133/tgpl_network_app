// lib/features/master_data/data/datasources/master_data_local_data_source.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/features/applications_filter/applications_filter_state.dart';
import 'package:tgpl_network/utils/yes_no_enum_with_extension.dart';
import '../models/application_model.dart';
import '../models/city_model.dart';
import 'dart:convert';

abstract class MasterDataLocalDataSource {
  Future<void> saveMasterData(MasterDataResponseModel data);
  Future<List<ApplicationModel>> getApplications({
    FilterSelectionState? filters,
  });
  Future<List<CityModel>> getCities();
  Future<Map<String, List<String>>> getMasterLists();
  Future<void> clearAllData();
}

class MasterDataLocalDataSourceImpl implements MasterDataLocalDataSource {
  final DatabaseHelper _databaseHelper;

  MasterDataLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<void> saveMasterData(MasterDataResponseModel data) async {
    final db = await _databaseHelper.database;

    await db.transaction((txn) async {
      // Clear existing data
      await txn.delete('applications');
      await txn.delete('cities');
      await txn.delete('traffic_trades');
      await txn.delete('master_lists');

      // Insert applications
      for (var app in data.applicationAndSurveyList) {
        final appModel = ApplicationModel.fromJson(app);
        await txn.insert('applications', appModel.toMap());
      }

      // Insert cities
      for (var city in data.userCityList) {
        await txn.insert('cities', {
          'cityId': city['Id'],
          'name': city['Name'],
        });
      }

      // Insert traffic trades
      for (var trade in data.traficTradeSitesList) {
        await txn.insert('traffic_trades', {
          'trafficTradeId': trade['Id'],
          'applicationId': trade['ApplicationId'],
          'proposedSiteName': trade['ProposedSiteName'],
          'estimateDailyDieselSale': trade['EstimateDailyDieselSale'],
          'estimateDailySuperSale': trade['EstimateDailySuperSale'],
          'estimateLubricantSale': trade['EstimateLubricantSale'],
        });
      }

      // Insert master lists
      await txn.insert('master_lists', {
        'listType': 'NearestDepo',
        'values': jsonEncode(data.nearestDepo),
      });
      await txn.insert('master_lists', {
        'listType': 'TradeAreaType',
        'values': jsonEncode(data.tradeAreaType),
      });
      await txn.insert('master_lists', {
        'listType': 'DealerInvestmentType',
        'values': jsonEncode(data.dealerInvestmentType),
      });
      await txn.insert('master_lists', {
        'listType': 'GFBList',
        'values': jsonEncode(data.gfbList),
      });
      await txn.insert('master_lists', {
        'listType': 'RecommendationList',
        'values': jsonEncode(data.recommendationList),
      });
      await txn.insert('master_lists', {
        'listType': 'ShiftHourList',
        'values': jsonEncode(data.shiftHourList),
      });
      await txn.insert('master_lists', {
        'listType': 'HMLList',
        'values': jsonEncode(data.hmlList),
      });
      await txn.insert('master_lists', {
        'listType': 'YNList',
        'values': jsonEncode(data.ynList),
      });
      await txn.insert('master_lists', {
        'listType': 'YNNList',
        'values': jsonEncode(data.ynnList),
      });
      await txn.insert('master_lists', {
        'listType': 'NFRList',
        'values': jsonEncode(data.nfrList),
      });
    });
  }

  @override
  Future<List<ApplicationModel>> getApplications({
    FilterSelectionState? filters,
  }) async {
    final db = await _databaseHelper.database;

    // Build WHERE clause dynamically
    final whereConditions = <String>[];
    final whereArgs = <dynamic>[];

    if (filters != null) {
      // Text filters
      if (filters.selectedCity != null) {
        whereConditions.add('cityName = ?');
        whereArgs.add(filters.selectedCity);
      }

      if (filters.selectedPriority != null) {
        whereConditions.add('priority = ?');
        whereArgs.add(filters.selectedPriority);
      }

      if (filters.selectedStatus != null) {
        whereConditions.add('statusId = ?');
        whereArgs.add(int.tryParse(filters.selectedStatus!) ?? 0);
      }

      if (filters.applicationId != null) {
        whereConditions.add('applicationId = ?');
        whereArgs.add(int.tryParse(filters.applicationId!) ?? 0);
      }

      if (filters.entryCode != null && filters.entryCode!.isNotEmpty) {
        whereConditions.add('entryCode LIKE ?');
        whereArgs.add('%${filters.entryCode}%');
      }

      if (filters.preparedBy != null && filters.preparedBy!.isNotEmpty) {
        whereConditions.add('preparedBy LIKE ?');
        whereArgs.add('%${filters.preparedBy}%');
      }

      if (filters.district != null && filters.district!.isNotEmpty) {
        whereConditions.add('district LIKE ?');
        whereArgs.add('%${filters.district}%');
      }

      if (filters.dealerName != null && filters.dealerName!.isNotEmpty) {
        whereConditions.add('dealerName LIKE ?');
        whereArgs.add('%${filters.dealerName}%');
      }

      if (filters.dealerContact != null && filters.dealerContact!.isNotEmpty) {
        whereConditions.add('dealerContact LIKE ?');
        whereArgs.add('%${filters.dealerContact}%');
      }

      if (filters.address != null && filters.address!.isNotEmpty) {
        whereConditions.add('locationAddress LIKE ?');
        whereArgs.add('%${filters.address}%');
      }

      if (filters.referredBy != null && filters.referredBy!.isNotEmpty) {
        whereConditions.add('referedBy LIKE ?'); whereArgs.add('%${filters.referredBy}%');
  }

  if (filters.source != null && filters.source!.isNotEmpty) {
    whereConditions.add('source LIKE ?');
    whereArgs.add('%${filters.source}%');
  }

  if (filters.sourceName != null && filters.sourceName!.isNotEmpty) {
    whereConditions.add('sourceName LIKE ?');
    whereArgs.add('%${filters.sourceName}%');
  }

  if (filters.siteName != null && filters.siteName!.isNotEmpty) {
    whereConditions.add('proposedSiteName1 LIKE ?');
    whereArgs.add('%${filters.siteName}%');
  }

  // Yes/No filters (stored as 0 or 1 in database)
  if (filters.surveyProfile != null) {
    whereConditions.add('surveyDealerProfileDone = ?');
    whereArgs.add(filters.surveyProfile!.value);
  }

  if (filters.trafficTrade != null) {
    whereConditions.add('trafficTradeDone = ?');
    whereArgs.add(filters.trafficTrade!.value);
  }

  if (filters.feasibility != null) {
    whereConditions.add('feasibilityDone = ?');
    whereArgs.add(filters.feasibility!.value);
  }

  if (filters.negotiation != null) {
    whereConditions.add('negotiationDone = ?');
    whereArgs.add(filters.negotiation!.value);
  }

  if (filters.mouSign != null) {
    whereConditions.add('mouSignOffDone = ?');
    whereArgs.add(filters.mouSign!.value);
  }

  if (filters.joiningFee != null) {
    whereConditions.add('joiningFeeDone = ?');
    whereArgs.add(filters.joiningFee!.value);
  }

  if (filters.franchiseAgreement != null) {
    whereConditions.add('franchiseAgreementDone = ?');
    whereArgs.add(filters.franchiseAgreement!.value);
  }

  if (filters.feasibilityFinalization != null) {
    whereConditions.add('feasibilityFinalizationDone = ?');
    whereArgs.add(filters.feasibilityFinalization!.value);
  }

  if (filters.explosiveLayout != null) {
    whereConditions.add('explosiveLayoutDone = ?');
    whereArgs.add(filters.explosiveLayout!.value);
  }

  if (filters.drawing != null) {
    whereConditions.add('drawingsDone = ?');
    whereArgs.add(filters.drawing!.value);
  }

  if (filters.topography != null) {
    whereConditions.add('topographyDone = ?');
    whereArgs.add(filters.topography!.value);
  }

  if (filters.issuanceOfDrawing != null) {
    whereConditions.add('issuanceOfDrawingsDone = ?');
    whereArgs.add(filters.issuanceOfDrawing!.value);
  }

  if (filters.appliedInExplosive != null) {
    whereConditions.add('appliedInExplosiveDone = ?');
    whereArgs.add(filters.appliedInExplosive!.value);
  }

  if (filters.dcNoc != null) {
    whereConditions.add('dcNocDone = ?');
    whereArgs.add(filters.dcNoc!.value);
  }

  if (filters.capex != null) {
    whereConditions.add('capexDone = ?');
    whereArgs.add(filters.capex!.value);
  }

  if (filters.leaseAgreement != null) {
    whereConditions.add('leaseAgreementDone = ?');
    whereArgs.add(filters.leaseAgreement!.value);
  }

  if (filters.hoto != null) {
    whereConditions.add('hotoDone = ?');
    whereArgs.add(filters.hoto!.value);
  }

  if (filters.construction != null) {
    whereConditions.add('constructionDone = ?');
    whereArgs.add(filters.construction!.value);
  }

  if (filters.inauguration != null) {
    whereConditions.add('inaugurationDone = ?');
    whereArgs.add(filters.inauguration!.value);
  }

  // Date filters
  if (filters.fromDate != null && filters.toDate != null) {
    whereConditions.add('addDate BETWEEN ? AND ?');
    whereArgs.add(filters.fromDate);
    whereArgs.add(filters.toDate);
  } else if (filters.fromDate != null) {
    whereConditions.add('addDate >= ?');
    whereArgs.add(filters.fromDate);
  } else if (filters.toDate != null) {
    whereConditions.add('addDate <= ?');
    whereArgs.add(filters.toDate);
  }

  if (filters.condDate != null) {
    whereConditions.add('dateConducted = ?');
    whereArgs.add(filters.condDate);
  }
}

// Build final query
final whereClause =
    whereConditions.isNotEmpty ? whereConditions.join(' AND ') : null;

final List<Map<String, dynamic>> maps = await db.query(
  'applications',
  where: whereClause,
  whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
  orderBy: 'addDate DESC',
);

return maps.map((map) => ApplicationModel.fromMap(map)).toList();
}
@override
Future<List<CityModel>> getCities() async {
final db = await _databaseHelper.database;
final List<Map<String, dynamic>> maps = await db.query('cities');
return maps.map((map) => CityModel.fromMap(map)).toList();
}
@override
Future<Map<String, List<String>>> getMasterLists() async {
final db = await _databaseHelper.database;
final List<Map<String, dynamic>> maps = await db.query('master_lists');
final result = <String, List<String>>{};
for (var map in maps) {
  final listType = map['listType'] as String;
  final values = List<String>.from(jsonDecode(map['values']));
  result[listType] = values;
}

return result;
}
@override
Future<void> clearAllData() async {
await _databaseHelper.clearAllTables();
}
}
// Provider
final masterDataLocalDataSourceProvider =
Provider<MasterDataLocalDataSource>((ref) {
return MasterDataLocalDataSourceImpl(DatabaseHelper.instance);
});