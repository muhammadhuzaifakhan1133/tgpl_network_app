import 'package:tgpl_network/utils/nullable_fields_helper.dart';
import 'package:tgpl_network/common/models/yes_no_enum_with_extension.dart';

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
    List<String>? fieldsToNull,
  }) {
    return FilterSelectionState(
      selectedPriority: fieldsToNull.apply('selectedPriority', selectedPriority, this.selectedPriority),
      selectedCity: fieldsToNull.apply('selectedCity', selectedCity, this.selectedCity),
      selectedStatus: fieldsToNull.apply('selectedStatus', selectedStatus, this.selectedStatus),
      surveyProfile: fieldsToNull.apply('surveyProfile', surveyProfile, this.surveyProfile),
      trafficTrade: fieldsToNull.apply('trafficTrade', trafficTrade, this.trafficTrade),
      feasibility: fieldsToNull.apply('feasibility', feasibility, this.feasibility),
      negotiation: fieldsToNull.apply('negotiation', negotiation, this.negotiation),
      mouSign: fieldsToNull.apply('mouSign', mouSign, this.mouSign),
      joiningFee: fieldsToNull.apply('joiningFee', joiningFee, this.joiningFee),
      franchiseAgreement: fieldsToNull.apply('franchiseAgreement', franchiseAgreement, this.franchiseAgreement),
      feasibilityFinalization: fieldsToNull.apply('feasibilityFinalization', feasibilityFinalization, this.feasibilityFinalization),
      explosiveLayout: fieldsToNull.apply('explosiveLayout', explosiveLayout, this.explosiveLayout),
      drawing: fieldsToNull.apply('drawing', drawing, this.drawing),
      topography: fieldsToNull.apply('topography', topography, this.topography),
      issuanceOfDrawing: fieldsToNull.apply('issuanceOfDrawing', issuanceOfDrawing, this.issuanceOfDrawing),
      appliedInExplosive: fieldsToNull.apply('appliedInExplosive', appliedInExplosive, this.appliedInExplosive),
      dcNoc: fieldsToNull.apply('dcNoc', dcNoc, this.dcNoc),
      capex: fieldsToNull.apply('capex', capex, this.capex),
      leaseAgreement: fieldsToNull.apply('leaseAgreement', leaseAgreement, this.leaseAgreement),
      hoto: fieldsToNull.apply('hoto', hoto, this.hoto),
      construction: fieldsToNull.apply('construction', construction, this.construction),
      inauguration: fieldsToNull.apply('inauguration', inauguration, this.inauguration),
      fromDate: fieldsToNull.apply('fromDate', fromDate, this.fromDate),
      toDate: fieldsToNull.apply('toDate', toDate, this.toDate),
      receiveDate: fieldsToNull.apply('receiveDate', receiveDate, this.receiveDate),
      condDate: fieldsToNull.apply('condDate', condDate, this.condDate),
      applicationId: fieldsToNull.apply('applicationId', applicationId, this.applicationId),
      entryCode: fieldsToNull.apply('entryCode', entryCode, this.entryCode),
      preparedBy: fieldsToNull.apply('preparedBy', preparedBy, this.preparedBy),
      district: fieldsToNull.apply('district', district, this.district),
      dealerName: fieldsToNull.apply('dealerName', dealerName, this.dealerName),
      dealerContact: fieldsToNull.apply('dealerContact', dealerContact, this.dealerContact),
      address: fieldsToNull.apply('address', address, this.address),
      referredBy: fieldsToNull.apply('referredBy', referredBy, this.referredBy),
      source: fieldsToNull.apply('source', source, this.source),
      sourceName: fieldsToNull.apply('sourceName', sourceName, this.sourceName),
      siteName: fieldsToNull.apply('siteName', siteName, this.siteName),
    );
  }

  bool get hasActiveFilters {
    return selectedPriority != null ||
        selectedCity != null ||
        selectedStatus != null ||
        surveyProfile != null ||
        trafficTrade != null ||
        feasibility != null ||
        negotiation != null ||
        mouSign != null ||
        joiningFee != null ||
        franchiseAgreement != null ||
        feasibilityFinalization != null ||
        explosiveLayout != null ||
        drawing != null ||
        topography != null ||
        issuanceOfDrawing != null ||
        appliedInExplosive != null ||
        dcNoc != null ||
        capex != null ||
        leaseAgreement != null ||
        hoto != null ||
        construction != null ||
        inauguration != null ||
        fromDate != null ||
        toDate != null ||
        receiveDate != null ||
        condDate != null ||
        applicationId != null ||
        entryCode != null ||
        preparedBy != null ||
        district != null ||
        dealerName != null ||
        dealerContact != null ||
        address != null ||
        referredBy != null ||
        source != null ||
        sourceName != null ||
        siteName != null;
  }
}
