class ModulesDbConditions {
  static const String siteScreening = "$siteScreeningOpenApplications AND $siteScreeningSurveyAndDealerProfile AND $siteScreeningTrafficAndTrade";
  static const String siteScreeningOpenApplications = "statusId < 2";
  static const String siteScreeningSurveyAndDealerProfile = "statusId < 2";
  static const String siteScreeningTrafficAndTrade = "trafficTradeDone = 0 AND statusId < 13";

  static const String feasibility = "$feasibilityFeasibility AND $feasibilityNegotiations AND $feasibilityFeasibilityFinalizations";
  static const String feasibilityFeasibility = "feasibilityDone = 0 AND statusId < 13";
  static const String feasibilityNegotiations = "negotiationDone = 0 AND statusId < 13";
  static const String feasibilityFeasibilityFinalizations = "feasibilityFinalizationDone = 0 AND statusId < 13";

  static const String approvals = "$approvalsMouSignOff AND $approvalsJoiningFee AND $approvalsFranchiseAgreement";
  static const String approvalsMouSignOff = "feasibilityFinalizationDone > 0 AND mouSignOffDone = 0 AND statusId < 13";
  static const String approvalsJoiningFee = "feasibilityFinalizationDone > 0 AND joiningFeeDone = 0 AND statusId < 13";
  static const String approvalsFranchiseAgreement = "feasibilityFinalizationDone > 0 AND franchiseAgreementDone = 0 AND statusId < 13";

  static const String layouts = "$layoutsGovernmentLayout AND $layoutsIssuanceOfDrawings AND $layoutsTopography AND $layoutsDrawing AND $layoutsCapex";
  static const String layoutsGovernmentLayout = "feasibilityFinalizationDone > 0 AND explosiveLayoutDone = 0 AND statusId < 13";
  static const String layoutsIssuanceOfDrawings = "feasibilityFinalizationDone > 0 AND issuanceOfDrawingsDone = 0 AND statusId < 13";
  static const String layoutsTopography = "feasibilityFinalizationDone > 0 AND topographyDone = 0 AND statusId < 13";
  static const String layoutsDrawing = "feasibilityFinalizationDone > 0 AND drawingsDone = 0 AND statusId < 13";
  static const String layoutsCapex = "feasibilityFinalizationDone > 0 AND capexDone = 0 AND statusId < 13";

  static const String documents = "$documentsAppliedInExplosive AND $documentsDcNoc AND $documentsLeaseAgreement";
  static const String documentsAppliedInExplosive = "feasibilityFinalizationDone > 0 AND appliedInExplosiveDone = 0 AND statusId < 13";
  static const String documentsDcNoc = "feasibilityFinalizationDone > 0 AND dcNocDone = 0 AND statusId < 13";
  static const String documentsLeaseAgreement = "feasibilityFinalizationDone > 0 AND leaseAgreementDone = 0 AND statusId < 13";

  static const String construction = "feasibilityFinalizationDone > 0 AND constructionDone = 0 AND statusId < 13";

  static const String commissioning = "$commissioningHoto AND $commissioningInaugrations";
  static const String commissioningHoto = "feasibilityFinalizationDone > 0 AND hotoDone = 0 AND statusId < 13";
  static const String commissioningInaugrations = "feasibilityFinalizationDone >  0 AND inaugurationDone = 0 AND statusId < 13";

  static const String inaugurated = "statusId = 13";
  static const String holdByDealer = "statusId = 15";  
  static const String holdByTgpl = "statusId = 16";
  static const String rejectedByDealer = "statusId = 17";
  static const String rejectedByTgpl = "statusId = 14";

  static const String inprocess = "statusId < 13";
  static const String hold = "statusId IN (15, 16)";
  static const String rejected = "statusId IN (14, 17)";
}