import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/core/database/app_database.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/core/database/queries/select_queries.dart';
import 'package:tgpl_network/features/dashboard/models/application_suggestions.dart';
import 'package:tgpl_network/features/dashboard/models/dashboard_response_model.dart';

abstract class DashboardDataSource {
  Future<DashboardResponseModel> fetchDashboardData();
  Future<String> getLastSyncTime();
  Future<List<ApplicationSuggestion>> fetchSearchSuggestions(String query, String field);
}

class DashboardDataSourceImpl implements DashboardDataSource {
  final DatabaseHelper _databaseHelper;

  DashboardDataSourceImpl(this._databaseHelper);

  @override
  Future<DashboardResponseModel> fetchDashboardData() async {
    final db = await _databaseHelper.database;
    final result = await db.rawQuery(SelectDbQueries.selectDashboardCounts);
    if (result.isNotEmpty) {
      final moduleAppsCount = DashboardApplicationsCounts.fromJson(
        result.first,
      );
      return DashboardResponseModel(counts: moduleAppsCount);
    } else {
      throw Exception('No dashboard data found');
    }
  }

  @override
  Future<String> getLastSyncTime() async {
    final db = await _databaseHelper.database;
    final result = await db.rawQuery(SelectDbQueries.selectLastSyncTime);
    if (result.isNotEmpty) {
      return result.first['lastSyncTime'] as String;
    } else {
      return "Never";
    }
  }

  @override
  Future<List<ApplicationSuggestion>> fetchSearchSuggestions(
    String query,
    String field,
  ) async {
    final db = await _databaseHelper.database;
    final result = await db.rawQuery(
      'SELECT applicationId, applicantName, proposedSiteName1 FROM ${AppDatabase.applicationTable} WHERE $field LIKE ? LIMIT 10',
      ['%$query%'],
    );
    return result.map((row) => ApplicationSuggestion.fromJson(row)).toList();
  }
}

final dashboardDataSourceProvider = Provider<DashboardDataSource>((ref) {
  return DashboardDataSourceImpl(DatabaseHelper.instance);
});
