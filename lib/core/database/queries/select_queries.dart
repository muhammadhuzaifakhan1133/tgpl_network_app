import 'package:tgpl_network/core/database/app_database.dart';
import 'package:tgpl_network/core/database/modules_db_conditions.dart';

class SelectDbQueries {
  static const String selectDashboardCounts = '''
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
      FROM ${AppDatabase.applicationTable}
    ''';

  static const String selectLastSyncTime = '''
      SELECT lastSyncTime
      FROM ${AppDatabase.syncMetadataTable}
      ORDER BY id DESC
      LIMIT 1
    ''';
}