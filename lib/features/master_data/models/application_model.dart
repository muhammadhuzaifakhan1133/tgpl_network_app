class ApplicationModel {
  final int? id;
  final int applicationId;
  final String? dateConducted;
  final String? preparedBy;
  final String? googleLocation;
  final int? cityId;
  final String? cityName;
  final String? district;
  final String? dealerName;
  final String? dealerContact;
  final String? referedBy;
  final String? locationAddress;
  final String? landmark;
  final String? proposedSiteName1;
  final int? statusId;
  final String? entryCode;
  final String? source;
  final String? sourceName;
  final String? priority;
  final String? platform;
  final String? addDate;
  final String? editDate;
  final int? surveyDealerProfileDone;
  final int? trafficTradeDone;
  final int? feasibilityDone;
  final int? negotiationDone;
  final int? mouSignOffDone;
  final int? joiningFeeDone;
  final int? franchiseAgreementDone;
  final int? feasibilityFinalizationDone;
  final int? explosiveLayoutDone;
  final int? drawingsDone;
  final int? topographyDone;
  final int? issuanceOfDrawingsDone;
  final int? appliedInExplosiveDone;
  final int? dcNocDone;
  final int? capexDone;
  final int? leaseAgreementDone;
  final int? hotoDone;
  final int? constructionDone;
  final int? inaugurationDone;
  final String? recommendation;

  ApplicationModel({
    this.id,
    required this.applicationId,
    this.dateConducted,
    this.preparedBy,
    this.googleLocation,
    this.cityId,
    this.cityName,
    this.district,
    this.dealerName,
    this.dealerContact,
    this.referedBy,
    this.locationAddress,
    this.landmark,
    this.proposedSiteName1,
    this.statusId,
    this.entryCode,
    this.source,
    this.sourceName,
    this.priority,
    this.platform,
    this.addDate,
    this.editDate,
    this.surveyDealerProfileDone,
    this.trafficTradeDone,
    this.feasibilityDone,
    this.negotiationDone,
    this.mouSignOffDone,
    this.joiningFeeDone,
    this.franchiseAgreementDone,
    this.feasibilityFinalizationDone,
    this.explosiveLayoutDone,
    this.drawingsDone,
    this.topographyDone,
    this.issuanceOfDrawingsDone,
    this.appliedInExplosiveDone,
    this.dcNocDone,
    this.capexDone,
    this.leaseAgreementDone,
    this.hotoDone,
    this.constructionDone,
    this.inaugurationDone,
    this.recommendation,
  });

  factory ApplicationModel.fromJson(Map<String, dynamic> json) {
    return ApplicationModel(
      applicationId: json['ApplicationId'] ?? 0,
      dateConducted: json['DateConducted'],
      preparedBy: json['PreparedBy'],
      googleLocation: json['GoogleLocation'],
      cityId: json['CityId'],
      cityName: json['CityName'],
      district: json['District'],
      dealerName: json['DealerName'],
      dealerContact: json['DealerContact'],
      referedBy: json['ReferedBy'],
      locationAddress: json['LocationAddress'],
      landmark: json['Landmark'],
      proposedSiteName1: json['ProposedSiteName1'],
      statusId: json['StatusId'],
      entryCode: json['EntryCode'],
      source: json['Source'],
      sourceName: json['SourceName'],
      priority: json['Priority'],
      platform: json['PlatForm'],
      addDate: json['AddDate'],
      editDate: json['EditDate'],
      surveyDealerProfileDone: json['SurveynDealerProfileDone'],
      trafficTradeDone: json['TrafficTradeDone'],
      feasibilityDone: json['FeasibilityDone'],
      negotiationDone: json['NegotiationDone'],
      mouSignOffDone: json['MOUSignOFFDone'],
      joiningFeeDone: json['JoiningFeeDone'],
      franchiseAgreementDone: json['FranchiseAgreementDone'],
      feasibilityFinalizationDone: json['FeasibilityfinalizationDone'],
      explosiveLayoutDone: json['ExplosiveLayoutDone'],
      drawingsDone: json['DrawingsDone'],
      topographyDone: json['TopographyDone'],
      issuanceOfDrawingsDone: json['IssuanceofDrawingsDone'],
      appliedInExplosiveDone: json['AppliedInExplosiveDone'],
      dcNocDone: json['DCNOCDone'],
      capexDone: json['CapexDone'],
      leaseAgreementDone: json['LeaseAgreementDone'],
      hotoDone: json['HOTODone'],
      constructionDone: json['ConstructionDone'],
      inaugurationDone: json['InaugurationDone'],
      recommendation: json['Recommendation'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'applicationId': applicationId,
      'dateConducted': dateConducted,
      'preparedBy': preparedBy,
      'googleLocation': googleLocation,
      'cityId': cityId,
      'cityName': cityName,
      'district': district,
      'dealerName': dealerName,
      'dealerContact': dealerContact,
      'referedBy': referedBy,
      'locationAddress': locationAddress,
      'landmark': landmark,
      'proposedSiteName1': proposedSiteName1,
      'statusId': statusId,
      'entryCode': entryCode,
      'source': source,
      'sourceName': sourceName,
      'priority': priority,
      'platform': platform,
      'addDate': addDate,
      'editDate': editDate,
      'surveyDealerProfileDone': surveyDealerProfileDone,
      'trafficTradeDone': trafficTradeDone,
      'feasibilityDone': feasibilityDone,
      'negotiationDone': negotiationDone,
      'mouSignOffDone': mouSignOffDone,
      'joiningFeeDone': joiningFeeDone,
      'franchiseAgreementDone': franchiseAgreementDone,
      'feasibilityFinalizationDone': feasibilityFinalizationDone,
      'explosiveLayoutDone': explosiveLayoutDone,
      'drawingsDone': drawingsDone,
      'topographyDone': topographyDone,
      'issuanceOfDrawingsDone': issuanceOfDrawingsDone,
      'appliedInExplosiveDone': appliedInExplosiveDone,
      'dcNocDone': dcNocDone,
      'capexDone': capexDone,
      'leaseAgreementDone': leaseAgreementDone,
      'hotoDone': hotoDone,
      'constructionDone': constructionDone,
      'inaugurationDone': inaugurationDone,
      'recommendation': recommendation,
    };
  }

  factory ApplicationModel.fromMap(Map<String, dynamic> map) {
    return ApplicationModel(
      id: map['id'],
      applicationId: map['applicationId'],
      dateConducted: map['dateConducted'],
      preparedBy: map['preparedBy'],
      googleLocation: map['googleLocation'],
      cityId: map['cityId'],
      cityName: map['cityName'],
      district: map['district'],
      dealerName: map['dealerName'],
      dealerContact: map['dealerContact'],
      referedBy: map['referedBy'],
      locationAddress: map['locationAddress'],
      landmark: map['landmark'],
      proposedSiteName1: map['proposedSiteName1'],
      statusId: map['statusId'],
      entryCode: map['entryCode'],
      source: map['source'],
      sourceName: map['sourceName'],
      priority: map['priority'],
      platform: map['platform'],
      addDate: map['addDate'],
      editDate: map['editDate'],
      surveyDealerProfileDone: map['surveyDealerProfileDone'],
      trafficTradeDone: map['trafficTradeDone'],
      feasibilityDone: map['feasibilityDone'],
      negotiationDone: map['negotiationDone'],
      mouSignOffDone: map['mouSignOffDone'],
      joiningFeeDone: map['joiningFeeDone'],
      franchiseAgreementDone: map['franchiseAgreementDone'],
      feasibilityFinalizationDone: map['feasibilityFinalizationDone'],
      explosiveLayoutDone: map['explosiveLayoutDone'],
      drawingsDone: map['drawingsDone'],
      topographyDone: map['topographyDone'],
      issuanceOfDrawingsDone: map['issuanceOfDrawingsDone'],
      appliedInExplosiveDone: map['appliedInExplosiveDone'],
      dcNocDone: map['dcNocDone'],
      capexDone: map['capexDone'],
      leaseAgreementDone: map['leaseAgreementDone'],
      hotoDone: map['hotoDone'],
      constructionDone: map['constructionDone'],
      inaugurationDone: map['inaugurationDone'],
      recommendation: map['recommendation'],
    );
  }
}