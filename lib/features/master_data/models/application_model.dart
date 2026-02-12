import 'package:tgpl_network/common/models/sort_order_direction_enum.dart';
import 'package:tgpl_network/features/applications_filter/applications_filter_state.dart';
import 'package:tgpl_network/common/models/yes_no_enum_with_extension.dart';
import 'package:tgpl_network/features/master_data/models/traffic_trades_model.dart';
import 'package:tgpl_network/utils/extensions/datetime_extension.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

class ApplicationModel {
  static int pageSize = 50;
  static String orderByField = "$alias.applicationId";
  static String alias = "app";
  static SortOrderDirection orderDirection = SortOrderDirection.descending;
  static String get orderBy => "$orderByField ${orderDirection.key}";

  static List<String> mapColumns = [
    "$alias.id",
    "$alias.applicationId",
    "$alias.entryCode",
    "$alias.dealerName",
    "$alias.googleLocation",
    "$alias.siteAddress",
    "$alias.statusId",
    "$alias.priority",
    "$alias.proposedSiteName1",
  ];

  // Computed properties
  double get latitude =>
      double.tryParse(googleLocation?.split(',').first ?? '') ?? 0.0;
  double get longitude =>
      double.tryParse(googleLocation?.split(',').last ?? '') ?? 0.0;

  double get plotAreaValue {
    if (plotFront != null && plotDepth != null) {
      return plotFront! * plotDepth!;
    }
    return 0.0;
  }

  // Fields from JOIN (not stored in main table)
  final List<TrafficTradesModel> nearbyTrafficSites;

  // Primary Fields
  final int? id; // Local database ID
  final int? applicationId;
  final String? applicationReceiveDate;
  final String? applicantName;
  final String? contactPersonName;
  final String? contactNumber;
  final String? whatsAppNumber;
  final String? currentlyPresence;
  final int? cityId;
  final String? cityName;
  final String? district;
  final String? landmark;
  final int? siteStatusId;
  final String? siteStatusName;
  final double? plotFront;
  final double? plotDepth;
  final String? siteAddress;
  final String? googleLocation;
  final String? emailAddress;
  final String? siteSurveyDealerProfileDueDate;
  final String? siteSurveyDealerProfileDoneDate;
  final String? referedBy;
  final String? nearestDepo;
  final double? distanceFromDepo;
  final String? typeOfTradeArea;
  final String? isThisDealerSite;
  final String? whatOtherBusiness;
  final String? howInvolveDealerInPetrol;
  final String? isDealerSole;
  final String? isDealerReadyToCapitalInvestment;
  final String? whyDoesTaj;
  final double? managerCurrentSalary;
  final String? isAgreeToTGPLStandard;
  final String? proposedSiteName1;
  final String? proposedSiteName2;
  final String? proposedSiteName3;
  final double? estimateDailyDieselSale;
  final double? estimateDailySuperSale;
  final double? estimateLubricantSale;
  final double? estimatedDailyHOBCSale;
  final double? expectedLeaseRentPerManth;
  final String? truckPortPotential;
  final String? salamMartPotential;
  final String? resturantPotential;
  final String? isThisConversionPump;
  final String? currentOMCName;
  final String? isThisDealerInvestedSite;
  final double? numberOfOperationYear;
  final String? isCurrentlyOperational;
  final String? currentLeaseExpried;
  final double? dieselUGTSizeLiter;
  final double? superUGTSizeLiter;
  final int? numberOfDieselDispenser;
  final int? numberOfSuperDispenser;
  final String? currentlyCanopyCondition;
  final String? conditionOfDispensors;
  final String? conditionOfForecourt;
  final String? recommendation;
  final String? recommendationDetail;
  final String? negotiationStatus;
  final String? finalDecisionStatus;
  final String? moUSignOff;
  final String? leaseAgreement;
  final String? franchiseAgreement;
  final String? capex;
  final String? entryCode;
  final String? source;
  final String? sourceName;
  final String? priority;
  final String? platForm;
  final String? npPersonName;
  final String? joiningFees;
  final String? topography;
  final String? dcnoc;
  final String? explosive;
  final String? amendmentExplosive;
  final String? appliedInexplosive;
  final String? aeConstructionApproval;
  final String? aeSaftyCompletion;
  final String? aeKForm;
  final String? aeAmendment;
  final String? aeConstructionStart;
  final String? aeConstructionUpdate;
  final String? hoto;
  final String? lastStepDoneBefore;
  final String? ssRecommendationTMName;
  final String? sstmRecommendation;
  final String? sstmRemarks;
  final String? ssRecommendationRMName;
  final String? ssrmRecommendation;
  final String? ssrmRemarks;
  final String? ttRecommendationTMName;
  final String? tttmRecommendation;
  final String? tttmRemarks;
  final String? ttRecommendationRMName;
  final String? ttrmRecommendation;
  final String? ttrmRemarks;
  final String? drawingLayout;
  final String? issuanceOfDrawings;
  final String? changeStatusRemarks;
  final String? constructionStartDate;
  final String? constructionEndDate;
  final int? constructionStatusInPercent;
  final int? surveynDealerProfileDone;
  final int? trafficTradeDone;
  final int? feasibilityDone;
  final int? negotiationDone;
  final int? mouSignOFFDone;
  final int? joiningFeeDone;
  final int? franchiseAgreementDone;
  final int? feasibilityfinalizationDone;
  final int? explosiveLayoutDone;
  final int? drawingsDone;
  final int? topographyDone;
  final int? issuanceofDrawingsDone;
  final int? appliedInExplosiveDone;
  final int? dcnocDone;
  final int? capexDone;
  final int? leaseAgreementDone;
  final int? hotoDone;
  final int? inaugurationDone;
  final int? constructionDone;
  final int? statusId;
  final String? trafficTradeDueDate;
  final String? trafficTradeDoneDate;
  final String? feasibilityDueDate;
  final String? feasibilityDoneDate;
  final String? negotiationDueDate;
  final String? negotiationDoneDate;
  final String? feasibilityfinalizationDueDate;
  final String? feasibilityfinalizationDoneDate;
  final String? mouSignOFFDueDate;
  final String? mouSignOFFDoneDate;
  final String? joiningFeeDueDate;
  final String? joiningFeeDoneDate;
  final String? franchiseAgreementDueDate;
  final String? franchiseAgreementDoneDate;
  final String? explosiveLayoutDueDate;
  final String? explosiveLayoutDoneDate;
  final String? issuanceofDrawingsDueDate;
  final String? issuanceofDrawingsDoneDate;
  final String? topographyDueDate;
  final String? topographyDoneDate;
  final String? drawingsDueDate;
  final String? drawingsDoneDate;
  final String? capaxDueDate;
  final String? capaxDoneDate;
  final String? appliedInExplosiveDueDate;
  final String? appliedInExplosiveDoneDate;
  final String? dcnocDueDate;
  final String? dcnocDoneDate;
  final String? leaseAgreementDueDate;
  final String? leaseAgreementDoneDate;
  final String? constructionDueDate;
  final String? constructionDoneDate;
  final String? hotoDueDate;
  final String? hotoDoneDate;
  final String? inaugurationDueDate;
  final String? inaugurationDoneDate;

