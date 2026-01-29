import 'package:tgpl_network/common/models/logical_operator_enum.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';

class ModulesDbConditions {
  static final String _alias = ApplicationModel.alias;
  
  static String siteScreening = "$siteScreeningOpenApplications AND $siteScreeningSurveyAndDealerProfile AND $siteScreeningTrafficAndTrade";
  static String siteScreeningOpenApplications = "$_alias.statusId < 2";
  static String siteScreeningSurveyAndDealerProfile = "$_alias.statusId < 2";
  static String siteScreeningTrafficAndTrade = "$_alias.trafficTradeDone = 0 AND $_alias.statusId < 13";

  static String feasibility = "$feasibilityFeasibility AND $feasibilityNegotiations AND $feasibilityFeasibilityFinalizations";
  static String feasibilityFeasibility = "$_alias.feasibilityDone = 0 AND $_alias.statusId < 13";
  static String feasibilityNegotiations = "$_alias.negotiationDone = 0 AND $_alias.statusId < 13";
  static String feasibilityFeasibilityFinalizations = "$_alias.feasibilityFinalizationDone = 0 AND $_alias.statusId < 13";

  static String approvals = "$approvalsMouSignOff AND $approvalsJoiningFee AND $approvalsFranchiseAgreement";
  static String approvalsMouSignOff = "$_alias.feasibilityFinalizationDone > 0 AND $_alias.mouSignOffDone = 0 AND $_alias.statusId < 13";
  static String approvalsJoiningFee = "$_alias.feasibilityFinalizationDone > 0 AND $_alias.joiningFeeDone = 0 AND $_alias.statusId < 13";
  static String approvalsFranchiseAgreement = "$_alias.feasibilityFinalizationDone > 0 AND $_alias.franchiseAgreementDone = 0 AND $_alias.statusId < 13";

  static String layouts = "$layoutsGovernmentLayout AND $layoutsIssuanceOfDrawings AND $layoutsTopography AND $layoutsDrawing AND $layoutsCapex";
  static String layoutsGovernmentLayout = "$_alias.feasibilityFinalizationDone > 0 AND $_alias.explosiveLayoutDone = 0 AND $_alias.statusId < 13";
  static String layoutsIssuanceOfDrawings = "$_alias.feasibilityFinalizationDone > 0 AND $_alias.issuanceOfDrawingsDone = 0 AND $_alias.statusId < 13";
  static String layoutsTopography = "$_alias.feasibilityFinalizationDone > 0 AND $_alias.topographyDone = 0 AND $_alias.statusId < 13";
  static String layoutsDrawing = "$_alias.feasibilityFinalizationDone > 0 AND $_alias.drawingsDone = 0 AND $_alias.statusId < 13";
  static String layoutsCapex = "$_alias.feasibilityFinalizationDone > 0 AND $_alias.capexDone = 0 AND $_alias.statusId < 13";

  static String documents = "$documentsAppliedInExplosive AND $documentsDcNoc AND $documentsLeaseAgreement";
  static String documentsAppliedInExplosive = "$_alias.feasibilityFinalizationDone > 0 AND $_alias.appliedInExplosiveDone = 0 AND $_alias.statusId < 13";
  static String documentsDcNoc = "$_alias.feasibilityFinalizationDone > 0 AND $_alias.dcNocDone = 0 AND $_alias.statusId < 13";
  static String documentsLeaseAgreement = "$_alias.feasibilityFinalizationDone > 0 AND $_alias.leaseAgreementDone = 0 AND $_alias.statusId < 13";

  static String construction = "$_alias.feasibilityFinalizationDone > 0 AND $_alias.constructionDone = 0 AND $_alias.statusId < 13";

  static String commissioning = "$commissioningHoto AND $commissioningInaugrations";
  static String commissioningHoto = "$_alias.feasibilityFinalizationDone > 0 AND $_alias.hotoDone = 0 AND $_alias.statusId < 13";
  static String commissioningInaugrations = "$_alias.feasibilityFinalizationDone >  0 AND $_alias.inaugurationDone = 0 AND $_alias.statusId < 13";

  static String inaugurated = "$_alias.statusId = 13";
  static String holdByDealer = "$_alias.statusId = 15";  
  static String holdByTgpl = "$_alias.statusId = 16";
  static String rejectedByDealer = "$_alias.statusId = 17";
  static String rejectedByTgpl = "$_alias.statusId = 14";

  static String inprocess = "$_alias.statusId < 13";
  static String hold = "$_alias.statusId IN (15, 16)";
  static String rejected = "$_alias.statusId IN (14, 17)";

  static String combineWhereClauses({
    String? existingClause,
    List<String>? existingArgs,
    LogicalOperator logicalOperator = LogicalOperator.and,
  }) {
    String combinedClause = existingClause ?? '';

    if (existingArgs != null && existingArgs.isNotEmpty) {
      if (combinedClause.isNotEmpty) {
        combinedClause += logicalOperator == LogicalOperator.and ? ' AND ' : ' OR ';
      }
      combinedClause += existingArgs.join(
          logicalOperator == LogicalOperator.and ? ' AND ' : ' OR ');
    }

    return combinedClause;
  }
}