import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/core/database/queries/select_queries.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';

class ApplicationDetailDataSource {
  final DatabaseHelper _databaseHelper;
  ApplicationDetailDataSource(this._databaseHelper);

  Future<ApplicationModel> getApplicationDetail(String applicationId) async {
    final db = await _databaseHelper.database;
    final result = await db.rawQuery(SelectDbQueries.selectApplicationDetail, [
      applicationId,
    ]);
    if (result.isNotEmpty) {
      return ApplicationModel.fromDatabaseMap(result.first);
    } else {
      throw Exception('Application not found');
    }
  }
}

final applicationDetailDataSourceProvider =
    Provider<ApplicationDetailDataSource>((ref) {
      return ApplicationDetailDataSource(DatabaseHelper.instance);
    });
