import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/core/database/queries/select_queries.dart';

abstract class SyncStatusDataSource {
  Future<String> getLastSyncTime();
}

class SyncStatusDataSourceImpl implements SyncStatusDataSource {
  final DatabaseHelper _databaseHelper;

  SyncStatusDataSourceImpl(this._databaseHelper);

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
}

final syncStatusDataSourceProvider = Provider<SyncStatusDataSource>((ref) {
  return SyncStatusDataSourceImpl(DatabaseHelper.instance);
});