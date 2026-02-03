import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/core/database/app_database.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/features/data_sync/models/sync_item.dart';
import 'package:tgpl_network/features/data_sync/presentation/widgets/sync_list_section.dart';
import 'package:tgpl_network/features/survey_form/models/survey_form_model.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_model.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';
import 'package:tgpl_network/utils/get_time_duration_till_now.dart';

abstract class DataSyncDataSource {
  Future<List<SyncItem>> getPendingSyncItems();
  Future<List<SyncItem>> getSyncedSyncItems();
  Future<void> retainLastMonthSyncedData();
}

class DataSyncDataSourceImpl implements DataSyncDataSource {
  final DatabaseHelper _databaseHelper;

  DataSyncDataSourceImpl(this._databaseHelper);

  @override
  Future<List<SyncItem>> getPendingSyncItems() async {
    final pendingSurveyForms = await _getPendingSurveyForms();
    final pendingTrafficTradeForms = await _getPendingTrafficTradeForms();
    final List<SyncItem> syncItems = [];
    for (var form in pendingSurveyForms) {
      syncItems.add(
        SyncItem(
          id: form.applicationId ?? '',
          title: 'Survey Form - ${form.applicationId}',
          subtitle: form.errorMessage.isNullOrEmpty
              ? (form.updatedAt.isEmpty
                    ? 'Created on ${getFormattedTimeDuration(form.createdAt)}'
                    : 'Edited on ${getFormattedTimeDuration(form.updatedAt)}')
              : form.errorMessage,
          status: form.errorMessage.isNullOrEmpty
              ? SyncItemStatus.pending
              : SyncItemStatus.failed,
          surveyForm: form,
          date:
              DateTime.tryParse(form.updatedAt) ??
              DateTime.tryParse(form.createdAt),
        ),
      );
    }
    for (var form in pendingTrafficTradeForms) {
      syncItems.add(
        SyncItem(
          id: form.applicationId ?? '',
          title: 'Traffic Trade Form - ${form.applicationId}',
          subtitle: form.errorMessage.isNullOrEmpty
              ? (form.updatedAt.isEmpty
                    ? 'Created on ${getFormattedTimeDuration(form.createdAt)}'
                    : 'Edited on ${getFormattedTimeDuration(form.updatedAt)}')
              : form.errorMessage,
          status: form.errorMessage.isNullOrEmpty
              ? SyncItemStatus.pending
              : SyncItemStatus.failed,
          trafficTradeForm: form,
          date:
              DateTime.tryParse(form.updatedAt) ??
              DateTime.tryParse(form.createdAt),
        ),
      );
    }
    // Sort by createdAt descending
    syncItems.sort((a, b) => b.date!.compareTo(a.date!));
    return syncItems;
  }

  @override
  Future<List<SyncItem>> getSyncedSyncItems() async {
    final syncedSurveyForms = await _getSyncedSurveyForms();
    final syncedTrafficTradeForms = await _getSyncedTrafficTradeForms();
    final List<SyncItem> syncItems = [];
    for (var form in syncedSurveyForms) {
      syncItems.add(
        SyncItem(
          id: form.applicationId ?? '',
          title: 'Survey Form - ${form.applicationId}',
          subtitle: 'Synced on ${getFormattedTimeDuration(form.updatedAt)}',
          status: SyncItemStatus.success,
          surveyForm: form,
          date: DateTime.tryParse(form.updatedAt),
        ),
      );
    }
    for (var form in syncedTrafficTradeForms) {
      syncItems.add(
        SyncItem(
          id: form.applicationId ?? '',
          title: 'Traffic Trade Form - ${form.applicationId}',
          subtitle: 'Synced on ${getFormattedTimeDuration(form.updatedAt)}',
          status: SyncItemStatus.success,
          trafficTradeForm: form,
          date: DateTime.tryParse(form.updatedAt),
        ),
      );
    }
    // Sort by createdAt descending
    syncItems.sort((a, b) => b.date!.compareTo(a.date!));
    return syncItems;
  }

  Future<List<SurveyFormModel>> _getPendingSurveyForms() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppDatabase.surveyFormsTable,
      where: 'isSynced = ?',
      whereArgs: [0],
    );

    return maps.map((map) => SurveyFormModel.fromDatabaseMap(map)).toList();
  }

  Future<List<SurveyFormModel>> _getSyncedSurveyForms() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppDatabase.surveyFormsTable,
      where: 'isSynced = ?',
      whereArgs: [1],
    );

    return maps.map((map) => SurveyFormModel.fromDatabaseMap(map)).toList();
  }

  Future<List<TrafficTradeFormModel>> _getPendingTrafficTradeForms() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppDatabase.trafficTradeFormsTable,
      where: 'isSynced = ?',
      whereArgs: [0],
    );

    return maps
        .map((map) => TrafficTradeFormModel.fromDatabaseMap(map))
        .toList();
  }

  Future<List<TrafficTradeFormModel>> _getSyncedTrafficTradeForms() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppDatabase.trafficTradeFormsTable,
      where: 'isSynced = ?',
      whereArgs: [1],
    );

    return maps
        .map((map) => TrafficTradeFormModel.fromDatabaseMap(map))
        .toList();
  }

  @override
  Future<void> retainLastMonthSyncedData() async {
    final db = await _databaseHelper.database;
    final oneMonthAgo = DateTime.now()
        .subtract(const Duration(days: 30))
        .toIso8601String();

    // Delete synced survey forms older than one month
    await db.delete(
      AppDatabase.surveyFormsTable,
      where: 'isSynced = ? AND updatedAt < ?',
      whereArgs: [1, oneMonthAgo],
    );

    // Delete synced traffic trade forms older than one month
    await db.delete(
      AppDatabase.trafficTradeFormsTable,
      where: 'isSynced = ? AND updatedAt < ?',
      whereArgs: [1, oneMonthAgo],
    );
  }
}

final dataSyncDataSourceProvider = Provider((ref) {
  return DataSyncDataSourceImpl(DatabaseHelper.instance);
});
