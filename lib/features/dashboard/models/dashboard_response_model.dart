class DashboardResponseModel {
  final DashboardApplicationsCounts counts;

  DashboardResponseModel({
    required this.counts,
  });
}

class DashboardApplicationsCounts {
  final int inProcess;
  final int hold;
  final int inaugurated;
  final int rejected;
  final int siteScreening;
  final int openApplications;
  final int surveyAndDealerProfile;
  final int trafficAndTrade;
  final int feasibility;
  final int feasibilityFeasibility;
  final int negotiations;
  final int feasibilityFinalization;
  final int approvals;
  final int mouSignOff;
  final int joiningFee;
  final int franchiseAgreement;
  final int layouts;
  final int governmentLayout;
  final int issuanceOfDrawings;
  final int topography;
  final int drawing;
  final int capex;
  final int documents;
  final int appliedInExplosive;
  final int dcNoc;
  final int leaseAgreement;
  final int construction;
  final int commissioning;
  final int hoto;
  final int inauguration;
  final int holdByDealer;
  final int holdByTgpl;
  final int rejectedByDealer;
  final int rejectedByTgpl;
  final int hisotry;

  DashboardApplicationsCounts({
    required this.inProcess,
    required this.hold,
    required this.inaugurated,
    required this.rejected,
    required this.siteScreening,
    required this.openApplications,
    required this.surveyAndDealerProfile,
    required this.trafficAndTrade,
    required this.feasibility,
    required this.feasibilityFeasibility,
    required this.negotiations,
    required this.feasibilityFinalization,
    required this.approvals,
    required this.mouSignOff,
    required this.joiningFee,
    required this.franchiseAgreement,
    required this.layouts,
    required this.governmentLayout,
    required this.issuanceOfDrawings,
    required this.topography,
    required this.drawing,
    required this.capex,
    required this.documents,
    required this.appliedInExplosive,
    required this.dcNoc,
    required this.leaseAgreement,
    required this.construction,
    required this.commissioning,
    required this.hoto,
    required this.inauguration,
    required this.holdByDealer,
    required this.holdByTgpl,
    required this.rejectedByDealer,
    required this.rejectedByTgpl,
    this.hisotry = 0,
  });

  DashboardApplicationsCounts.fromJson(Map<String, dynamic> json)
      : inProcess = json['inProcessCount'] ?? 0,
        hold = json['holdCount'] ?? 0,
        inaugurated = json['inauguratedCount'] ?? 0,
        rejected = json['rejectedCount'] ?? 0,
        siteScreening = json['siteScreeningCount'] ?? 0,
        openApplications = json['openApplicationsCount'] ?? 0,
        surveyAndDealerProfile = json['surveyAndDealerProfileCount'] ?? 0,
        trafficAndTrade = json['trafficAndTradeCount'] ?? 0,
        feasibility = json['feasibilityCount'] ?? 0,
        feasibilityFeasibility = json['feasibilityFeasibilityCount'] ?? 0,
        negotiations = json['negotiationsCount'] ?? 0,
        feasibilityFinalization = json['feasibilityFinalizationCount'] ?? 0,
        approvals = json['approvalsCount'] ?? 0,
        mouSignOff = json['mouSignOffCount'] ?? 0,
        joiningFee = json['joiningFeeCount'] ?? 0,
        franchiseAgreement = json['franchiseAgreementCount'] ?? 0,
        layouts = json['layoutCount'] ?? 0,
        governmentLayout = json['governmentLayoutCount'] ?? 0,
        issuanceOfDrawings = json['issuanceOfDrawingsCount'] ?? 0,
        topography = json['topographyCount'] ?? 0,
        drawing = json['drawingCount'] ?? 0,
        capex = json['capexCount'] ?? 0,
        documents = json['documentsCount'] ?? 0,
        appliedInExplosive = json['appliedInExplosiveCount'] ?? 0,
        dcNoc = json['dcNocCount'] ?? 0,
        leaseAgreement = json['leaseAgreementCount'] ?? 0,
        construction = json['constructionCount'] ?? 0,
        commissioning = json['commissioningCount'] ?? 0,
        hoto = json['hotoCount'] ?? 0,
        hisotry = json['historyCount'] ?? 0,
        inauguration = json['inaugurationCount'] ?? 0,
        holdByDealer = json['holdByDealerCount'] ?? 0,
        holdByTgpl = json['holdByTgplCount'] ?? 0,
        rejectedByDealer = json['rejectedByDealerCount'] ?? 0,
        rejectedByTgpl = json['rejectedByTgplCount'] ?? 0;
}