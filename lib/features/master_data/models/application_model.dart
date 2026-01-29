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
    "id",
    "applicationId",
    "entryCode",
    "dealerName",
    "googleLocation",
    "locationAddress",
    "statusId",
    "priority",
    "proposedSiteName1",
  ];

  double get latitude =>
      double.tryParse(googleLocation?.split(',').first ?? '') ?? 0.0;
  double get longitude =>
      double.tryParse(googleLocation?.split(',').last ?? '') ?? 0.0;

  double get plotAreaValue => plotArea.isNullOrEmpty
      ? _plotArea
      : double.tryParse(plotArea!) ?? _plotArea;

  double get _plotArea => (plotFront ?? 0) * (plotDepth ?? 0);

  // fields get by join table
  final String? siteStatusName;
  final List<TrafficTradesModel> nearbyTrafficSites;

  // fields
  final int? id;
  final int? applicationId;
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
  final String? plotArea;
  final double? plotFront;
  final double? plotDepth;
  final String? nearestDepo;
  final double? distanceFromDetp;
  final String? typeOfTradeArea;
  final String? isThisDealerSite;
  final String? whatOtherBusiness;
  final String? howInvolveDealerInPetrol;
  final String? isDealerSole;
  final String? isDealerReadyToCapitalInvestment;
  final String? proposedSiteName1;
  final String? whyDoesTaj;
  final double? managerCurrentSalary;
  final String? isAgreeToTGPLStandard;
  final String? addDate;
  final String? editDate;
  final String? addBy;
  final String? editBy;
  final String? entryCode;
  final String? source;
  final String? sourceName;
  final String? priority;
  final String? platform;
  final int? statusId;
  final int? siteNumber;
  final int? estimateDailyDieselSale;
  final int? estimateDailySuperSale;
  final int? estimateLubricantSale;
  final int? expectedLeaseRentPerManth;
  final String? nflFacilityAvailable;
  final String? nflFacilityName;
  final int? truckCount;
  final int? carCount;
  final int? bikeCount;
  final int? busCount;
  final String? npPersonName;
  final String? joiningFees;
  final String? topography;
  final String? dcNoc;
  final String? explosive;
  final String? amendmentExplosive;
  final String? appliedInExplosive;
  final String? aeConstructionApproval;
  final String? aeSafetyCompletion;
  final String? aeKForm;
  final String? aeAmendment;
  final String? aeConstructionStart;
  final String? aeConstructionUpdate;
  final String? hoto;
  final String? lastStep;
  final String? ssRecommendationTmName;
  final String? ssTmRecommendation;
  final String? ssTmRemarks;
  final String? ssRecommendationRmName;
  final String? ssRmRecommendation;
  final String? ssRmRemarks;
  final String? ttRecommendationTmName;
  final String? ttTmRecommendation;
  final String? ttTmRemarks;
  final String? ttRecommendationRmName;
  final String? ttRmRecommendation;
  final String? ttRmRemarks;
  final String? truckKCount;
  final int? siteStatusId;
  final String? drawingLayout;
  final String? issuanceOfDrawings;
  final String? changeStatusRemarks;
  final String? constructionStartDate;
  final String? constructionEndDate;
  final int? constructionStatusInPercent;
  final int? constructionDone;
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
  final int? inaugurationDone;
  final int? numberOfOperationYear;
  final String? trucPortPotentail;
  final String? salamMartPotential;
  final String? resturantPotential;
  final String? isThisConversionPump;
  final String? currentOMCName;
  final String? isThisDealerInvestedSite;
  final String? isCurrentlyOperational;
  final String? currentLeaseExpried;
  final int? dieselUGTSizeLiter;
  final int? superUGTSizeLiter;
  final int? numberOfDieselDispenser;
  final int? numberOfSuperDispenser;
  final String? currentlyCanopyCondition;
  final String? conditionOfDispensors;
  final String? conditionOfForecourt;
  final String? recommendation;
  final String? recommendationDetail;
  final String? negotiationStatus;
  final String? finalDecisionStatus;
  final String? mouSignOff;
  final String? leaseAgreement;
  final String? franchiseAgreement;
  final String? capex;
  final bool? success;
  final String? message;
  final int? recordId;
  final int? accessLevel;

  ApplicationModel({
    this.id,
    this.applicationId,
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
    this.plotArea,
    this.plotFront,
    this.plotDepth,
    this.nearestDepo,
    this.distanceFromDetp,
    this.typeOfTradeArea,
    this.isThisDealerSite,
    this.whatOtherBusiness,
    this.howInvolveDealerInPetrol,
    this.isDealerSole,
    this.isDealerReadyToCapitalInvestment,
    this.proposedSiteName1,
    this.whyDoesTaj,
    this.managerCurrentSalary,
    this.isAgreeToTGPLStandard,
    this.addDate,
    this.editDate,
    this.addBy,
    this.editBy,
    this.entryCode,
    this.source,
    this.sourceName,
    this.priority,
    this.platform,
    this.statusId,
    this.siteNumber,
    this.estimateDailyDieselSale,
    this.estimateDailySuperSale,
    this.estimateLubricantSale,
    this.expectedLeaseRentPerManth,
    this.nflFacilityAvailable,
    this.nflFacilityName,
    this.truckCount,
    this.carCount,
    this.bikeCount,
    this.busCount,
    this.npPersonName,
    this.joiningFees,
    this.topography,
    this.dcNoc,
    this.explosive,
    this.amendmentExplosive,
    this.appliedInExplosive,
    this.aeConstructionApproval,
    this.aeSafetyCompletion,
    this.aeKForm,
    this.aeAmendment,
    this.aeConstructionStart,
    this.aeConstructionUpdate,
    this.hoto,
    this.lastStep,
    this.ssRecommendationTmName,
    this.ssTmRecommendation,
    this.ssTmRemarks,
    this.ssRecommendationRmName,
    this.ssRmRecommendation,
    this.ssRmRemarks,
    this.ttRecommendationTmName,
    this.ttTmRecommendation,
    this.ttTmRemarks,
    this.ttRecommendationRmName,
    this.ttRmRecommendation,
    this.ttRmRemarks,
    this.truckKCount,
    this.siteStatusId,
    this.drawingLayout,
    this.issuanceOfDrawings,
    this.changeStatusRemarks,
    this.constructionStartDate,
    this.constructionEndDate,
    this.constructionStatusInPercent,
    this.constructionDone,
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
    this.inaugurationDone,
    this.numberOfOperationYear,
    this.trucPortPotentail,
    this.salamMartPotential,
    this.resturantPotential,
    this.isThisConversionPump,
    this.currentOMCName,
    this.isThisDealerInvestedSite,
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
    this.mouSignOff,
    this.leaseAgreement,
    this.franchiseAgreement,
    this.capex,
    this.success,
    this.message,
    this.recordId,
    this.accessLevel,
    this.siteStatusName,
    this.nearbyTrafficSites = const [],
  });

  factory ApplicationModel.fromAPIResponseMap(Map<String, dynamic> json) {
    return ApplicationModel(
      applicationId: json['ApplicationId'],
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
      plotArea: json['PlotArea'],
      plotFront: json['PlotFront']?.toDouble(),
      plotDepth: json['PlotDepth']?.toDouble(),
      nearestDepo: json['NearestDepo'],
      distanceFromDetp: json['DistanceFromDetp']?.toDouble(),
      typeOfTradeArea: json['TypeOfTradeArea'],
      isThisDealerSite: json['IsThisDealerSite'],
      whatOtherBusiness: json['WhatOtherBusiness'],
      howInvolveDealerInPetrol: json['HowInvolveDealerInPetrol'],
      isDealerSole: json['IsDealerSole'],
      isDealerReadyToCapitalInvestment:
          json['IsDealerReadyToCapitalInvestment'],
      proposedSiteName1: json['ProposedSiteName1'],
      whyDoesTaj: json['WhyDoesTaj'],
      managerCurrentSalary: json['ManagerCurrentSalary']?.toDouble(),
      isAgreeToTGPLStandard: json['IsAgreeToTGPLStandard'],
      addDate: json['AddDate'],
      editDate: json['EditDate'],
      addBy: json['AddBy'],
      editBy: json['EditBy'],
      entryCode: json['EntryCode'],
      source: json['Source'],
      sourceName: json['SourceName'],
      priority: json['Priority'],
      platform: json['PlatForm'],
      statusId: json['StatusId'],
      siteNumber: json['sitenumber'],
      estimateDailyDieselSale: json['EstimateDailyDieselSale'],
      estimateDailySuperSale: json['EstimateDailySuperSale'],
      estimateLubricantSale: json['EstimateLubricantSale'],
      expectedLeaseRentPerManth: json['ExpectedLeaseRentPerManth'],
      nflFacilityAvailable: json['NFLFacilityAvailable'],
      nflFacilityName: json['NFLFacilityName'],
      truckCount: json['TruckCount'],
      carCount: json['CarCount'],
      bikeCount: json['BikeCount'],
      busCount: json['BusCount'],
      npPersonName: json['NPPersonName'],
      joiningFees: json['JoiningFees'],
      topography: json['Topography'],
      dcNoc: json['DCNOC'],
      explosive: json['Explosive'],
      amendmentExplosive: json['AmendmentExplosive'],
      appliedInExplosive: json['AppliedInexplosive'],
      aeConstructionApproval: json['AE_ConstructionApproval'],
      aeSafetyCompletion: json['AE_SaftyCompletion'],
      aeKForm: json['AE_KForm'],
      aeAmendment: json['AE_Amendment'],
      aeConstructionStart: json['AE_ConstructionStart'],
      aeConstructionUpdate: json['AE_ConstructionUpdate'],
      hoto: json['HOTO'],
      lastStep: json['LastStep'],
      ssRecommendationTmName: json['SSRecommendationTMName'],
      ssTmRecommendation: json['SSTMRecommendation'],
      ssTmRemarks: json['SSTMRemarks'],
      ssRecommendationRmName: json['SSRecommendationRMName'],
      ssRmRecommendation: json['SSRMRecommendation'],
      ssRmRemarks: json['SSRMRemarks'],
      ttRecommendationTmName: json['TTRecommendationTMName'],
      ttTmRecommendation: json['TTTMRecommendation'],
      ttTmRemarks: json['TTTMRemarks'],
      ttRecommendationRmName: json['TTRecommendationRMName'],
      ttRmRecommendation: json['TTRMRecommendation'],
      ttRmRemarks: json['TTRMRemarks'],
      truckKCount: json['TrucKCount']?.toString(),
      siteStatusId: json['SiteStatusId'],
      drawingLayout: json['DrawingLayout'],
      issuanceOfDrawings: json['IssuanceOfDrawings'],
      changeStatusRemarks: json['ChangeStatusRemarks'],
      constructionStartDate: json['ConstructionStartDate'],
      constructionEndDate: json['ConstructionEndDate'],
      constructionStatusInPercent: json['ConstructionStatusInPercent'],
      constructionDone: json['ConstructionDone'],
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
      inaugurationDone: json['InaugurationDone'],
      numberOfOperationYear: json['NumberOfOperationYear'],
      trucPortPotentail: json['TrucPortPotentail'],
      salamMartPotential: json['SalamMartPotential'],
      resturantPotential: json['ResturantPotential'],
      isThisConversionPump: json['IsThisConversionPump'],
      currentOMCName: json['CurrentOMCName'],
      isThisDealerInvestedSite: json['IsThisDealerInvestedSite'],
      isCurrentlyOperational: json['IsCurrentlyOperational'],
      currentLeaseExpried: json['CurrentLeaseExpried'],
      dieselUGTSizeLiter: json['DieselUGTSizeLiter'],
      superUGTSizeLiter: json['SuperUGTSizeLiter'],
      numberOfDieselDispenser: json['NumberOfDieselDispenser'],
      numberOfSuperDispenser: json['NumberOfSuperDispenser'],
      currentlyCanopyCondition: json['CurrentlyCanopyCondition'],
      conditionOfDispensors: json['ConditionOfDispensors'],
      conditionOfForecourt: json['ConditionOfForecourt'],
      recommendation: json['Recommendation'],
      recommendationDetail: json['RecommendationDetail'],
      negotiationStatus: json['NegotiationStatus'],
      finalDecisionStatus: json['FinalDecisionStatus'],
      mouSignOff: json['MoUSignOff'],
      leaseAgreement: json['LeaseAgreement'],
      franchiseAgreement: json['FranchiseAgreement'],
      capex: json['Capex'],
      success: json['Success'],
      message: json['Message'],
      recordId: json['RecordId'],
      accessLevel: json['AccessLevel'],
    );
  }

  factory ApplicationModel.fromDatabaseMap(Map<String, dynamic> map, {
  List<TrafficTradesModel>? nearbyTrafficSites,
}) {
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
      plotArea: map['plotArea'],
      plotFront: map['plotFront'],
      plotDepth: map['plotDepth'],
      nearestDepo: map['nearestDepo'],
      distanceFromDetp: map['distanceFromDetp'],
      typeOfTradeArea: map['typeOfTradeArea'],
      isThisDealerSite: map['isThisDealerSite'],
      whatOtherBusiness: map['whatOtherBusiness'],
      howInvolveDealerInPetrol: map['howInvolveDealerInPetrol'],
      isDealerSole: map['isDealerSole'],
      isDealerReadyToCapitalInvestment: map['isDealerReadyToCapitalInvestment'],
      proposedSiteName1: map['proposedSiteName1'],
      whyDoesTaj: map['whyDoesTaj'],
      managerCurrentSalary: map['managerCurrentSalary'],
      isAgreeToTGPLStandard: map['isAgreeToTGPLStandard'],
      addDate: map['addDate'],
      editDate: map['editDate'],
      addBy: map['addBy'],
      editBy: map['editBy'],
      entryCode: map['entryCode'],
      source: map['source'],
      sourceName: map['sourceName'],
      priority: map['priority'],
      platform: map['platform'],
      statusId: map['statusId'],
      siteNumber: map['siteNumber'],
      estimateDailyDieselSale: map['estimateDailyDieselSale'],
      estimateDailySuperSale: map['estimateDailySuperSale'],
      estimateLubricantSale: map['estimateLubricantSale'],
      expectedLeaseRentPerManth: map['expectedLeaseRentPerManth'],
      nflFacilityAvailable: map['nflFacilityAvailable'],
      nflFacilityName: map['nflFacilityName'],
      truckCount: map['truckCount'],
      carCount: map['carCount'],
      bikeCount: map['bikeCount'],
      busCount: map['busCount'],
      npPersonName: map['npPersonName'],
      joiningFees: map['joiningFees'],
      topography: map['topography'],
      dcNoc: map['dcNoc'],
      explosive: map['explosive'],
      amendmentExplosive: map['amendmentExplosive'],
      appliedInExplosive: map['appliedInExplosive'],
      aeConstructionApproval: map['aeConstructionApproval'],
      aeSafetyCompletion: map['aeSafetyCompletion'],
      aeKForm: map['aeKForm'],
      aeAmendment: map['aeAmendment'],
      aeConstructionStart: map['aeConstructionStart'],
      aeConstructionUpdate: map['aeConstructionUpdate'],
      hoto: map['hoto'],
      lastStep: map['lastStep'],
      ssRecommendationTmName: map['ssRecommendationTmName'],
      ssTmRecommendation: map['ssTmRecommendation'],
      ssTmRemarks: map['ssTmRemarks'],
      ssRecommendationRmName: map['ssRecommendationRmName'],
      ssRmRecommendation: map['ssRmRecommendation'],
      ssRmRemarks: map['ssRmRemarks'],
      ttRecommendationTmName: map['ttRecommendationTmName'],
      ttTmRecommendation: map['ttTmRecommendation'],
      ttTmRemarks: map['ttTmRemarks'],
      ttRecommendationRmName: map['ttRecommendationRmName'],
      ttRmRecommendation: map['ttRmRecommendation'],
      ttRmRemarks: map['ttRmRemarks'],
      truckKCount: map['truckKCount'],
      siteStatusId: map['siteStatusId'],
      drawingLayout: map['drawingLayout'],
      issuanceOfDrawings: map['issuanceOfDrawings'],
      changeStatusRemarks: map['changeStatusRemarks'],
      constructionStartDate: map['constructionStartDate'],
      constructionEndDate: map['constructionEndDate'],
      constructionStatusInPercent: map['constructionStatusInPercent'],
      constructionDone: map['constructionDone'],
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
      inaugurationDone: map['inaugurationDone'],
      numberOfOperationYear: map['numberOfOperationYear'],
      trucPortPotentail: map['trucPortPotentail'],
      salamMartPotential: map['salamMartPotential'],
      resturantPotential: map['resturantPotential'],
      isThisConversionPump: map['isThisConversionPump'],
      currentOMCName: map['currentOMCName'],
      isThisDealerInvestedSite: map['isThisDealerInvestedSite'],
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
      mouSignOff: map['mouSignOff'],
      leaseAgreement: map['leaseAgreement'],
      franchiseAgreement: map['franchiseAgreement'],
      capex: map['capex'],
      success: map['success'] == 1,
      message: map['message'],
      recordId: map['recordId'],
      accessLevel: map['accessLevel'],
      siteStatusName: map['siteStatusName'],
    nearbyTrafficSites: nearbyTrafficSites ?? [],
    );
  }

  Map<String, dynamic> toDatabaseMap() {
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
      'plotArea': plotArea,
      'plotFront': plotFront,
      'plotDepth': plotDepth,
      'nearestDepo': nearestDepo,
      'distanceFromDetp': distanceFromDetp,
      'typeOfTradeArea': typeOfTradeArea,
      'isThisDealerSite': isThisDealerSite,
      'whatOtherBusiness': whatOtherBusiness,
      'howInvolveDealerInPetrol': howInvolveDealerInPetrol,
      'isDealerSole': isDealerSole,
      'isDealerReadyToCapitalInvestment': isDealerReadyToCapitalInvestment,
      'proposedSiteName1': proposedSiteName1,
      'whyDoesTaj': whyDoesTaj,
      'managerCurrentSalary': managerCurrentSalary,
      'isAgreeToTGPLStandard': isAgreeToTGPLStandard,
      'addDate': addDate,
      'editDate': editDate,
      'addBy': addBy,
      'editBy': editBy,
      'entryCode': entryCode,
      'source': source,
      'sourceName': sourceName,
      'priority': priority,
      'platform': platform,
      'statusId': statusId,
      'siteNumber': siteNumber,
      'estimateDailyDieselSale': estimateDailyDieselSale,
      'estimateDailySuperSale': estimateDailySuperSale,
      'estimateLubricantSale': estimateLubricantSale,
      'expectedLeaseRentPerManth': expectedLeaseRentPerManth,
      'nflFacilityAvailable': nflFacilityAvailable,
      'nflFacilityName': nflFacilityName,
      'truckCount': truckCount,
      'carCount': carCount,
      'bikeCount': bikeCount,
      'busCount': busCount,
      'npPersonName': npPersonName,
      'joiningFees': joiningFees,
      'topography': topography,
      'dcNoc': dcNoc,
      'explosive': explosive,
      'amendmentExplosive': amendmentExplosive,
      'appliedInExplosive': appliedInExplosive,
      'aeConstructionApproval': aeConstructionApproval,
      'aeSafetyCompletion': aeSafetyCompletion,
      'aeKForm': aeKForm,
      'aeAmendment': aeAmendment,
      'aeConstructionStart': aeConstructionStart,
      'aeConstructionUpdate': aeConstructionUpdate,
      'hoto': hoto,
      'lastStep': lastStep,
      'ssRecommendationTmName': ssRecommendationTmName,
      'ssTmRecommendation': ssTmRecommendation,
      'ssTmRemarks': ssTmRemarks,
      'ssRecommendationRmName': ssRecommendationRmName,
      'ssRmRecommendation': ssRmRecommendation,
      'ssRmRemarks': ssRmRemarks,
      'ttRecommendationTmName': ttRecommendationTmName,
      'ttTmRecommendation': ttTmRecommendation,
      'ttTmRemarks': ttTmRemarks,
      'ttRecommendationRmName': ttRecommendationRmName,
      'ttRmRecommendation': ttRmRecommendation,
      'ttRmRemarks': ttRmRemarks,
      'truckKCount': truckKCount,
      'siteStatusId': siteStatusId,
      'drawingLayout': drawingLayout,
      'issuanceOfDrawings': issuanceOfDrawings,
      'changeStatusRemarks': changeStatusRemarks,
      'constructionStartDate': constructionStartDate,
      'constructionEndDate': constructionEndDate,
      'constructionStatusInPercent': constructionStatusInPercent,
      'constructionDone': constructionDone,
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
      'inaugurationDone': inaugurationDone,
      'numberOfOperationYear': numberOfOperationYear,
      'trucPortPotentail': trucPortPotentail,
      'salamMartPotential': salamMartPotential,
      'resturantPotential': resturantPotential,
      'isThisConversionPump': isThisConversionPump,
      'currentOMCName': currentOMCName,
      'isThisDealerInvestedSite': isThisDealerInvestedSite,
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
      'mouSignOff': mouSignOff,
      'leaseAgreement': leaseAgreement,
      'franchiseAgreement': franchiseAgreement,
      'capex': capex,
      'success': success == true ? 1 : 0,
      'message': message,
      'recordId': recordId,
      'accessLevel': accessLevel,
    };
  }

  static (List<String>, List<dynamic>) getWhereClauseAndArgs(
    FilterSelectionState filters) {
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
          final statusIds = filters.selectedStatusId!
              .split(",")
              .map((e) => int.tryParse(e.trim()) ?? 0)
              .toList();
          final placeholders = List.filled(statusIds.length, '?').join(', ');
          whereConditions.add('$alias.statusId IN ($placeholders)');
          whereArgs.addAll(statusIds);
        } else {
          whereConditions.add('$alias.statusId = ?');
          whereArgs.add(int.tryParse(filters.selectedStatusId!) ?? 0);
        }
      }

      if (!filters.applicationId.isNullOrEmpty) {
        whereConditions.add('$alias.applicationId = ?');
        whereArgs.add(int.tryParse(filters.applicationId!) ?? 0);
      }

      if (!filters.entryCode.isNullOrEmpty) {
        whereConditions.add('$alias.entryCode LIKE ?');
        whereArgs.add('%${filters.entryCode}%');
      }

      if (!filters.preparedBy.isNullOrEmpty) {
        whereConditions.add('$alias.preparedBy LIKE ?');
        whereArgs.add('%${filters.preparedBy}%');
      }

      if (!filters.district.isNullOrEmpty) {
        whereConditions.add('$alias.district LIKE ?');
        whereArgs.add('%${filters.district}%');
      }

      if (!filters.dealerName.isNullOrEmpty) {
        whereConditions.add('$alias.dealerName LIKE ?');
        whereArgs.add('%${filters.dealerName}%');
      }

      if (!filters.dealerContact.isNullOrEmpty) {
        whereConditions.add('$alias.dealerContact LIKE ?');
        whereArgs.add('%${filters.dealerContact}%');
      }

      if (!filters.address.isNullOrEmpty) {
        whereConditions.add('$alias.locationAddress LIKE ?');
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
        whereConditions.add('$alias.surveyDealerProfileDone = ?');
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
        whereConditions.add('$alias.mouSignOffDone = ?');
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
        whereConditions.add('$alias.feasibilityFinalizationDone = ?');
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
        whereConditions.add('$alias.issuanceOfDrawingsDone = ?');
        whereArgs.add(filters.issuanceOfDrawing!.value);
      }

      if (filters.appliedInExplosive != null) {
        whereConditions.add('$alias.appliedInExplosiveDone = ?');
        whereArgs.add(filters.appliedInExplosive!.value);
      }

      if (filters.dcNoc != null) {
        whereConditions.add('$alias.dcNocDone = ?');
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

      // TODO: addDate is updated when some one change application data on Server.
      // Date filters
      if (filters.fromDate.isValidDate() && filters.toDate.isValidDate()) {
        whereConditions.add('$alias.addDate BETWEEN ? AND ?');
        whereArgs.add(filters.fromDate?.formatFromDDMMYYYToIsoDate());
        whereArgs.add(filters.toDate?.formatFromDDMMYYYToIsoDate());
      } else if (filters.fromDate.isValidDate()) {
        whereConditions.add('$alias.addDate >= ?');
        whereArgs.add(filters.fromDate?.formatFromDDMMYYYToIsoDate());
      } else if (filters.toDate.isValidDate()) {
        whereConditions.add('$alias.addDate <= ?');
        whereArgs.add(filters.toDate?.formatFromDDMMYYYToIsoDate());
      }

      if (filters.condDate.isValidDate()) {
        whereConditions.add('$alias.dateConducted = ?');
        whereArgs.add(filters.condDate?.formatFromDDMMYYYToIsoDate());
      }
    }

    return (whereConditions, whereArgs);
  }
}