  ApplicationModel({
    this.id,
    this.applicationId,
    this.applicationReceiveDate,
    this.applicantName,
    this.contactPersonName,
    this.contactNumber,
    this.whatsAppNumber,
    this.currentlyPresence,
    this.cityId,
    this.cityName,
    this.district,
    this.landmark,
    this.siteStatusId,
    this.siteStatusName,
    this.plotFront,
    this.plotDepth,
    this.siteAddress,
    this.googleLocation,
    this.emailAddress,
    this.siteSurveyDealerProfileDueDate,
    this.siteSurveyDealerProfileDoneDate,
    this.referedBy,
    this.nearestDepo,
    this.distanceFromDepo,
    this.typeOfTradeArea,
    this.isThisDealerSite,
    this.whatOtherBusiness,
    this.howInvolveDealerInPetrol,
    this.isDealerSole,
    this.isDealerReadyToCapitalInvestment,
    this.whyDoesTaj,
    this.managerCurrentSalary,
    this.isAgreeToTGPLStandard,
    this.proposedSiteName1,
    this.proposedSiteName2,
    this.proposedSiteName3,
    this.estimateDailyDieselSale,
    this.estimateDailySuperSale,
    this.estimateLubricantSale,
    this.estimatedDailyHOBCSale,
    this.expectedLeaseRentPerManth,
    this.truckPortPotential,
    this.salamMartPotential,
    this.resturantPotential,
    this.isThisConversionPump,
    this.currentOMCName,
    this.isThisDealerInvestedSite,
    this.numberOfOperationYear,
    this.isCurrentlyOperational,
    this.currentLeaseExpried,
    this.dieselUGTSizeLiter,
    this.superUGTSizeLiter,
    this.numberOfDieselDispenser,
    this.numberOfSuperDispenser,
    this.currentlyCanopyCondition,
    this.conditionOfDispensors,
    this.conditionOfForecourt,
    this.recommendation,
    this.recommendationDetail,
    this.negotiationStatus,
    this.finalDecisionStatus,
    this.moUSignOff,
    this.leaseAgreement,
    this.franchiseAgreement,
    this.capex,
    this.entryCode,
    this.source,
    this.sourceName,
    this.priority,
    this.platForm,
    this.npPersonName,
    this.joiningFees,
    this.topography,
    this.dcnoc,
    this.explosive,
    this.amendmentExplosive,
    this.appliedInexplosive,
    this.aeConstructionApproval,
    this.aeSaftyCompletion,
    this.aeKForm,
    this.aeAmendment,
    this.aeConstructionStart,
    this.aeConstructionUpdate,
    this.hoto,
    this.lastStepDoneBefore,
    this.ssRecommendationTMName,
    this.sstmRecommendation,
    this.sstmRemarks,
    this.ssRecommendationRMName,
    this.ssrmRecommendation,
    this.ssrmRemarks,
    this.ttRecommendationTMName,
    this.tttmRecommendation,
    this.tttmRemarks,
    this.ttRecommendationRMName,
    this.ttrmRecommendation,
    this.ttrmRemarks,
    this.drawingLayout,
    this.issuanceOfDrawings,
    this.changeStatusRemarks,
    this.constructionStartDate,
    this.constructionEndDate,
    this.constructionStatusInPercent,
    this.surveynDealerProfileDone,
    this.trafficTradeDone,
    this.feasibilityDone,
    this.negotiationDone,
    this.mouSignOFFDone,
    this.joiningFeeDone,
    this.franchiseAgreementDone,
    this.feasibilityfinalizationDone,
    this.explosiveLayoutDone,
    this.drawingsDone,
    this.topographyDone,
    this.issuanceofDrawingsDone,
    this.appliedInExplosiveDone,
    this.dcnocDone,
    this.capexDone,
    this.leaseAgreementDone,
    this.hotoDone,
    this.inaugurationDone,
    this.constructionDone,
    this.statusId,
    this.trafficTradeDueDate,
    this.trafficTradeDoneDate,
    this.feasibilityDueDate,
    this.feasibilityDoneDate,
    this.negotiationDueDate,
    this.negotiationDoneDate,
    this.feasibilityfinalizationDueDate,
    this.feasibilityfinalizationDoneDate,
    this.mouSignOFFDueDate,
    this.mouSignOFFDoneDate,
    this.joiningFeeDueDate,
    this.joiningFeeDoneDate,
    this.franchiseAgreementDueDate,
    this.franchiseAgreementDoneDate,
    this.explosiveLayoutDueDate,
    this.explosiveLayoutDoneDate,
    this.issuanceofDrawingsDueDate,
    this.issuanceofDrawingsDoneDate,
    this.topographyDueDate,
    this.topographyDoneDate,
    this.drawingsDueDate,
    this.drawingsDoneDate,
    this.capaxDueDate,
    this.capaxDoneDate,
    this.appliedInExplosiveDueDate,
    this.appliedInExplosiveDoneDate,
    this.dcnocDueDate,
    this.dcnocDoneDate,
    this.leaseAgreementDueDate,
    this.leaseAgreementDoneDate,
    this.constructionDueDate,
    this.constructionDoneDate,
    this.hotoDueDate,
    this.hotoDoneDate,
    this.inaugurationDueDate,
    this.inaugurationDoneDate,
    this.nearbyTrafficSites = const [],
  });

