import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tgpl_network/constants/app_apis.dart';
import 'package:tgpl_network/core/database/app_database.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/core/database/queries/select_queries.dart';
import 'package:tgpl_network/core/network/dio_client.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/master_data/models/traffic_trades_model.dart';

class ApplicationDetailDataSource {
  final DatabaseHelper _databaseHelper;
  final DioClient _dioClient;
  ApplicationDetailDataSource(this._databaseHelper, this._dioClient);

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

  // Add this method to sync a single application from server
  Future<ApplicationModel> syncApplicationFromServer(String applicationId) async {
    final response = await _dioClient.get(AppApis.getApplicationDetailEndpoint(applicationId));
    final application = ApplicationModel.fromAPIResponseMap(response.data);
    
    final db = await _databaseHelper.database;
    await db.transaction((txn) async {

      // Delete existing application data
      await txn.delete(
        AppDatabase.applicationTable,
        where: 'applicationId = ?',
        whereArgs: [applicationId],
      );

      // Insert updated application data
      await txn.insert(
        AppDatabase.applicationTable,
        application.toDatabaseMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });   
    // Return the updated application
    return await getApplicationDetail(applicationId);
  }
}

final applicationDetailDataSourceProvider =
    Provider<ApplicationDetailDataSource>((ref) {
      final dioClient = ref.read(dioClientProvider);
      return ApplicationDetailDataSource(DatabaseHelper.instance, dioClient);
    });
