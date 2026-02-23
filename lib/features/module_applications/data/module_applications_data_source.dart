import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/core/database/queries/select_queries.dart';
import 'package:tgpl_network/features/applications_filter/applications_filter_state.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

class ModuleApplicationsDataSource {
  final DatabaseHelper _databaseHelper;
  ModuleApplicationsDataSource(this._databaseHelper);

  Future<(List<ApplicationModel>, int, int)> getApplicationsForSubModule({
    required String dbSubModuleCondition,
    required int userPositionId,
    String? query,
    int page = 1,
    int? pageSize,
    bool isOverDueFilterApplied = false,
    bool isInProgressFilterApplied = false,
    bool isInSurvey = false,
    bool isInTrafficTrade = false,
    bool isCalculateCounts = true,
    String? dueDateDbColumnName,
  }) async {
    pageSize ??= ApplicationModel.pageSize;
    final db = await _databaseHelper.database;

    var whereConditions = dbSubModuleCondition;
    var whereArgs = <dynamic>[];

    if (userPositionId == 6 && isInSurvey) {
      whereConditions += " AND sstmRecommendation IS NULL"; // if user is TM and standing in survey applications, show only those applications where TM recommendation is pending
    }

    if (userPositionId == 6 && isInTrafficTrade) {
      whereConditions += " AND tttmRecommendation IS NULL"; // if user is TM and standing in traffic trade applications, show only those applications where TM traffic trade action is pending
    }

    if (!query.isNullOrEmpty) {
      final filter = FilterSelectionState.fromSearchQuery(query!);
      final whereData = ApplicationModel.getWhereClauseAndArgs(filter);
      whereConditions += " AND (${whereData.$1})";
      whereArgs = whereData.$2;
    }


    String overDueCondition = "$dueDateDbColumnName < CURRENT_DATE";
    String inProgressCondition = "$dueDateDbColumnName >= CURRENT_DATE";

    String finalWhereConditions = whereConditions;
    if (isCalculateCounts) {
      if (isOverDueFilterApplied && dueDateDbColumnName != null) {
        finalWhereConditions += " AND $overDueCondition";
      }

      if (isInProgressFilterApplied && dueDateDbColumnName != null) {
        finalWhereConditions += " AND $inProgressCondition";
      }
    }

    final mainQuery = SelectDbQueries.buildApplicationQuery(
      whereConditions: finalWhereConditions,
      orderBy: isOverDueFilterApplied
          ? "$dueDateDbColumnName ASC"
          : ApplicationModel.orderBy,
      limit: pageSize,
      offset: (page - 1) * pageSize,
    );
    debugPrint("Executing Main Query: \n$mainQuery with args: $whereArgs");
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      mainQuery,
      whereArgs.isNotEmpty ? whereArgs : null,
    );
    final applications = maps
        .map((map) => ApplicationModel.fromDatabaseMap(map))
        .toList();

    int overDueCount = 0;
    int inProgressCount = 0;
    if (isCalculateCounts) {
      
      final overDueCountQuery = SelectDbQueries.buildApplicationQuery(
        whereConditions: "$whereConditions AND $overDueCondition",
        selectColumns: ["COUNT(*)"],
      );
      debugPrint("Executing Overdue Count Query: \n$overDueCountQuery with args: $whereArgs");
      final countResult = await db.rawQuery(
        overDueCountQuery,
        whereArgs.isNotEmpty ? whereArgs : null,
      );
      overDueCount = Sqflite.firstIntValue(countResult) ?? 0;
      final inProgressCountQuery = SelectDbQueries.buildApplicationQuery(
        whereConditions: "$whereConditions AND $inProgressCondition",
        selectColumns: ["COUNT(*)"],
      );
      debugPrint("Executing In Progress Count Query: \n$inProgressCountQuery with args: $whereArgs");
      final inProgressCountResult = await db.rawQuery(
        inProgressCountQuery,
        whereArgs.isNotEmpty ? whereArgs : null,
      );
      inProgressCount = Sqflite.firstIntValue(inProgressCountResult) ?? 0;
    }
    return (applications, overDueCount, inProgressCount);
  }

  Future<void> temp() async {
    final db = await _databaseHelper.database;
    final result = await db.rawQuery(SelectDbQueries.temp);
    debugPrint("Temp Query Result: $result");
  }
}

final moduleApplicationsDataSourceProvider =
    Provider<ModuleApplicationsDataSource>((ref) {
      return ModuleApplicationsDataSource(DatabaseHelper.instance);
    });