  factory ApplicationModel.fromAPIResponseMap(Map<String, dynamic> json) {
    return ApplicationModel(
      applicationId: int.tryParse(json['ApplicationId'].toString()),
      applicationReceiveDate: json['ApplicationReceiveDate'],
      applicantName: json['ApplicantName'],
      contactPersonName: json['ContactPersonName'],
      contactNumber: json['ContactNumber'],
      whatsAppNumber: json['WhatsAppNumber'],
      currentlyPresence: json['CurrentlyPresence'],
      cityId: int.tryParse(json['CityId'].toString()),
      cityName: json['CityName'],
      district: json['District'],
      landmark: json['Landmark'],
      siteStatusId: int.tryParse(json['SiteStatusId'].toString()),
      siteStatusName: json['SiteStatus'],
      plotFront: double.tryParse(json['PlotFront'].toString()),
      plotDepth: double.tryParse(json['PlotDepth'].toString()),
      siteAddress: json['SiteAddress'],
      googleLocation: json['GoogleLocation'],
      emailAddress: json['EmailAddress'],
      siteSurveyDealerProfileDueDate: json['SiteSurveyDealerProfileDueDate'],
      siteSurveyDealerProfileDoneDate: json['SiteSurveyDealerProfileDoneDate'],
      referedBy: json['ReferedBy'],
      nearestDepo: json['NearestDepo'],
      distanceFromDepo: double.tryParse(json['DistanceFromDepo'].toString()),
      typeOfTradeArea: json['TypeOfTradeArea'],
      isThisDealerSite: json['IsThisDealerSite'],
      whatOtherBusiness: json['WhatOtherBusiness'],
      howInvolveDealerInPetrol: json['HowInvolveDealerInPetrol'],
      isDealerSole: json['IsDealerSole'],
      isDealerReadyToCapitalInvestment: json['IsDealerReadyToCapitalInvestment'],
      whyDoesTaj: json['WhyDoesTaj'],
      managerCurrentSalary: double.tryParse(json['ManagerCurrentSalary'].toString()),
      isAgreeToTGPLStandard: json['IsAgreeToTGPLStandard'],
      proposedSiteName1: json['ProposedSiteName1'],
      proposedSiteName2: json['ProposedSiteName2'],
      proposedSiteName3: json['ProposedSiteName3'],
      estimateDailyDieselSale: double.tryParse(json['EstimateDailyDieselSale'].toString()),
      estimateDailySuperSale: double.tryParse(json['EstimateDailySuperSale'].toString()),
      estimateLubricantSale: double.tryParse(json['EstimateLubricantSale'].toString()),
      estimatedDailyHOBCSale: double.tryParse(json['EstimatedDailyHOBCSale'].toString()),
      expectedLeaseRentPerManth: double.tryParse(json['ExpectedLeaseRentPerManth'].toString()),
      truckPortPotential: json['TruckPortPotential'],
      salamMartPotential: json['SalamMartPotential'],
      resturantPotential: json['ResturantPotential'],
      isThisConversionPump: json['IsThisConversionPump'],
      currentOMCName: json['CurrentOMCName'],
      isThisDealerInvestedSite: json['IsThisDealerInvestedSite'],
      numberOfOperationYear: double.tryParse(json['NumberOfOperationYear'].toString()),
      isCurrentlyOperational: json['IsCurrentlyOperational'],
      currentLeaseExpried: json['CurrentLeaseExpried'],
      dieselUGTSizeLiter: double.tryParse(json['DieselUGTSizeLiter'].toString()),
      superUGTSizeLiter: double.tryParse(json['SuperUGTSizeLiter'].toString()),
      numberOfDieselDispenser: int.tryParse(json['NumberOfDieselDispenser'].toString()),
      numberOfSuperDispenser: int.tryParse(json['NumberOfSuperDispenser'].toString()),
      currentlyCanopyCondition: json['CurrentlyCanopyCondition'],
      conditionOfDispensors: json['ConditionOfDispensors'],
      conditionOfForecourt: json['ConditionOfForecourt'],
      recommendation: json['Recommendation'],
      recommendationDetail: json['RecommendationDetail'],
      negotiationStatus: json['NegotiationStatus'],
      finalDecisionStatus: json['FinalDecisionStatus'],
      moUSignOff: json['MoUSignOff'],
      leaseAgreement: json['LeaseAgreement'],
      franchiseAgreement: json['FranchiseAgreement'],
      capex: json['Capex'],
      entryCode: json['EntryCode'],
      source: json['Source'],
      sourceName: json['SourceName'],
      priority: json['Priority'],
      platForm: json['PlatForm'],
      npPersonName: json['NPPersonName'],
      joiningFees: json['JoiningFees'],
      topography: json['Topography'],
      dcnoc: json['DCNOC'],
      explosive: json['Explosive'],
      amendmentExplosive: json['AmendmentExplosive'],
      appliedInexplosive: json['AppliedInexplosive'],
      aeConstructionApproval: json['AE_ConstructionApproval'],
      aeSaftyCompletion: json['AE_SaftyCompletion'],
      aeKForm: json['AE_KForm'],
      aeAmendment: json['AE_Amendment'],
      aeConstructionStart: json['AE_ConstructionStart'],
      aeConstructionUpdate: json['AE_ConstructionUpdate'],
      hoto: json['HOTO'],
      lastStepDoneBefore: json['LastStepDoneBefore'],
      ssRecommendationTMName: json['SSRecommendationTMName'],
      sstmRecommendation: json['SSTMRecommendation'],
      sstmRemarks: json['SSTMRemarks'],
      ssRecommendationRMName: json['SSRecommendationRMName'],
      ssrmRecommendation: json['SSRMRecommendation'],
      ssrmRemarks: json['SSRMRemarks'],
      ttRecommendationTMName: json['TTRecommendationTMName'],
      tttmRecommendation: json['TTTMRecommendation'],
      tttmRemarks: json['TTTMRemarks'],
      ttRecommendationRMName: json['TTRecommendationRMName'],
      ttrmRecommendation: json['TTRMRecommendation'],
      ttrmRemarks: json['TTRMRemarks'],
      drawingLayout: json['DrawingLayout'],
      issuanceOfDrawings: json['IssuanceOfDrawings'],
      changeStatusRemarks: json['ChangeStatusRemarks'],
      constructionStartDate: json['ConstructionStartDate'],
      constructionEndDate: json['ConstructionEndDate'],
      constructionStatusInPercent: int.tryParse(json['ConstructionStatusInPercent'].toString()),
      surveynDealerProfileDone: int.tryParse(json['SurveynDealerProfileDone'].toString()),
      trafficTradeDone: int.tryParse(json['TrafficTradeDone'].toString()),
      feasibilityDone: int.tryParse(json['FeasibilityDone'].toString()),
      negotiationDone: int.tryParse(json['NegotiationDone'].toString()),
      mouSignOFFDone: int.tryParse(json['MOUSignOFFDone'].toString()),
      joiningFeeDone: int.tryParse(json['JoiningFeeDone'].toString()),
      franchiseAgreementDone: int.tryParse(json['FranchiseAgreementDone'].toString()),
      feasibilityfinalizationDone: int.tryParse(json['FeasibilityfinalizationDone'].toString()),
      explosiveLayoutDone: int.tryParse(json['ExplosiveLayoutDone'].toString()),
      drawingsDone: int.tryParse(json['DrawingsDone'].toString()),
      topographyDone: int.tryParse(json['TopographyDone'].toString()),
      issuanceofDrawingsDone: int.tryParse(json['IssuanceofDrawingsDone'].toString()),
      appliedInExplosiveDone: int.tryParse(json['AppliedInExplosiveDone'].toString()),
      dcnocDone: int.tryParse(json['DCNOCDone'].toString()),
      capexDone: int.tryParse(json['CapexDone'].toString()),
      leaseAgreementDone: int.tryParse(json['LeaseAgreementDone'].toString()),
      hotoDone: int.tryParse(json['HOTODone'].toString()),
      inaugurationDone: int.tryParse(json['InaugurationDone'].toString()),
      constructionDone: int.tryParse(json['ConstructionDone'].toString()),
      statusId: int.tryParse(json['StatusId'].toString()),
      trafficTradeDueDate: json['TrafficTradeDueDate'],
      trafficTradeDoneDate: json['TrafficTradeDoneDate'],
      feasibilityDueDate: json['FeasibilityDueDate'],
      feasibilityDoneDate: json['FeasibilityDoneDate'],
      negotiationDueDate: json['NegotiationDueDate'],
      negotiationDoneDate: json['NegotiationDoneDate'],
      feasibilityfinalizationDueDate: json['FeasibilityfinalizationDueDate'],
      feasibilityfinalizationDoneDate: json['FeasibilityfinalizationDoneDate'],
      mouSignOFFDueDate: json['MOUSignOFFDueDate'],
      mouSignOFFDoneDate: json['MOUSignOFFDoneDate'],
      joiningFeeDueDate: json['JoiningFeeDueDate'],
      joiningFeeDoneDate: json['JoiningFeeDoneDate'],
      franchiseAgreementDueDate: json['FranchiseAgreementDueDate'],
      franchiseAgreementDoneDate: json['FranchiseAgreementDoneDate'],
      explosiveLayoutDueDate: json['ExplosiveLayoutDueDate'],
      explosiveLayoutDoneDate: json['ExplosiveLayoutDoneDate'],
      issuanceofDrawingsDueDate: json['IssuanceofDrawingsDueDate'],
      issuanceofDrawingsDoneDate: json['IssuanceofDrawingsDoneDate'],
      topographyDueDate: json['TopographyDueDate'],
      topographyDoneDate: json['TopographyDoneDate'],
      drawingsDueDate: json['DrawingsDueDate'],
      drawingsDoneDate: json['DrawingsDoneDate'],
      capaxDueDate: json['CapaxDueDate'],
      capaxDoneDate: json['CapaxDoneDate'],
      appliedInExplosiveDueDate: json['AppliedInExplosiveDueDate'],
      appliedInExplosiveDoneDate: json['AppliedInExplosiveDoneDate'],
      dcnocDueDate: json['DCNOCDueDate'],
      dcnocDoneDate: json['DCNOCDoneDate'],
      leaseAgreementDueDate: json['LeaseAgreementDueDate'],
      leaseAgreementDoneDate: json['LeaseAgreementDoneDate'],
      constructionDueDate: json['ConstructionDueDate'],
      constructionDoneDate: json['ConstructionDoneDate'],
      hotoDueDate: json['HOTODueDate'],
      hotoDoneDate: json['HOTODoneDate'],
      inaugurationDueDate: json['InaugurationDueDate'],
      inaugurationDoneDate: json['InaugurationDoneDate'],
    );
  }

