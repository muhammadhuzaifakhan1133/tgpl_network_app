import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tgpl_network/core/database/app_database.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/features/application_form/models/site_status_model.dart';

abstract class AppFormDropdownsLocalDataSource {
  Future<void> saveSiteStatuses(List<SiteStatusModel> siteStatuses);
  Future<List<SiteStatusModel>> getSiteStatuses();
}

class AppFormDropdownsLocalDataSourceImpl
    implements AppFormDropdownsLocalDataSource {
  final DatabaseHelper _databaseHelper;

  AppFormDropdownsLocalDataSourceImpl(this._databaseHelper);


  @override
  Future<void> saveSiteStatuses(List<SiteStatusModel> siteStatuses) async {
    final db = await _databaseHelper.database;

    await db.transaction((txn) async {
      for (final siteStatus in siteStatuses) {
        await txn.insert(
          AppDatabase.siteStatusTable,
          siteStatus.toDatabaseMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  @override
  Future<List<SiteStatusModel>> getSiteStatuses() async {
    final db = await _databaseHelper.database;

    final siteStatusMaps = await db.query(AppDatabase.siteStatusTable);

    return siteStatusMaps
        .map((statusMap) => SiteStatusModel.fromDatabaseMap(statusMap))
        .toList();
  }
}

final appFormDropdownsLocalDataSourceProvider =
    Provider.autoDispose<AppFormDropdownsLocalDataSource>((ref) {
      return AppFormDropdownsLocalDataSourceImpl(DatabaseHelper.instance);
    });
