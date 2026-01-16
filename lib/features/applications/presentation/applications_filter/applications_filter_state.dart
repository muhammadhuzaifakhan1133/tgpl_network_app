import 'package:tgpl_network/utils/yes_no_enum_with_extension.dart';

class FilterSelectionState {
  final String? selectedPriority;
  final String? selectedCity;
  final String? selectedStatus;

  final YesNo? surveyProfile;
  final YesNo? trafficTrade;
  final YesNo? feasibility;
  final YesNo? negotiation;
  final YesNo? mouSign;
  final YesNo? joiningFee;
  final YesNo? franchiseAgreement;
  final YesNo? feasibilityFinalization;
  final YesNo? explosiveLayout;
  final YesNo? drawing;
  final YesNo? topography;
  final YesNo? issuanceOfDrawing;
  final YesNo? appliedInExplosive;
  final YesNo? dcNoc;
  final YesNo? capex;
  final YesNo? leaseAgreement;
  final YesNo? hoto;
  final YesNo? construction;
  final YesNo? inauguration;

  final String? fromDate;
  final String? toDate;
  final String? receiveDate;
  final String? condDate;

  final String? applicationId;
  final String? entryCode;
  final String? preparedBy;
  final String? district;
  final String? dealerName;
  final String? dealerContact;
  final String? address;
  final String? referredBy;
  final String? source;
  final String? sourceName;
  final String? siteName;

  const FilterSelectionState({
    this.selectedPriority,
    this.selectedCity,
    this.selectedStatus,
    this.surveyProfile,
    this.trafficTrade,
    this.feasibility,
    this.negotiation,
    this.mouSign,
    this.joiningFee,
    this.franchiseAgreement,
    this.feasibilityFinalization,
    this.explosiveLayout,
    this.drawing,
    this.topography,
    this.issuanceOfDrawing,
    this.appliedInExplosive,
    this.dcNoc,
    this.capex,
    this.leaseAgreement,
    this.hoto,
    this.construction,
    this.inauguration,
    this.fromDate,
    this.toDate,
    this.receiveDate,
    this.condDate,
    this.applicationId,
    this.entryCode,
    this.preparedBy,
    this.district,
    this.dealerName,
    this.dealerContact,
    this.address,
    this.referredBy,
    this.source,
    this.sourceName,
    this.siteName,
  });

  FilterSelectionState copyWith({
    String? selectedPriority,
    String? selectedCity,
    String? selectedStatus,
    YesNo? surveyProfile,
    YesNo? trafficTrade,
    YesNo? feasibility,
    YesNo? negotiation,
    YesNo? mouSign,
    YesNo? joiningFee,
    YesNo? franchiseAgreement,
    YesNo? feasibilityFinalization,
    YesNo? explosiveLayout,
    YesNo? drawing,
    YesNo? topography,
    YesNo? issuanceOfDrawing,
    YesNo? appliedInExplosive,
    YesNo? dcNoc,
    YesNo? capex,
    YesNo? leaseAgreement,
    YesNo? hoto,
    YesNo? construction,
    YesNo? inauguration,
    String? fromDate,
    String? toDate,
    String? receiveDate,
    String? condDate,
    String? applicationId,
    String? entryCode,
    String? preparedBy,
    String? district,
    String? dealerName,
    String? dealerContact,
    String? address,
    String? referredBy,
    String? source,
    String? sourceName,
    String? siteName,
  }) {
    return FilterSelectionState(
      selectedPriority: selectedPriority ?? this.selectedPriority,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      surveyProfile: surveyProfile ?? this.surveyProfile,
      trafficTrade: trafficTrade ?? this.trafficTrade,
      feasibility: feasibility ?? this.feasibility,
      negotiation: negotiation ?? this.negotiation,
      mouSign: mouSign ?? this.mouSign,
      joiningFee: joiningFee ?? this.joiningFee,
      franchiseAgreement: franchiseAgreement ?? this.franchiseAgreement,
      feasibilityFinalization:
          feasibilityFinalization ?? this.feasibilityFinalization,
      explosiveLayout: explosiveLayout ?? this.explosiveLayout,
      drawing: drawing ?? this.drawing,
      topography: topography ?? this.topography,
      issuanceOfDrawing: issuanceOfDrawing ?? this.issuanceOfDrawing,
      appliedInExplosive: appliedInExplosive ?? this.appliedInExplosive,
      dcNoc: dcNoc ?? this.dcNoc,
      capex: capex ?? this.capex,
      leaseAgreement: leaseAgreement ?? this.leaseAgreement,
      hoto: hoto ?? this.hoto,
      construction: construction ?? this.construction,
      inauguration: inauguration ?? this.inauguration,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      receiveDate: receiveDate ?? this.receiveDate,
      condDate: condDate ?? this.condDate,
      applicationId: applicationId ?? this.applicationId,
      entryCode: entryCode ?? this.entryCode,
      preparedBy: preparedBy ?? this.preparedBy,
      district: district ?? this.district,
      dealerName: dealerName ?? this.dealerName,
      dealerContact: dealerContact ?? this.dealerContact,
      address: address ?? this.address,
      referredBy: referredBy ?? this.referredBy,
      source: source ?? this.source,
      sourceName: sourceName ?? this.sourceName,
      siteName: siteName ?? this.siteName,
    );
  }
}