  factory ApplicationModel.fromDatabaseMap(
    Map<String, dynamic> map, {
    List<TrafficTradesModel>? nearbyTrafficSites,
  }) {
    return ApplicationModel(
      id: map['id'],
      applicationId: map['applicationId'],
      applicationReceiveDate: map['applicationReceiveDate'],
      applicantName: map['applicantName'],
      contactPersonName: map['contactPersonName'],
      contactNumber: map['contactNumber'],
      whatsAppNumber: map['whatsAppNumber'],
      currentlyPresence: map['currentlyPresence'],
      cityId: map['cityId'],
      cityName: map['cityName'],
      district: map['district'],
      landmark: map['landmark'],
      siteStatusId: map['siteStatusId'],
      siteStatusName: map['siteStatusName'],
      plotFront: map['plotFront'],
      plotDepth: map['plotDepth'],
      siteAddress: map['siteAddress'],
      googleLocation: map['googleLocation'],
      emailAddress: map['emailAddress'],
      siteSurveyDealerProfileDueDate: map['siteSurveyDealerProfileDueDate'],
      siteSurveyDealerProfileDoneDate: map['siteSurveyDealerProfileDoneDate'],
      referedBy: map['referedBy'],
      nearestDepo: map['nearestDepo'],
      distanceFromDepo: map['distanceFromDepo'],
      typeOfTradeArea: map['typeOfTradeArea'],
      isThisDealerSite: map['isThisDealerSite'],
      whatOtherBusiness: map['whatOtherBusiness'],
      howInvolveDealerInPetrol: map['howInvolveDealerInPetrol'],
      isDealerSole: map['isDealerSole'],
      isDealerReadyToCapitalInvestment: map['isDealerReadyToCapitalInvestment'],
      whyDoesTaj: map['whyDoesTaj'],
      managerCurrentSalary: map['managerCurrentSalary'],
      isAgreeToTGPLStandard: map['isAgreeToTGPLStandard'],
      proposedSiteName1: map['proposedSiteName1'],
      proposedSiteName2: map['proposedSiteName2'],
      proposedSiteName3: map['proposedSiteName3'],
      estimateDailyDieselSale: map['estimateDailyDieselSale'],
      estimateDailySuperSale: map['estimateDailySuperSale'],
      estimateLubricantSale: map['estimateLubricantSale'],
      estimatedDailyHOBCSale: map['estimatedDailyHOBCSale'],
      expectedLeaseRentPerManth: map['expectedLeaseRentPerManth'],
      truckPortPotential: map['truckPortPotential'],
      salamMartPotential: map['salamMartPotential'],
      resturantPotential: map['resturantPotential'],
      isThisConversionPump: map['isThisConversionPump'],
      currentOMCName: map['currentOMCName'],
      isThisDealerInvestedSite: map['isThisDealerInvestedSite'],
      numberOfOperationYear: map['numberOfOperationYear'],
      isCurrentlyOperational: map['isCurrentlyOperational'],
      currentLeaseExpried: map['currentLeaseExpried'],
      dieselUGTSizeLiter: map['dieselUGTSizeLiter'],
      superUGTSizeLiter: map['superUGTSizeLiter'],
      numberOfDieselDispenser: map['numberOfDieselDispenser'],
      numberOfSuperDispenser: map['numberOfSuperDispenser'],
      currentlyCanopyCondition: map['currentlyCanopyCondition'],
      conditionOfDispensors: map['conditionOfDispensors'],
      conditionOfForecourt: map['conditionOfForecourt'],
      recommendation: map['recommendation'],
      recommendationDetail: map['recommendationDetail'],
      negotiationStatus: map['negotiationStatus'],
      finalDecisionStatus: map['finalDecisionStatus'],
      moUSignOff: map['moUSignOff'],
      leaseAgreement: map['leaseAgreement'],
      franchiseAgreement: map['franchiseAgreement'],
      capex: map['capex'],
      entryCode: map['entryCode'],
      source: map['source'],
      sourceName: map['sourceName'],
      priority: map['priority'],
      platForm: map['platForm'],
      npPersonName: map['npPersonName'],
      joiningFees: map['joiningFees'],
      topography: map['topography'],
      dcnoc: map['dcnoc'],
      explosive: map['explosive'],
      amendmentExplosive: map['amendmentExplosive'],
      appliedInexplosive: map['appliedInexplosive'],
      aeConstructionApproval: map['aeConstructionApproval'],
      aeSaftyCompletion: map['aeSaftyCompletion'],
      aeKForm: map['aeKForm'],
      aeAmendment: map['aeAmendment'],
      aeConstructionStart: map['aeConstructionStart'],
      aeConstructionUpdate: map['aeConstructionUpdate'],
      hoto: map['hoto'],
      lastStepDoneBefore: map['lastStepDoneBefore'],
      ssRecommendationTMName: map['ssRecommendationTMName'],
      sstmRecommendation: map['sstmRecommendation'],
      sstmRemarks: map['sstmRemarks'],
      ssRecommendationRMName: map['ssRecommendationRMName'],
      ssrmRecommendation: map['ssrmRecommendation'],
      ssrmRemarks: map['ssrmRemarks'],
      ttRecommendationTMName: map['ttRecommendationTMName'],
      tttmRecommendation: map['tttmRecommendation'],
      tttmRemarks: map['tttmRemarks'],
      ttRecommendationRMName: map['ttRecommendationRMName'],
      ttrmRecommendation: map['ttrmRecommendation'],
      ttrmRemarks: map['ttrmRemarks'],
      drawingLayout: map['drawingLayout'],
      issuanceOfDrawings: map['issuanceOfDrawings'],
      changeStatusRemarks: map['changeStatusRemarks'],
      constructionStartDate: map['constructionStartDate'],
      constructionEndDate: map['constructionEndDate'],
      constructionStatusInPercent: map['constructionStatusInPercent'],
      surveynDealerProfileDone: map['surveynDealerProfileDone'],
      trafficTradeDone: map['trafficTradeDone'],
      feasibilityDone: map['feasibilityDone'],
      negotiationDone: map['negotiationDone'],
      mouSignOFFDone: map['mouSignOFFDone'],
      joiningFeeDone: map['joiningFeeDone'],
      franchiseAgreementDone: map['franchiseAgreementDone'],
      feasibilityfinalizationDone: map['feasibilityfinalizationDone'],
      explosiveLayoutDone: map['explosiveLayoutDone'],
      drawingsDone: map['drawingsDone'],
      topographyDone: map['topographyDone'],
      issuanceofDrawingsDone: map['issuanceofDrawingsDone'],
      appliedInExplosiveDone: map['appliedInExplosiveDone'],
      dcnocDone: map['dcnocDone'],
      capexDone: map['capexDone'],
      leaseAgreementDone: map['leaseAgreementDone'],
      hotoDone: map['hotoDone'],
      inaugurationDone: map['inaugurationDone'],
      constructionDone: map['constructionDone'],
      statusId: map['statusId'],
      trafficTradeDueDate: map['trafficTradeDueDate'],
      trafficTradeDoneDate: map['trafficTradeDoneDate'],
      feasibilityDueDate: map['feasibilityDueDate'],
      feasibilityDoneDate: map['feasibilityDoneDate'],
      negotiationDueDate: map['negotiationDueDate'],
      negotiationDoneDate: map['negotiationDoneDate'],
      feasibilityfinalizationDueDate: map['feasibilityfinalizationDueDate'],
      feasibilityfinalizationDoneDate: map['feasibilityfinalizationDoneDate'],
      mouSignOFFDueDate: map['mouSignOFFDueDate'],
      mouSignOFFDoneDate: map['mouSignOFFDoneDate'],
      joiningFeeDueDate: map['joiningFeeDueDate'],
      joiningFeeDoneDate: map['joiningFeeDoneDate'],
      franchiseAgreementDueDate: map['franchiseAgreementDueDate'],
      franchiseAgreementDoneDate: map['franchiseAgreementDoneDate'],
      explosiveLayoutDueDate: map['explosiveLayoutDueDate'],
      explosiveLayoutDoneDate: map['explosiveLayoutDoneDate'],
      issuanceofDrawingsDueDate: map['issuanceofDrawingsDueDate'],
      issuanceofDrawingsDoneDate: map['issuanceofDrawingsDoneDate'],
      topographyDueDate: map['topographyDueDate'],
      topographyDoneDate: map['topographyDoneDate'],
      drawingsDueDate: map['drawingsDueDate'],
      drawingsDoneDate: map['drawingsDoneDate'],
      capaxDueDate: map['capaxDueDate'],
      capaxDoneDate: map['capaxDoneDate'],
      appliedInExplosiveDueDate: map['appliedInExplosiveDueDate'],
      appliedInExplosiveDoneDate: map['appliedInExplosiveDoneDate'],
      dcnocDueDate: map['dcnocDueDate'],
      dcnocDoneDate: map['dcnocDoneDate'],
      leaseAgreementDueDate: map['leaseAgreementDueDate'],
      leaseAgreementDoneDate: map['leaseAgreementDoneDate'],
      constructionDueDate: map['constructionDueDate'],
      constructionDoneDate: map['constructionDoneDate'],
      hotoDueDate: map['hotoDueDate'],
      hotoDoneDate: map['hotoDoneDate'],
      inaugurationDueDate: map['inaugurationDueDate'],
      inaugurationDoneDate: map['inaugurationDoneDate'],
      nearbyTrafficSites: nearbyTrafficSites ?? [],
    );
  }

