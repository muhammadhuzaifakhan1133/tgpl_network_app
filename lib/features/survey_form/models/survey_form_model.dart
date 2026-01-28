class SurveyFormModel {
  // Application Info
  final String? applicantId;
  final String? entryCode;
  final String? dateConducted;
  final String? conductedBy;
  final String? googleLocation;
  final String? city;
  final String? district;
  final String? siteStatus;
  final String? npName;
  final String? source;
  final String? sourceName;
  final String? priority;

  // Contact & Dealer
  final String? dealerName;
  final String? dealerContact;
  final String? referenceBy;
  final String? locationAddress;
  final String? landmark;
  final String? plotFront;
  final String? plotDepth;
  final String? plotArea;
  final String? nearestDepo;
  final String? distanceFromDepo;
  final String? typeOfTradeArea;

  // Dealer Profile
  final String? isThisDealer;
  final String? dealerPlatform;
  final String? dealerBusinesses;
  final String? dealerInvolvement;
  final String? isDealerReadyToInvest;
  final String? dealerOpinion;
  final String? monthlySalary;
  final String? isDealerAgreedToFollowTgplStandards;

  // Recommendations
  final String? selectedTM;
  final String? tmRecommendation;
  final String? tmRemarks;
  final String? selectedRM;
  final String? rmRecommendation;
  final String? rmRemarks;

  const SurveyFormModel({
    this.applicantId,
    this.entryCode,
    this.dateConducted,
    this.conductedBy,
    this.googleLocation,
    this.city,
    this.district,
    this.siteStatus,
    this.npName,
    this.source,
    this.sourceName,
    this.priority,
    this.dealerName,
    this.dealerContact,
    this.referenceBy,
    this.locationAddress,
    this.landmark,
    this.plotFront,
    this.plotDepth,
    this.plotArea,
    this.nearestDepo,
    this.distanceFromDepo,
    this.typeOfTradeArea,
    this.isThisDealer,
    this.dealerPlatform,
    this.dealerBusinesses,
    this.dealerInvolvement,
    this.isDealerReadyToInvest,
    this.dealerOpinion,
    this.monthlySalary,
    this.isDealerAgreedToFollowTgplStandards,
    this.selectedTM,
    this.tmRecommendation,
    this.tmRemarks,
    this.selectedRM,
    this.rmRecommendation,
    this.rmRemarks,
  });

  Map<String, dynamic> toDatabaseMap() {
    return {
      'applicantId': applicantId,
      'entryCode': entryCode,
      'dateConducted': dateConducted,
      'conductedBy': conductedBy,
      'googleLocation': googleLocation,
      'city': city,
      'district': district,
      'siteStatus': siteStatus,
      'npName': npName,
      'source': source,
      'sourceName': sourceName,
      'priority': priority,
      'dealerName': dealerName,
      'dealerContact': dealerContact,
      'referenceBy': referenceBy,
      'locationAddress': locationAddress,
      'landmark': landmark,
      'plotFront': plotFront,
      'plotDepth': plotDepth,
      'plotArea': plotArea,
      'nearestDepo': nearestDepo,
      'distanceFromDepo': distanceFromDepo,
      'typeOfTradeArea': typeOfTradeArea,
      'isThisDealer': isThisDealer,
      'dealerPlatform': dealerPlatform,
      'dealerBusinesses': dealerBusinesses,
      'dealerInvolvement': dealerInvolvement,
      'isDealerReadyToInvest': isDealerReadyToInvest,
      'dealerOpinion': dealerOpinion,
      'monthlySalary': monthlySalary,
      'isDealerAgreedToFollowTgplStandards':
          isDealerAgreedToFollowTgplStandards,
      'selectedTM': selectedTM,
      'tmRecommendation': tmRecommendation,
      'tmRemarks': tmRemarks,
      'selectedRM': selectedRM,
      'rmRecommendation': rmRecommendation,
      'rmRemarks': rmRemarks,
    };
  }

  Map<String, dynamic> toApiMap() {
    return {
      "dateConducted": dateConducted,
      "googleLocation": googleLocation,
      "cityName": city,
      "district": district,
      "siteStatus": siteStatus,
      "npName": npName,
      "source": source,
      "sourceName": sourceName,
      "priority": priority,
      "dealerName": dealerName,
      "dealerContact": dealerContact,
      "referenceBy": referenceBy,
      "locationAddress": locationAddress,
      "landmark": landmark,
      "plotFront": plotFront,
      "plotDepth": plotDepth,
      "nearestDepo": nearestDepo,
      "distanceFromDepo": distanceFromDepo,
      "typeOfTradeArea": typeOfTradeArea,
      "isThisDealer": isThisDealer,
      "dealerPlatform": dealerPlatform,
      "dealerBusinesses": dealerBusinesses,
      "dealerInvolvement": dealerInvolvement,
      "isDealerReadyToInvest": isDealerReadyToInvest,
      "dealerOpinion": dealerOpinion,
      "monthlySalary": monthlySalary,
      "isDealerAgreedToFollowTgplStandards":
          isDealerAgreedToFollowTgplStandards,
      "selectedTM": selectedTM,
      "tmRecommendation": tmRecommendation,
      "tmRemarks": tmRemarks,
      "selectedRM": selectedRM,
      "rmRecommendation": rmRecommendation,
      "rmRemarks": rmRemarks,
    };
  }

  factory SurveyFormModel.fromDatabaseMap(Map<String, dynamic> json) {
    return SurveyFormModel(
      applicantId: json['applicantId'] as String?,
      entryCode: json['entryCode'] as String?,
      dateConducted: json['dateConducted'] as String?,
      conductedBy: json['conductedBy'] as String?,
      googleLocation: json['googleLocation'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      siteStatus: json['siteStatus'] as String?,
      npName: json['npName'] as String?,
      source: json['source'] as String?,
      sourceName: json['sourceName'] as String?,
      priority: json['priority'] as String?,
      dealerName: json['dealerName'] as String?,
      dealerContact: json['dealerContact'] as String?,
      referenceBy: json['referenceBy'] as String?,
      locationAddress: json['locationAddress'] as String?,
      landmark: json['landmark'] as String?,
      plotFront: json['plotFront'] as String?,
      plotDepth: json['plotDepth'] as String?,
      plotArea: json['plotArea'] as String?,
      nearestDepo: json['nearestDepo'] as String?,
      distanceFromDepo: json['distanceFromDepo'] as String?,
      typeOfTradeArea: json['typeOfTradeArea'] as String?,
      isThisDealer: json['isThisDealer'] as String?,
      dealerPlatform: json['dealerPlatform'] as String?,
      dealerBusinesses: json['dealerBusinesses'] as String?,
      dealerInvolvement: json['dealerInvolvement'] as String?,
      isDealerReadyToInvest: json['isDealerReadyToInvest'] as String?,
      dealerOpinion: json['dealerOpinion'] as String?,
      monthlySalary: json['monthlySalary'] as String?,
      isDealerAgreedToFollowTgplStandards:
          json['isDealerAgreedToFollowTgplStandards'] as String?,
      selectedTM: json['selectedTM'] as String?,
      tmRecommendation: json['tmRecommendation'] as String?,
      tmRemarks: json['tmRemarks'] as String?,
      selectedRM: json['selectedRM'] as String?,
      rmRecommendation: json['rmRecommendation'] as String?,
      rmRemarks: json['rmRemarks'] as String?,
    );
  }

  SurveyFormModel copyWith({
    String? applicantId,
    String? entryCode,
    String? dateConducted,
    String? conductedBy,
    String? googleLocation,
    String? city,
    String? district,
    String? siteStatus,
    String? npName,
    String? source,
    String? sourceName,
    String? priority,
    String? dealerName,
    String? dealerContact,
    String? referenceBy,
    String? locationAddress,
    String? landmark,
    String? plotFront,
    String? plotDepth,
    String? plotArea,
    String? nearestDepo,
    String? distanceFromDepo,
    String? typeOfTradeArea,
    String? isThisDealer,
    String? dealerPlatform,
    String? dealerBusinesses,
    String? dealerInvolvement,
    String? isDealerReadyToInvest,
    String? dealerOpinion,
    String? monthlySalary,
    String? isDealerAgreedToFollowTgplStandards,
    String? selectedTM,
    String? tmRecommendation,
    String? tmRemarks,
    String? selectedRM,
    String? rmRecommendation,
    String? rmRemarks,
  }) {
    return SurveyFormModel(
      applicantId: applicantId ?? this.applicantId,
      entryCode: entryCode ?? this.entryCode,
      dateConducted: dateConducted ?? this.dateConducted,
      conductedBy: conductedBy ?? this.conductedBy,
      googleLocation: googleLocation ?? this.googleLocation,
      city: city ?? this.city,
      district: district ?? this.district,
      siteStatus: siteStatus ?? this.siteStatus,
      npName: npName ?? this.npName,
      source: source ?? this.source,
      sourceName: sourceName ?? this.sourceName,
      priority: priority ?? this.priority,
      dealerName: dealerName ?? this.dealerName,
      dealerContact: dealerContact ?? this.dealerContact,
      referenceBy: referenceBy ?? this.referenceBy,
      locationAddress: locationAddress ?? this.locationAddress,
      landmark: landmark ?? this.landmark,
      plotFront: plotFront ?? this.plotFront,
      plotDepth: plotDepth ?? this.plotDepth,
      plotArea: plotArea ?? this.plotArea,
      nearestDepo: nearestDepo ?? this.nearestDepo,
      distanceFromDepo: distanceFromDepo ?? this.distanceFromDepo,
      typeOfTradeArea: typeOfTradeArea ?? this.typeOfTradeArea,
      isThisDealer: isThisDealer ?? this.isThisDealer,
      dealerPlatform: dealerPlatform ?? this.dealerPlatform,
      dealerBusinesses: dealerBusinesses ?? this.dealerBusinesses,
      dealerInvolvement: dealerInvolvement ?? this.dealerInvolvement,
      isDealerReadyToInvest:
          isDealerReadyToInvest ?? this.isDealerReadyToInvest,
      dealerOpinion: dealerOpinion ?? this.dealerOpinion,
      monthlySalary: monthlySalary ?? this.monthlySalary,
      isDealerAgreedToFollowTgplStandards:
          isDealerAgreedToFollowTgplStandards ??
          this.isDealerAgreedToFollowTgplStandards,
      selectedTM: selectedTM ?? this.selectedTM,
      tmRecommendation: tmRecommendation ?? this.tmRecommendation,
      tmRemarks: tmRemarks ?? this.tmRemarks,
      selectedRM: selectedRM ?? this.selectedRM,
      rmRecommendation: rmRecommendation ?? this.rmRecommendation,
      rmRemarks: rmRemarks ?? this.rmRemarks,
    );
  }

  @override
  String toString() {
    return 'SurveyFormModel(applicantId: $applicantId, entryCode: $entryCode, dateConducted: $dateConducted, conductedBy: $conductedBy, googleLocation: $googleLocation, city: $city, district: $district, siteStatus: $siteStatus, npName: $npName, source: $source, sourceName: $sourceName, priority: $priority, dealerName: $dealerName, dealerContact: $dealerContact, referenceBy: $referenceBy, locationAddress: $locationAddress, landmark: $landmark, plotFront: $plotFront, plotDepth: $plotDepth, plotArea: $plotArea, nearestDepo: $nearestDepo, distanceFromDepo: $distanceFromDepo, typeOfTradeArea: $typeOfTradeArea, isThisDealer: $isThisDealer, dealerPlatform: $dealerPlatform, dealerBusinesses: $dealerBusinesses, dealerInvolvement: $dealerInvolvement, isDealerReadyToInvest: $isDealerReadyToInvest, dealerOpinion: $dealerOpinion, monthlySalary: $monthlySalary, isDealerAgreedToFollowTgplStandards: $isDealerAgreedToFollowTgplStandards, selectedTM: $selectedTM, tmRecommendation: $tmRecommendation, tmRemarks: $tmRemarks, selectedRM: $selectedRM, rmRecommendation: $rmRecommendation, rmRemarks: $rmRemarks)';
  }

  String? get validate {
    // TODO: add validation logic
    return null;
  }
}
