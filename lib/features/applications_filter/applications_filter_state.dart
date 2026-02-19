import 'package:tgpl_network/utils/extensions/nullable_fields_helper.dart';
import 'package:tgpl_network/common/models/yes_no_enum_with_extension.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';

class FilterSelectionState {
  final String? selectedPriority;
  final String? selectedCity;
  final String? selectedStatusId;

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
    this.selectedStatusId,
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
    String? selectedStatusId,
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
      selectedPriority: fieldsToNull.apply(
        'selectedPriority',
        selectedPriority,
        this.selectedPriority,
      ),
      selectedCity: fieldsToNull.apply(
        'selectedCity',
        selectedCity,
        this.selectedCity,
      ),
      selectedStatusId: fieldsToNull.apply(
        'selectedStatusId',
        selectedStatusId,
        this.selectedStatusId,
      ),
      surveyProfile: fieldsToNull.apply(
        'surveyProfile',
        surveyProfile,
        this.surveyProfile,
      ),
      trafficTrade: fieldsToNull.apply(
        'trafficTrade',
        trafficTrade,
        this.trafficTrade,
      ),
      feasibility: fieldsToNull.apply(
        'feasibility',
        feasibility,
        this.feasibility,
      ),
      negotiation: fieldsToNull.apply(
        'negotiation',
        negotiation,
        this.negotiation,
      ),
      mouSign: fieldsToNull.apply('mouSign', mouSign, this.mouSign),
      joiningFee: fieldsToNull.apply('joiningFee', joiningFee, this.joiningFee),
      franchiseAgreement: fieldsToNull.apply(
        'franchiseAgreement',
        franchiseAgreement,
        this.franchiseAgreement,
      ),
      feasibilityFinalization: fieldsToNull.apply(
        'feasibilityFinalization',
        feasibilityFinalization,
        this.feasibilityFinalization,
      ),
      explosiveLayout: fieldsToNull.apply(
        'explosiveLayout',
        explosiveLayout,
        this.explosiveLayout,
      ),
      drawing: fieldsToNull.apply('drawing', drawing, this.drawing),
      topography: fieldsToNull.apply('topography', topography, this.topography),
      issuanceOfDrawing: fieldsToNull.apply(
        'issuanceOfDrawing',
        issuanceOfDrawing,
        this.issuanceOfDrawing,
      ),
      appliedInExplosive: fieldsToNull.apply(
        'appliedInExplosive',
        appliedInExplosive,
        this.appliedInExplosive,
      ),
      dcNoc: fieldsToNull.apply('dcNoc', dcNoc, this.dcNoc),
      capex: fieldsToNull.apply('capex', capex, this.capex),
      leaseAgreement: fieldsToNull.apply(
        'leaseAgreement',
        leaseAgreement,
        this.leaseAgreement,
      ),
      hoto: fieldsToNull.apply('hoto', hoto, this.hoto),
      construction: fieldsToNull.apply(
        'construction',
        construction,
        this.construction,
      ),
      inauguration: fieldsToNull.apply(
        'inauguration',
        inauguration,
        this.inauguration,
      ),
      fromDate: fieldsToNull.apply('fromDate', fromDate, this.fromDate),
      toDate: fieldsToNull.apply('toDate', toDate, this.toDate),
      applicationId: fieldsToNull.apply(
        'applicationId',
        applicationId,
        this.applicationId,
      ),
      entryCode: fieldsToNull.apply('entryCode', entryCode, this.entryCode),
      preparedBy: fieldsToNull.apply('preparedBy', preparedBy, this.preparedBy),
      district: fieldsToNull.apply('district', district, this.district),
      dealerName: fieldsToNull.apply('dealerName', dealerName, this.dealerName),
      dealerContact: fieldsToNull.apply(
        'dealerContact',
        dealerContact,
        this.dealerContact,
      ),
      address: fieldsToNull.apply('address', address, this.address),
      referredBy: fieldsToNull.apply('referredBy', referredBy, this.referredBy),
      source: fieldsToNull.apply('source', source, this.source),
      sourceName: fieldsToNull.apply('sourceName', sourceName, this.sourceName),
      siteName: fieldsToNull.apply('siteName', siteName, this.siteName),
    );
  }

  int get countofActiveFilters {
    int count = 0;
    if (selectedPriority != null) count++;
    if (selectedCity != null) count++;
    if (selectedStatusId != null) count++;
    if (surveyProfile != null) count++;
    if (trafficTrade != null) count++;
    if (feasibility != null) count++;
    if (negotiation != null) count++;
    if (mouSign != null) count++;
    if (joiningFee != null) count++;
    if (franchiseAgreement != null) count++;
    if (feasibilityFinalization != null) count++;
    if (explosiveLayout != null) count++;
    if (drawing != null) count++;
    if (topography != null) count++;
    if (issuanceOfDrawing != null) count++;
    if (appliedInExplosive != null) count++;
    if (dcNoc != null) count++;
    if (capex != null) count++;
    if (leaseAgreement != null) count++;
    if (hoto != null) count++;
    if (construction != null) count++;
    if (inauguration != null) count++;
    if (fromDate != null) count++;
    if (toDate != null) count++;
    if (!applicationId.isNullOrEmpty) count++;
    if (!entryCode.isNullOrEmpty) count++;
    if (!preparedBy.isNullOrEmpty) count++;
    if (!district.isNullOrEmpty) count++;
    if (!dealerName.isNullOrEmpty) count++;
    if (!dealerContact.isNullOrEmpty) count++;
    if (!address.isNullOrEmpty) count++;
    if (!referredBy.isNullOrEmpty) count++;
    if (!source.isNullOrEmpty) count++;
    if (!sourceName.isNullOrEmpty) count++;
    if (!siteName.isNullOrEmpty) count++;
    return count;
  }

  static FilterSelectionState fromSearchQuery(String query) {
    return FilterSelectionState(
      selectedPriority: query,
      fromDate: query,
      toDate: query,
      applicationId: query,
      entryCode: query,
      dealerName: query,
      sourceName: query,
      siteName: query,
    );
  }
}
