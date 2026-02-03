// lib/features/traffic_trade_form/data/datasources/traffic_trade_form_local_data_source.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_model.dart';
import 'package:tgpl_network/core/database/app_database.dart';

abstract class TrafficTradeFormLocalDataSource {
  Future<int> saveTrafficTradeForm(TrafficTradeFormModel form);
  Future<TrafficTradeFormModel?> getSingleTrafficTradeForm(
    String applicationId,
  );
  Future<void> markTrafficTradeFormAsSynced(String id);
  Future<void> updateTrafficTradeFormErrorMessage(
    String id,
    String errorMessage,
  );
  Future<void> deleteTrafficTradeForm(String id);
}

class TrafficTradeFormLocalDataSourceImpl
    implements TrafficTradeFormLocalDataSource {
  final DatabaseHelper _databaseHelper;

  TrafficTradeFormLocalDataSourceImpl(this._databaseHelper);

  // @override
  // Future<int> saveSurveyForm(SurveyFormModel form) async {
  //   final db = await _databaseHelper.database;
  //   final now = DateTime.now().toIso8601String();

  //   final existingForm = await getSingleSurveyForm(form.applicationId ?? '');
  //   final updatedData = {...form.toDatabaseMap(), 'isSynced': 0};
  //   if (existingForm != null) {
  //     updatedData['updatedAt'] = now;
  //   } else {
  //     updatedData['createdAt'] = now;
  //   }
  //   return await db.insert(
  //     AppDatabase.surveyFormsTable,
  //     updatedData,
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  @override
  Future<int> saveTrafficTradeForm(TrafficTradeFormModel form) async {
    final db = await _databaseHelper.database;
    final now = DateTime.now().toIso8601String();

    final formData = {...form.toDatabaseMap(), 'isSynced': 0};
    // Convert nearbyTrafficSites list to JSON string for storage
    formData['nearbyTrafficSites'] = jsonEncode(formData['nearbyTrafficSites']);

    final existingForm = await getSingleTrafficTradeForm(
      form.applicationId ?? '',
    );

    if (existingForm != null) {
      formData['updatedAt'] = now;
    } else {
      formData['createdAt'] = now;
    }

    return await db.insert(
      AppDatabase.trafficTradeFormsTable,
      formData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<TrafficTradeFormModel?> getSingleTrafficTradeForm(
    String applicationId,
  ) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppDatabase.trafficTradeFormsTable,
      where: 'applicationId = ?',
      whereArgs: [applicationId],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return TrafficTradeFormModel.fromDatabaseMap(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<void> markTrafficTradeFormAsSynced(String id) async {
    final db = await _databaseHelper.database;
    await db.update(
      AppDatabase.trafficTradeFormsTable,
      {'isSynced': 1, 'updatedAt': DateTime.now().toIso8601String()},
      where: 'applicationId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> updateTrafficTradeFormErrorMessage(
    String id,
    String errorMessage,
  ) async {
    final db = await _databaseHelper.database;
    await db.update(
      AppDatabase.trafficTradeFormsTable,
      {
        'errorMessage': errorMessage,
        'updatedAt': DateTime.now().toIso8601String(),
      },
      where: 'applicationId = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteTrafficTradeForm(String id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      AppDatabase.trafficTradeFormsTable,
      where: 'applicationId = ?',
      whereArgs: [id],
    );
  }
}

// Provider
final trafficTradeFormLocalDataSourceProvider =
    Provider<TrafficTradeFormLocalDataSource>((ref) {
      return TrafficTradeFormLocalDataSourceImpl(DatabaseHelper.instance);
    });
