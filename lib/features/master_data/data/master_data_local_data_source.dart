// lib/features/master_data/data/datasources/master_data_local_data_source.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tgpl_network/core/database/queries/select_queries.dart';
import 'package:tgpl_network/features/master_data/models/user_model.dart';
import 'package:tgpl_network/core/database/app_database.dart';
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
    int page,
    int pageSize,
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
  Future<UserModel?> getUserInfo();
  // Future<void> clearAllData();
}

class MasterDataLocalDataSourceImpl implements MasterDataLocalDataSource {
  final DatabaseHelper _databaseHelper;

  MasterDataLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<void> saveMasterData(MasterDataResponseModel data) async {
    final db = await _databaseHelper.database;

    final result = await db.transaction((txn) async {
      // Clear existing data
      for (final table in _databaseHelper.masterDataTables) {
        await txn.delete(table);
      }

      // Insert in chunks to avoid memory issues
      const chunkSize = 500;

      // Insert applications in chunks
      await _insertInChunks(
        txn,
        AppDatabase.applicationTable,
        data.applicationAndSurveyList.map((e) => e.toDatabaseMap()).toList(),
        chunkSize,
      );

      // Insert cities in chunks
      await _insertInChunks(
        txn,
        AppDatabase.cityTable,
        data.userCityList.map((e) => e.toDatabaseMap()).toList(),
        chunkSize,
      );

      // Insert traffic trades in chunks
      await _insertInChunks(
        txn,
        AppDatabase.trafficTradeTable,
        data.traficTradeSitesList.map((e) => e.toDatabaseMap()).toList(),
        chunkSize,
      );

      final masterListTypes = [
        MasterListType.nearestDepo,
        MasterListType.tradeAreaType,
        MasterListType.dealerInvestmentType,
        MasterListType.gfbList,
        MasterListType.recommendationList,
        MasterListType.shiftHourList,
        MasterListType.hmlList,
        MasterListType.ynList,
        MasterListType.ynnList,
        MasterListType.nfrList,
      ];

      for (var listType in masterListTypes) {
        txn.insert(AppDatabase.masterListsTable, data.listTypeToMap(listType));
      }

      if (data.userInfo != null) {
        // Insert user info
        txn.insert(AppDatabase.userInfoTable, data.userInfo!.toDatabaseMap());
      }

      // Update sync metadata
      txn.delete(AppDatabase.syncMetadataTable);

      txn.insert(AppDatabase.syncMetadataTable, {
        'lastSyncTime': DateTime.now().toIso8601String(),
      });
    });
    debugPrint("Result of saving master data: $result");
  }

  Future<void> _insertInChunks(
    DatabaseExecutor txn,
    String table,
    List<Map<String, dynamic>> items,
    int chunkSize,
  ) async {
    for (var i = 0; i < items.length; i += chunkSize) {
      final end = (i + chunkSize < items.length) ? i + chunkSize : items.length;
      final chunk = items.sublist(i, end);

      final batch = txn.batch();
      for (var item in chunk) {
        batch.insert(table, item);
      }
      await batch.commit(noResult: true);
    }
  }

  @override
  Future<List<ApplicationModel>> getApplications({
    FilterSelectionState? filters,
    int page = 1,
    int? pageSize,
  }) async {
    pageSize ??= ApplicationModel.pageSize;
    final db = await _databaseHelper.database;

    var whereConditions = <String>[];
    var whereArgs = <dynamic>[];

    if (filters != null) {
      final whereData = ApplicationModel.getWhereClauseAndArgs(filters);
      whereConditions = whereData.$1;
      whereArgs = whereData.$2;
    }

    final mainQuery = SelectDbQueries.buildApplicationQuery(
      whereConditions: whereConditions,
      orderBy: ApplicationModel.orderBy,
      limit: pageSize,
      offset: (page - 1) * pageSize,
    );

    final List<Map<String, dynamic>> applicationsResult = await db.rawQuery(
      mainQuery,
      whereArgs.isNotEmpty ? whereArgs : null,
    );

    final applications = applicationsResult
        .map((map) => ApplicationModel.fromDatabaseMap(map))
        .toList();

    return applications;
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
    debugPrint('Master list for ${type.key}: $result');
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
  Future<UserModel?> getUserInfo() async {
    final db = await _databaseHelper.database;

    final userInfoResult = await db.query(AppDatabase.userInfoTable, limit: 1);

    if (userInfoResult.isEmpty) return null;

    final userInfoMap = userInfoResult.first;

    return UserModel.fromDatabaseMap(userInfoMap);
  }
}

// Provider
final masterDataLocalDataSourceProvider = Provider<MasterDataLocalDataSource>((
  ref,
) {
  return MasterDataLocalDataSourceImpl(DatabaseHelper.instance);
});