  Map<String, dynamic> toDatabaseMap() {
    return {
      'id': id,
      'applicationId': applicationId,
      'applicationReceiveDate': applicationReceiveDate,
      'applicantName': applicantName,
      'contactPersonName': contactPersonName,
      'contactNumber': contactNumber,
      'whatsAppNumber': whatsAppNumber,
      'currentlyPresence': currentlyPresence,
      'cityId': cityId,
      'cityName': cityName,
      'district': district,
      'landmark': landmark,
      'siteStatusId': siteStatusId,
      'siteStatusName': siteStatusName,
      'plotFront': plotFront,
      'plotDepth': plotDepth,
      'siteAddress': siteAddress,
      'googleLocation': googleLocation,
      'emailAddress': emailAddress,
      'siteSurveyDealerProfileDueDate': siteSurveyDealerProfileDueDate,
      'siteSurveyDealerProfileDoneDate': siteSurveyDealerProfileDoneDate,
      'referedBy': referedBy,
      'nearestDepo': nearestDepo,
      'distanceFromDepo': distanceFromDepo,
      'typeOfTradeArea': typeOfTradeArea,
      'isThisDealerSite': isThisDealerSite,
      'whatOtherBusiness': whatOtherBusiness,
      'howInvolveDealerInPetrol': howInvolveDealerInPetrol,
      'isDealerSole': isDealerSole,
      'isDealerReadyToCapitalInvestment': isDealerReadyToCapitalInvestment,
      'whyDoesTaj': whyDoesTaj,
      'managerCurrentSalary': managerCurrentSalary,
      'isAgreeToTGPLStandard': isAgreeToTGPLStandard,
      'proposedSiteName1': proposedSiteName1,
      'proposedSiteName2': proposedSiteName2,
      'proposedSiteName3': proposedSiteName3,
      'estimateDailyDieselSale': estimateDailyDieselSale,
      'estimateDailySuperSale': estimateDailySuperSale,
      'estimateLubricantSale': estimateLubricantSale,
      'estimatedDailyHOBCSale': estimatedDailyHOBCSale,
      'expectedLeaseRentPerManth': expectedLeaseRentPerManth,
      'truckPortPotential': truckPortPotential,
      'salamMartPotential': salamMartPotential,
      'resturantPotential': resturantPotential,
      'isThisConversionPump': isThisConversionPump,
      'currentOMCName': currentOMCName,
      'isThisDealerInvestedSite': isThisDealerInvestedSite,
      'numberOfOperationYear': numberOfOperationYear,
      'isCurrentlyOperational': isCurrentlyOperational,
      'currentLeaseExpried': currentLeaseExpried,
      'dieselUGTSizeLiter': dieselUGTSizeLiter,
      'superUGTSizeLiter': superUGTSizeLiter,
      'numberOfDieselDispenser': numberOfDieselDispenser,
      'numberOfSuperDispenser': numberOfSuperDispenser,
      'currentlyCanopyCondition': currentlyCanopyCondition,
      'conditionOfDispensors': conditionOfDispensors,
      'conditionOfForecourt': conditionOfForecourt,
      'recommendation': recommendation,
      'recommendationDetail': recommendationDetail,
      'negotiationStatus': negotiationStatus,
      'finalDecisionStatus': finalDecisionStatus,
      'moUSignOff': moUSignOff,
      'leaseAgreement': leaseAgreement,
      'franchiseAgreement': franchiseAgreement,
      'capex': capex,
      'entryCode': entryCode,
      'source': source,
      'sourceName': sourceName,
      'priority': priority,
      'platForm': platForm,
      'npPersonName': npPersonName,
      'joiningFees': joiningFees,
      'topography': topography,
      'dcnoc': dcnoc,
      'explosive': explosive,
      'amendmentExplosive': amendmentExplosive,
      'appliedInexplosive': appliedInexplosive,
      'aeConstructionApproval': aeConstructionApproval,
      'aeSaftyCompletion': aeSaftyCompletion,
      'aeKForm': aeKForm,
      'aeAmendment': aeAmendment,
      'aeConstructionStart': aeConstructionStart,
      'aeConstructionUpdate': aeConstructionUpdate,
      'hoto': hoto,
      'lastStepDoneBefore': lastStepDoneBefore,
      'ssRecommendationTMName': ssRecommendationTMName,
      'sstmRecommendation': sstmRecommendation,
      'sstmRemarks': sstmRemarks,
      'ssRecommendationRMName': ssRecommendationRMName,
      'ssrmRecommendation': ssrmRecommendation,
      'ssrmRemarks': ssrmRemarks,
      'ttRecommendationTMName': ttRecommendationTMName,
      'tttmRecommendation': tttmRecommendation,
      'tttmRemarks': tttmRemarks,
      'ttRecommendationRMName': ttRecommendationRMName,
      'ttrmRecommendation': ttrmRecommendation,
      'ttrmRemarks': ttrmRemarks,
      'drawingLayout': drawingLayout,
      'issuanceOfDrawings': issuanceOfDrawings,
      'changeStatusRemarks': changeStatusRemarks,
      'constructionStartDate': constructionStartDate,
      'constructionEndDate': constructionEndDate,
      'constructionStatusInPercent': constructionStatusInPercent,
      'surveynDealerProfileDone': surveynDealerProfileDone,
      'trafficTradeDone': trafficTradeDone,
      'feasibilityDone': feasibilityDone,
      'negotiationDone': negotiationDone,
      'mouSignOFFDone': mouSignOFFDone,
      'joiningFeeDone': joiningFeeDone,
      'franchiseAgreementDone': franchiseAgreementDone,
      'feasibilityfinalizationDone': feasibilityfinalizationDone,
      'explosiveLayoutDone': explosiveLayoutDone,
      'drawingsDone': drawingsDone,
      'topographyDone': topographyDone,
      'issuanceofDrawingsDone': issuanceofDrawingsDone,
      'appliedInExplosiveDone': appliedInExplosiveDone,
      'dcnocDone': dcnocDone,
      'capexDone': capexDone,
      'leaseAgreementDone': leaseAgreementDone,
      'hotoDone': hotoDone,
      'inaugurationDone': inaugurationDone,
      'constructionDone': constructionDone,
      'statusId': statusId,
      'trafficTradeDueDate': trafficTradeDueDate,
      'trafficTradeDoneDate': trafficTradeDoneDate,
      'feasibilityDueDate': feasibilityDueDate,
      'feasibilityDoneDate': feasibilityDoneDate,
      'negotiationDueDate': negotiationDueDate,
      'negotiationDoneDate': negotiationDoneDate,
      'feasibilityfinalizationDueDate': feasibilityfinalizationDueDate,
      'feasibilityfinalizationDoneDate': feasibilityfinalizationDoneDate,
      'mouSignOFFDueDate': mouSignOFFDueDate,
      'mouSignOFFDoneDate': mouSignOFFDoneDate,
      'joiningFeeDueDate': joiningFeeDueDate,
      'joiningFeeDoneDate': joiningFeeDoneDate,
      'franchiseAgreementDueDate': franchiseAgreementDueDate,
      'franchiseAgreementDoneDate': franchiseAgreementDoneDate,
      'explosiveLayoutDueDate': explosiveLayoutDueDate,
      'explosiveLayoutDoneDate': explosiveLayoutDoneDate,
      'issuanceofDrawingsDueDate': issuanceofDrawingsDueDate,
      'issuanceofDrawingsDoneDate': issuanceofDrawingsDoneDate,
      'topographyDueDate': topographyDueDate,
      'topographyDoneDate': topographyDoneDate,
      'drawingsDueDate': drawingsDueDate,
      'drawingsDoneDate': drawingsDoneDate,
      'capaxDueDate': capaxDueDate,
      'capaxDoneDate': capaxDoneDate,
      'appliedInExplosiveDueDate': appliedInExplosiveDueDate,
      'appliedInExplosiveDoneDate': appliedInExplosiveDoneDate,
      'dcnocDueDate': dcnocDueDate,
      'dcnocDoneDate': dcnocDoneDate,
      'leaseAgreementDueDate': leaseAgreementDueDate,
      'leaseAgreementDoneDate': leaseAgreementDoneDate,
      'constructionDueDate': constructionDueDate,
      'constructionDoneDate': constructionDoneDate,
      'hotoDueDate': hotoDueDate,
      'hotoDoneDate': hotoDoneDate,
      'inaugurationDueDate': inaugurationDueDate,
      'inaugurationDoneDate': inaugurationDoneDate,
    };
  }

