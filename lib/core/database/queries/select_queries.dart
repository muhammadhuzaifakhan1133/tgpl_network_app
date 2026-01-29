import 'package:tgpl_network/common/models/logical_operator_enum.dart';
import 'package:tgpl_network/core/database/app_database.dart';
import 'package:tgpl_network/common/models/join_clause_model.dart';
import 'package:tgpl_network/core/database/modules_db_conditions.dart';
import 'package:tgpl_network/features/application_form/models/site_status_model.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';

class SelectDbQueries {
  static String selectDashboardCounts =
      '''
      SELECT COUNT(CASE WHEN ${ModulesDbConditions.inprocess} THEN 1 END) AS inProcessCount,
             COUNT(CASE WHEN ${ModulesDbConditions.siteScreeningOpenApplications} THEN 1 END) AS openApplicationsCount,
             COUNT(CASE WHEN ${ModulesDbConditions.siteScreeningSurveyAndDealerProfile} THEN 1 END) AS surveyAndDealerProfileCount,
             COUNT(CASE WHEN ${ModulesDbConditions.siteScreeningTrafficAndTrade} THEN 1 END) AS trafficAndTradeCount,
             COUNT(CASE WHEN ${ModulesDbConditions.feasibilityFeasibility} THEN 1 END) AS feasibilityCount,
             COUNT(CASE WHEN ${ModulesDbConditions.feasibilityNegotiations} THEN 1 END) AS negotiationsCount,
             COUNT(CASE WHEN ${ModulesDbConditions.feasibilityFeasibilityFinalizations} THEN 1 END) AS feasibilityFinalizationCount,
             COUNT(CASE WHEN ${ModulesDbConditions.approvalsMouSignOff} THEN 1 END) AS mouSignOffCount,
             COUNT(CASE WHEN ${ModulesDbConditions.approvalsJoiningFee} THEN 1 END) AS joiningFeeCount,
             COUNT(CASE WHEN ${ModulesDbConditions.approvalsFranchiseAgreement} THEN 1 END) AS franchiseAgreementCount,
             COUNT(CASE WHEN ${ModulesDbConditions.layoutsGovernmentLayout} THEN 1 END) AS governmentLayoutCount,
             COUNT(CASE WHEN ${ModulesDbConditions.layoutsIssuanceOfDrawings} THEN 1 END) AS issuanceOfDrawingsCount,
             COUNT(CASE WHEN ${ModulesDbConditions.layoutsTopography} THEN 1 END) AS topographyCount,
             COUNT(CASE WHEN ${ModulesDbConditions.layoutsDrawing} THEN 1 END) AS drawingCount,
             COUNT(CASE WHEN ${ModulesDbConditions.layoutsCapex} THEN 1 END) AS capexCount,
             COUNT(CASE WHEN ${ModulesDbConditions.documentsAppliedInExplosive} THEN 1 END) AS appliedInExplosiveCount,
             COUNT(CASE WHEN ${ModulesDbConditions.documentsDcNoc} THEN 1 END) AS dcNocCount,
             COUNT(CASE WHEN ${ModulesDbConditions.documentsLeaseAgreement} THEN 1 END) AS leaseAgreementCount,
             COUNT(CASE WHEN ${ModulesDbConditions.construction} THEN 1 END) AS constructionCount,
             COUNT(CASE WHEN ${ModulesDbConditions.commissioningHoto} THEN 1 END) AS hotoCount,
             COUNT(CASE WHEN ${ModulesDbConditions.commissioningInaugrations} THEN 1 END) AS inaugurationCount,
             COUNT(CASE WHEN ${ModulesDbConditions.inaugurated} THEN 1 END) AS inauguratedCount,
             COUNT(CASE WHEN ${ModulesDbConditions.holdByDealer} THEN 1 END) AS holdByDealerCount,
             COUNT(CASE WHEN ${ModulesDbConditions.holdByTgpl} THEN 1 END) AS holdByTgplCount,
             COUNT(CASE WHEN ${ModulesDbConditions.rejectedByDealer} THEN 1 END) AS rejectedByDealerCount,
             COUNT(CASE WHEN ${ModulesDbConditions.rejectedByTgpl} THEN 1 END) AS rejectedByTgplCount
      FROM ${AppDatabase.applicationTable} ${ApplicationModel.alias}
    ''';

  static const String selectLastSyncTime =
      '''
      SELECT lastSyncTime
      FROM ${AppDatabase.syncMetadataTable}
      ORDER BY id DESC
      LIMIT 1
    ''';

  static String buildApplicationQuery({
    List<String>? whereConditions,
    LogicalOperator operator = LogicalOperator.and,
    String? orderBy,
    int? limit,
    int? offset,
    List<String>? selectColumns,
  }) {
    return _buildApplicationsRawQuery(
      tableName: AppDatabase.applicationTable,
      tableAlias: ApplicationModel.alias,
      selectColumns: [
        if (selectColumns != null)
          ...selectColumns
        else
          '${ApplicationModel.alias}.*',
        '${SiteStatusModel.alias}.name as siteStatusName',
      ],
      joins: [
        JoinClause(
          type: JoinType.leftJoin,
          tableName: AppDatabase.siteStatusTable,
          tableAlias: SiteStatusModel.alias,
          onCondition:
              '${ApplicationModel.alias}.siteStatusId = ${SiteStatusModel.alias}.siteStatusId',
        ),
      ],
      whereClause: whereConditions != null && whereConditions.isNotEmpty
          ? whereConditions.join(operator.value)
          : null,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  static String _buildApplicationsRawQuery({
    required String tableName,
    String tableAlias = 'main',
    List<String>? selectColumns,
    List<JoinClause>? joins,
    String? whereClause,
    String? orderBy,
    int? limit,
    int? offset,
  }) {
    final buffer = StringBuffer();

    // SELECT clause
    buffer.write('SELECT ');
    if (selectColumns != null && selectColumns.isNotEmpty) {
      buffer.write(selectColumns.join(', '));
    } else {
      buffer.write('$tableAlias.*');
    }

    // FROM clause
    buffer.write('\nFROM $tableName $tableAlias');

    // JOIN clauses
    if (joins != null && joins.isNotEmpty) {
      for (final join in joins) {
        buffer.write('\n${join.type} ${join.tableName} ${join.tableAlias}');
        buffer.write('\n  ON ${join.onCondition}');
      }
    }

    // WHERE clause
    if (whereClause != null && whereClause.isNotEmpty) {
      buffer.write('\nWHERE $whereClause');
    }

    // ORDER BY clause
    if (orderBy != null && orderBy.isNotEmpty) {
      buffer.write('\nORDER BY $orderBy');
    }

    // LIMIT clause
    if (limit != null) {
      buffer.write('\nLIMIT $limit');
    }

    // OFFSET clause
    if (offset != null) {
      buffer.write('\nOFFSET $offset');
    }

    return buffer.toString();
  }
}
