import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/core/database/queries/select_queries.dart';
import 'package:tgpl_network/features/applications_filter/applications_filter_state.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';

class MapDataSource {
  final DatabaseHelper _databaseHelper;

  MapDataSource(this._databaseHelper);

  
  Future<List<ApplicationModel>> getApplicationsForMap({
    required String cityName,
    required String statusId,
  }) async {
    final db = await _databaseHelper.database;

    final List<ApplicationModel> results = [];
    const batchSize = 1000;
    int offset = 0;

    FilterSelectionState filters = FilterSelectionState(
      selectedCity: cityName,
      selectedStatusId: statusId,
    );

    final whereData = ApplicationModel.getWhereClauseAndArgs(filters);

    while (true) {

      final mainQuery = SelectDbQueries.buildApplicationQuery(
        whereConditions: whereData.$1,
        orderBy: ApplicationModel.orderBy,
        selectColumns: ApplicationModel.mapColumns,
        limit: batchSize,
        offset: offset,
      );

      final batch = await db.rawQuery(
        mainQuery,
        whereData.$2.isNotEmpty ? whereData.$2 : null,
      );

      if (batch.isEmpty) break;

      results.addAll(await compute(_parseApplications, batch));
      offset += batchSize;
    }

    return results;
  }

  static List<ApplicationModel> _parseApplications(
    List<Map<String, dynamic>> maps,
  ) {
    return maps.map((map) => ApplicationModel.fromDatabaseMap(map)).toList();
  }
}

final mapDataSourceProvider = Provider<MapDataSource>((ref) {
  return MapDataSource(DatabaseHelper.instance);
});