// lib/features/master_data/data/datasources/master_data_local_data_source.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/constants/app_database.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/features/applications_filter/applications_filter_state.dart';
import 'package:tgpl_network/features/master_data/models/master_data_response_model.dart';
import 'package:tgpl_network/features/master_data/models/master_list_type.dart';
import '../models/application_model.dart';
import '../models/city_model.dart';
import 'dart:convert';

abstract class MasterDataLocalDataSource {
  Future<void> saveMasterData(MasterDataResponseModel data);
  Future<List<ApplicationModel>> getApplications({
    FilterSelectionState? filters,
  });
  Future<List<String>> getNearestDepos();
  Future<List<String>> getTradeAreaTypes();
  Future<List<String>> getDealerInvestmentTypes();
  Future<List<String>> getGFBList();
  Future<List<String>> getRecommendationList();
  Future<List<String>> getShiftHourList();
  Future<List<String>> getHMLList();
  Future<List<String>> getYNList();
  Future<List<String>> getYNNList();
  Future<List<String>> getNFRList();
  Future<List<CityModel>> getCities();
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
      await txn.delete(AppDatabase.applicationTable);
      await txn.delete(AppDatabase.cityTable);
      await txn.delete(AppDatabase.trafficTradeTable);
      await txn.delete(AppDatabase.masterListsTable);

      // Insert applications
      for (var app in data.applicationAndSurveyList) {
        await txn.insert(AppDatabase.applicationTable, app.toDatabaseMap());
      }

      // Insert cities
      for (var city in data.userCityList) {
        await txn.insert(AppDatabase.cityTable, city.toDatabaseMap());
      }

      // Insert traffic trades
      for (var trade in data.traficTradeSitesList) {
        await txn.insert(AppDatabase.trafficTradeTable, trade.toDatabaseMap());
      }

      // Insert master lists
      await txn.insert(
        AppDatabase.masterListsTable,
        data.listTypeToMap(MasterListType.nearestDepo),
      );
      await txn.insert(
        AppDatabase.masterListsTable,
        data.listTypeToMap(MasterListType.tradeAreaType),
      );
      await txn.insert(
        AppDatabase.masterListsTable,
        data.listTypeToMap(MasterListType.dealerInvestmentType),
      );
      await txn.insert(
        AppDatabase.masterListsTable,
        data.listTypeToMap(MasterListType.gfbList),
      );
      await txn.insert(
        AppDatabase.masterListsTable,
        data.listTypeToMap(MasterListType.recommendationList),
      );
      await txn.insert(
        AppDatabase.masterListsTable,
        data.listTypeToMap(MasterListType.shiftHourList),
      );
      await txn.insert(
        AppDatabase.masterListsTable,
        data.listTypeToMap(MasterListType.hmlList),
      );
      await txn.insert(
        AppDatabase.masterListsTable,
        data.listTypeToMap(MasterListType.ynList),
      );
      await txn.insert(
        AppDatabase.masterListsTable,
        data.listTypeToMap(MasterListType.ynnList),
      );
      await txn.insert(
        AppDatabase.masterListsTable,
        data.listTypeToMap(MasterListType.nfrList),
      );
    });
  }

  @override
  Future<List<ApplicationModel>> getApplications({
    FilterSelectionState? filters,
  }) async {
    final db = await _databaseHelper.database;

    String? whereClause;
    final whereArgs = <dynamic>[];

    if (filters != null) {
      final whereData = ApplicationModel.getWhereClauseAndArgs(filters);
      whereClause = whereData.$1;
      whereArgs.addAll(whereData.$2);
    }

    final List<Map<String, dynamic>> maps = await db.query(
      AppDatabase.applicationTable,
      where: whereClause,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      orderBy: ApplicationModel.orderBy,
    );

    return maps.map((map) => ApplicationModel.fromDatabaseMap(map)).toList();
  }

  @override
  Future<List<CityModel>> getCities() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppDatabase.cityTable,
    );
    return maps.map((map) => CityModel.fromDatabaseMap(map)).toList();
  }

  Future<List<String>> _getMasterListByType(MasterListType type) async {
    final db = await _databaseHelper.database;
    final result = await db.query(
      AppDatabase.masterListsTable,
      where: '${MasterListTypeTable.databaseColName} = ?',
      whereArgs: [type.key],
    );

    if (result.isEmpty) return [];
    return List<String>.from(jsonDecode(result.first['listValues'] as String));
  }

  @override
  Future<List<String>> getNearestDepos() =>
      _getMasterListByType(MasterListType.nearestDepo);

  @override
  Future<List<String>> getTradeAreaTypes() =>
      _getMasterListByType(MasterListType.tradeAreaType);

  @override
  Future<List<String>> getDealerInvestmentTypes() =>
      _getMasterListByType(MasterListType.dealerInvestmentType);

  @override
  Future<List<String>> getGFBList() =>
      _getMasterListByType(MasterListType.gfbList);

  @override
  Future<List<String>> getRecommendationList() =>
      _getMasterListByType(MasterListType.recommendationList);

  @override
  Future<List<String>> getShiftHourList() =>
      _getMasterListByType(MasterListType.shiftHourList);

  @override
  Future<List<String>> getHMLList() =>
      _getMasterListByType(MasterListType.hmlList);

  @override
  Future<List<String>> getYNList() =>
      _getMasterListByType(MasterListType.ynList);

  @override
  Future<List<String>> getYNNList() =>
      _getMasterListByType(MasterListType.ynnList);

  @override
  Future<List<String>> getNFRList() =>
      _getMasterListByType(MasterListType.nfrList);

  @override
  Future<void> clearAllData() async {
    await _databaseHelper.clearMasterDataTables();
  }
}

// Provider
final masterDataLocalDataSourceProvider = Provider<MasterDataLocalDataSource>((
  ref,
) {
  return MasterDataLocalDataSourceImpl(DatabaseHelper.instance);
});