  static (List<String>, List<dynamic>) getWhereClauseAndArgs(
    FilterSelectionState filters,
  ) {
    final whereConditions = <String>[];
    final whereArgs = <dynamic>[];

    if (filters.countofActiveFilters > 0) {
      if (filters.selectedCity != null) {
        whereConditions.add('$alias.cityName LIKE ?');
        whereArgs.add(filters.selectedCity);
      }

      if (filters.selectedPriority != null) {
        whereConditions.add('$alias.priority = ?');
        whereArgs.add(filters.selectedPriority);
      }

      if (filters.selectedStatusId != null) {
        if (filters.selectedStatusId!.split(",").length > 1) {
          final statusIds = filters.selectedStatusId!.split(",");
          String whereCond = '$alias.statusId IN (';
          for (var i = 0; i < statusIds.length; i++) {
            int? statusId = int.tryParse(statusIds[i].trim());
            if (statusId != null) {
              whereCond += '?';
              if (i < statusIds.length - 1) {
                whereCond += ', ';
              }
              whereArgs.add(statusId);
            }
          }
          whereCond += ')';
          whereConditions.add(whereCond);
        } else {
          int? statusId = int.tryParse(filters.selectedStatusId!);
          if (statusId != null) {
            whereConditions.add('$alias.statusId = ?');
            whereArgs.add(statusId);
          }
        }
      }

      if (!filters.applicationId.isNullOrEmpty &&
          int.tryParse(filters.applicationId!) != null) {
        whereConditions.add('$alias.applicationId = ?');
        whereArgs.add(int.parse(filters.applicationId!));
      }

      if (!filters.entryCode.isNullOrEmpty) {
        whereConditions.add('$alias.entryCode LIKE ?');
        whereArgs.add('%${filters.entryCode}%');
      }

      if (!filters.district.isNullOrEmpty) {
        whereConditions.add('$alias.district LIKE ?');
        whereArgs.add('%${filters.district}%');
      }

      if (!filters.address.isNullOrEmpty) {
        whereConditions.add('$alias.siteAddress LIKE ?');
        whereArgs.add('%${filters.address}%');
      }

      if (!filters.referredBy.isNullOrEmpty) {
        whereConditions.add('$alias.referedBy LIKE ?');
        whereArgs.add('%${filters.referredBy}%');
      }

      if (!filters.source.isNullOrEmpty) {
        whereConditions.add('$alias.source LIKE ?');
        whereArgs.add('%${filters.source}%');
      }

      if (!filters.sourceName.isNullOrEmpty) {
        whereConditions.add('$alias.sourceName LIKE ?');
        whereArgs.add('%${filters.sourceName}%');
      }

      if (!filters.siteName.isNullOrEmpty) {
        whereConditions.add('$alias.proposedSiteName1 LIKE ?');
        whereArgs.add('%${filters.siteName}%');
      }

      // Yes/No filters (stored as 0 or 1 in database)
      if (filters.surveyProfile != null) {
        whereConditions.add('$alias.surveynDealerProfileDone = ?');
        whereArgs.add(filters.surveyProfile!.value);
      }

      if (filters.trafficTrade != null) {
        whereConditions.add('$alias.trafficTradeDone = ?');
        whereArgs.add(filters.trafficTrade!.value);
      }

      if (filters.feasibility != null) {
        whereConditions.add('$alias.feasibilityDone = ?');
        whereArgs.add(filters.feasibility!.value);
      }

      if (filters.negotiation != null) {
        whereConditions.add('$alias.negotiationDone = ?');
        whereArgs.add(filters.negotiation!.value);
      }

      if (filters.mouSign != null) {
        whereConditions.add('$alias.mouSignOFFDone = ?');
        whereArgs.add(filters.mouSign!.value);
      }

      if (filters.joiningFee != null) {
        whereConditions.add('$alias.joiningFeeDone = ?');
        whereArgs.add(filters.joiningFee!.value);
      }

      if (filters.franchiseAgreement != null) {
        whereConditions.add('$alias.franchiseAgreementDone = ?');
        whereArgs.add(filters.franchiseAgreement!.value);
      }

      if (filters.feasibilityFinalization != null) {
        whereConditions.add('$alias.feasibilityfinalizationDone = ?');
        whereArgs.add(filters.feasibilityFinalization!.value);
      }

      if (filters.explosiveLayout != null) {
        whereConditions.add('$alias.explosiveLayoutDone = ?');
        whereArgs.add(filters.explosiveLayout!.value);
      }

      if (filters.drawing != null) {
        whereConditions.add('$alias.drawingsDone = ?');
        whereArgs.add(filters.drawing!.value);
      }

      if (filters.topography != null) {
        whereConditions.add('$alias.topographyDone = ?');
        whereArgs.add(filters.topography!.value);
      }

      if (filters.issuanceOfDrawing != null) {
        whereConditions.add('$alias.issuanceofDrawingsDone = ?');
        whereArgs.add(filters.issuanceOfDrawing!.value);
      }

      if (filters.appliedInExplosive != null) {
        whereConditions.add('$alias.appliedInExplosiveDone = ?');
        whereArgs.add(filters.appliedInExplosive!.value);
      }

      if (filters.dcNoc != null) {
        whereConditions.add('$alias.dcnocDone = ?');
        whereArgs.add(filters.dcNoc!.value);
      }

      if (filters.capex != null) {
        whereConditions.add('$alias.capexDone = ?');
        whereArgs.add(filters.capex!.value);
      }

      if (filters.leaseAgreement != null) {
        whereConditions.add('$alias.leaseAgreementDone = ?');
        whereArgs.add(filters.leaseAgreement!.value);
      }

      if (filters.hoto != null) {
        whereConditions.add('$alias.hotoDone = ?');
        whereArgs.add(filters.hoto!.value);
      }

      if (filters.construction != null) {
        whereConditions.add('$alias.constructionDone = ?');
        whereArgs.add(filters.construction!.value);
      }

      if (filters.inauguration != null) {
        whereConditions.add('$alias.inaugurationDone = ?');
        whereArgs.add(filters.inauguration!.value);
      }

      // Date filters
      if (filters.fromDate.isValidDate() && filters.toDate.isValidDate()) {
        whereConditions.add('$alias.applicationReceiveDate BETWEEN ? AND ?');
        whereArgs.add(filters.fromDate?.formatFromDDMMYYYToIsoDate());
        whereArgs.add(filters.toDate?.formatFromDDMMYYYToIsoDate());
      } else if (filters.fromDate.isValidDate()) {
        whereConditions.add('$alias.applicationReceiveDate >= ?');
        whereArgs.add(filters.fromDate?.formatFromDDMMYYYToIsoDate());
      } else if (filters.toDate.isValidDate()) {
        whereConditions.add('$alias.applicationReceiveDate <= ?');
        whereArgs.add(filters.toDate?.formatFromDDMMYYYToIsoDate());
      }
    }

    return (whereConditions, whereArgs);
  }
}