import 'package:tgpl_network/common/models/logical_operator_enum.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';

class ModulesDbConditions {
  static final String _alias = ApplicationModel.alias;
  
  static String siteScreening = "($siteScreeningOpenApplications) OR ($siteScreeningSurveyAndDealerProfile) OR ($siteScreeningTrafficAndTrade)";
  static String siteScreeningOpenApplications = "$_alias.surveynDealerProfileDone = 0";
  static String siteScreeningSurveyAndDealerProfile = "$_alias.surveynDealerProfileDone = 0";
  static String siteScreeningTrafficAndTrade = "$_alias.surveynDealerProfileDone = 1 AND $_alias.trafficTradeDone = 0 AND $_alias.statusId < 13";

  static String feasibility = "($feasibilityFeasibility) OR ($feasibilityNegotiations) OR ($feasibilityFeasibilityFinalizations)";
  static String feasibilityFeasibility = "$_alias.surveynDealerProfileDone = 1 AND $_alias.trafficTradeDone = 1 AND $_alias.feasibilityDone = 0 AND $_alias.statusId < 13";
  static String feasibilityNegotiations = "$_alias.surveynDealerProfileDone = 1 AND $_alias.trafficTradeDone = 1 AND $_alias.feasibilityDone = 1 AND $_alias.negotiationDone = 0 AND $_alias.statusId < 13";
  static String feasibilityFeasibilityFinalizations = "$_alias.surveynDealerProfileDone = 1 AND $_alias.trafficTradeDone = 1 AND $_alias.feasibilityDone = 1 AND $_alias.negotiationDone = 1 AND $_alias.feasibilityFinalizationDone = 0 AND $_alias.statusId < 13";

  static final String _approved = "$_alias.surveynDealerProfileDone = 1 AND $_alias.trafficTradeDone = 1 AND $_alias.feasibilityDone = 1 AND $_alias.negotiationDone = 1 AND $_alias.feasibilityFinalizationDone = 1 AND $_alias.statusId < 13";
 

  static String approvals = "($approvalsMouSignOff) OR ($approvalsJoiningFee) OR ($approvalsFranchiseAgreement)";
  static String approvalsMouSignOff = "$_approved AND $_alias.mouSignOffDone = 0";
  static String approvalsJoiningFee = "$_approved AND $_alias.joiningFeeDone = 0";
  static String approvalsFranchiseAgreement = "$_approved AND $_alias.franchiseAgreementDone = 0";

  static String layouts = "($layoutsGovernmentLayout) OR ($layoutsIssuanceOfDrawings) OR ($layoutsTopography) OR ($layoutsDrawing) OR ($layoutsCapex)";
  static String layoutsGovernmentLayout = "$_approved AND $_alias.explosiveLayoutDone = 0";
  static String layoutsIssuanceOfDrawings = "$_approved AND $_alias.issuanceOfDrawingsDone = 0";
  static String layoutsTopography = "$_approved AND $_alias.topographyDone = 0";
  static String layoutsDrawing = "$_approved AND $_alias.drawingsDone = 0";
  static String layoutsCapex = "$_approved AND $_alias.capexDone = 0";

  static String documents = "($documentsAppliedInExplosive) OR ($documentsDcNoc) OR ($documentsLeaseAgreement)";
  static String documentsAppliedInExplosive = "$_approved AND $_alias.appliedInExplosiveDone = 0";
  static String documentsDcNoc = "$_approved AND $_alias.dcNocDone = 0";
  static String documentsLeaseAgreement = "$_approved AND $_alias.leaseAgreementDone = 0";

  static String construction = "$_approved AND $_alias.constructionDone = 0";

  static String commissioning = "($commissioningHoto) OR ($commissioningInaugrations)";
  static String commissioningHoto = "$_approved AND $_alias.hotoDone = 0";
  static String commissioningInaugrations = "$_approved AND $_alias.inaugurationDone = 0";

  static String history = "($inaugurated) OR ($holdByDealer) OR ($holdByTgpl) OR ($rejectedByDealer) OR ($rejectedByTgpl)";
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