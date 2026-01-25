// lib/features/traffic_trade_form/data/datasources/traffic_trade_form_local_data_source.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_model.dart';

abstract class TrafficTradeFormLocalDataSource {
  Future<int> saveTrafficTradeForm(TrafficTradeFormModel form);
  Future<List<TrafficTradeFormModel>> getPendingTrafficTradeForms();
  Future<List<TrafficTradeFormModel>> getSyncedTrafficTradeForms();
  Future<void> markAsSynced(int id);
  Future<void> deleteTrafficTradeForm(int id);
}

class TrafficTradeFormLocalDataSourceImpl
    implements TrafficTradeFormLocalDataSource {
  final DatabaseHelper _databaseHelper;

  TrafficTradeFormLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<int> saveTrafficTradeForm(TrafficTradeFormModel form) async {
    final db = await _databaseHelper.database;
    final now = DateTime.now().toIso8601String();

    final formData = form.toJson();
    // Convert nearbyTrafficSites list to JSON string for storage
    formData['nearbyTrafficSites'] =
        jsonEncode(formData['nearbyTrafficSites']);

    return await db.insert('traffic_trade_forms', {
      ...formData,
      'isSynced': 0,
      'createdAt': now,
      'updatedAt': now,
    });
  }

  @override
  Future<List<TrafficTradeFormModel>> getPendingTrafficTradeForms() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'traffic_trade_forms',
      where: 'isSynced = ?',
      whereArgs: [0],
      orderBy: 'createdAt DESC',
    );

    return maps.map((map) {
      // Convert JSON string back to list for nearbyTrafficSites
      if (map['nearbyTrafficSites'] is String) {
        map['nearbyTrafficSites'] = jsonDecode(map['nearbyTrafficSites']);
      }
      return TrafficTradeFormModel.fromJson(map);
    }).toList();
  }

  @override
  Future<List<TrafficTradeFormModel>> getSyncedTrafficTradeForms() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'traffic_trade_forms',
      where: 'isSynced = ?',
      whereArgs: [1],
      orderBy: 'updatedAt DESC',
      limit: 20,
    );

    return maps.map((map) {
      if (map['nearbyTrafficSites'] is String) {
        map['nearbyTrafficSites'] = jsonDecode(map['nearbyTrafficSites']);
      }
      return TrafficTradeFormModel.fromJson(map);
    }).toList();
  }

  @override
  Future<void> markAsSynced(int id) async {
    final db = await _databaseHelper.database;
    await db.update(
      'traffic_trade_forms',
      {
        'isSynced': 1,
        'updatedAt': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteTrafficTradeForm(int id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'traffic_trade_forms',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// Provider
final trafficTradeFormLocalDataSourceProvider =
    Provider<TrafficTradeFormLocalDataSource>((ref) {
  return TrafficTradeFormLocalDataSourceImpl(DatabaseHelper.instance);
});