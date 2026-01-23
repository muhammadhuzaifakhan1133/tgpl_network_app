import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/models/user_model.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/core/database/queries/select_queries.dart';
import 'package:tgpl_network/features/dashboard/models/dashboard_response_model.dart';

abstract class DashboardDataSource {
  Future<DashboardResponseModel> fetchDashboardData();
}

class DashboardDataSourceImpl implements DashboardDataSource {
  final DatabaseHelper _databaseHelper;

  DashboardDataSourceImpl(this._databaseHelper);

  @override
  Future<DashboardResponseModel> fetchDashboardData() async {
    final db = await _databaseHelper.database;
    final result = await db.rawQuery(SelectDbQueries.selectDashboardCounts);
    final lastSyncTimeResult = await db.rawQuery(
      SelectDbQueries.selectLastSyncTime,
    );
    if (result.isNotEmpty) {
      print(result);
      final moduleAppsCount = DashboardApplicationsCounts.fromJson(
        result.first,
      );
      return DashboardResponseModel(
        user: UserModel(),
        counts: moduleAppsCount,
        lastSyncTime: lastSyncTimeResult.isNotEmpty
            ? lastSyncTimeResult.first['lastSyncTime'] as String
            : '',
      );
    } else {
      throw Exception('No dashboard data found');
    }
  }
}

final dashboardDataSourceProvider = Provider<DashboardDataSource>((ref) {
  return DashboardDataSourceImpl(DatabaseHelper.instance);
});
