import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/core/database/app_database.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/core/database/queries/select_queries.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/master_data/models/traffic_trades_model.dart';

class ApplicationDetailDataSource {
  final DatabaseHelper _databaseHelper;
  ApplicationDetailDataSource(this._databaseHelper);

  Future<ApplicationModel> getApplicationDetail(String applicationId) async {
    final db = await _databaseHelper.database;
    final String mainQuery = SelectDbQueries.buildApplicationQuery(
      whereConditions: ['${ApplicationModel.alias}.applicationId = ?'],
    );
    final result = await db.rawQuery(mainQuery, [applicationId]);

    final trafficSites = await db.query(
      AppDatabase.trafficTradeTable,
      where: 'applicationId = ?',
      whereArgs: [applicationId],
    );

    final nearbyTrafficSites = trafficSites
        .map((siteMap) => TrafficTradesModel.fromDatabaseMap(siteMap))
        .toList();

    return ApplicationModel.fromDatabaseMap(
      result.first,
      nearbyTrafficSites: nearbyTrafficSites,
    );
  }
}

final applicationDetailDataSourceProvider =
    Provider<ApplicationDetailDataSource>((ref) {
      return ApplicationDetailDataSource(DatabaseHelper.instance);
    });
