import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/models/logical_operator_enum.dart';
import 'package:tgpl_network/core/database/database_helper.dart';
import 'package:tgpl_network/core/database/queries/select_queries.dart';
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
    int? userPositionId,
  }) async {
    pageSize ??= ApplicationModel.pageSize;
    final db = await _databaseHelper.database;

    var whereConditions = <String>[];
    var whereArgs = <dynamic>[];

    if (!query.isNullOrEmpty) {
      final filter = FilterSelectionState.fromSearchQuery(query!);
      final whereData = ApplicationModel.getWhereClauseAndArgs(filter);
      whereConditions = whereData.$1;
      whereArgs = whereData.$2;
    }

    Map<int, LogicalOperator> operators = {0: LogicalOperator.and, -1: LogicalOperator.or};

    if (userPositionId != null && userPositionId == 6) {
      whereConditions.add("sstmRecommendation IS NULL");
      operators[1] = LogicalOperator.and;
    }

    final mainQuery = SelectDbQueries.buildApplicationQuery(
      whereConditions: [dbSubModuleCondition, ...whereConditions],
      orderBy: ApplicationModel.orderBy,
      limit: pageSize,
      offset: (page - 1) * pageSize,
      operator: operators,
    );

    // debugPrint("Executing Query: \n$mainQuery with args: $whereArgs");
    final List<Map<String, dynamic>> maps = await db.rawQuery(
      mainQuery,
      whereArgs.isNotEmpty ? whereArgs : null,
    );

    return maps.map((map) => ApplicationModel.fromDatabaseMap(map)).toList();
  }
}

final moduleApplicationsDataSourceProvider =
    Provider<ModuleApplicationsDataSource>((ref) {
      return ModuleApplicationsDataSource(DatabaseHelper.instance);
    });
