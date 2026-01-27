import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/models/logical_operator_enum.dart';
import 'package:tgpl_network/core/database/app_database.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/features/applications_filter/applications_filter_state.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

class ModuleApplicationsDataSource {
  final DatabaseHelper _databaseHelper;
  ModuleApplicationsDataSource(this._databaseHelper);

  Future<List<ApplicationModel>> getApplicationsForSubModule({
    required String dbSubModuleCondition,
    String? query,
    int page = 1,
    int? pageSize,
  }) async {
    pageSize ??= ApplicationModel.pageSize;
    final db = await _databaseHelper.database;

    String? whereClause;
    final whereArgs = <dynamic>[];

    if (!query.isNullOrEmpty) {
      final filter = FilterSelectionState.fromSearchQuery(query!);
      final whereData = ApplicationModel.getWhereClauseAndArgs(
        filter,
        logicalOperator: LogicalOperator.or,
      );
      whereClause = whereData.$1;
      whereArgs.addAll(whereData.$2);
    }

    debugPrint(
      'Fetching applications for submodule with condition: $dbSubModuleCondition, '
      'whereClause: $whereClause, whereArgs: $whereArgs, page: $page, pageSize: $pageSize',
    );
    final List<Map<String, dynamic>> maps = await db.query(
      AppDatabase.applicationTable,
      where:
          "$dbSubModuleCondition${whereClause != null ? ' AND $whereClause' : ''}",
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      orderBy: ApplicationModel.orderBy,
      limit: pageSize,
      offset: (page - 1) * pageSize,
    );

    return maps.map((map) => ApplicationModel.fromDatabaseMap(map)).toList();
  }
}

final moduleApplicationsDataSourceProvider =
    Provider<ModuleApplicationsDataSource>((ref) {
      return ModuleApplicationsDataSource(DatabaseHelper.instance);
    });
