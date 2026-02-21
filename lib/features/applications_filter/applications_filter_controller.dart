import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/providers/statuses_provider.dart';
import 'applications_filter_state.dart';
import 'package:tgpl_network/common/models/yes_no_enum_with_extension.dart';

final filterSelectionProvider =
    NotifierProvider<FilterController, FilterSelectionState>(
      FilterController.new,
    );

class FilterController extends Notifier<FilterSelectionState> {
  @override
  FilterSelectionState build() {
    return const FilterSelectionState();
  }

  void updateDropdown({String? city, String? priority, AppStatusCategory? status}) {
    state = state.copyWith(
      selectedCity: city,
      selectedPriority: priority,
      selectedStatus: status,
    );
  }

  void updateDates({
    String? fromDate,
    String? toDate,
    String? receiveDate,
    String? condDate,
  }) {
    state = state.copyWith(
      fromDate: fromDate,
      toDate: toDate,
      receiveDate: receiveDate,
      condDate: condDate,
    );
  }

  void updateTextFields({
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
    state = state.copyWith(
      applicationId: applicationId,
      entryCode: entryCode,
      preparedBy: preparedBy,
      district: district,
      dealerName: dealerName,
      dealerContact: dealerContact,
      address: address,
      referredBy: referredBy,
      source: source,
      sourceName: sourceName,
      siteName: siteName,
    );
  }

  void updateYesNo({
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
  }) {
    state = state.copyWith(
      surveyProfile: surveyProfile,
      trafficTrade: trafficTrade,
      feasibility: feasibility,
      negotiation: negotiation,
      mouSign: mouSign,
      joiningFee: joiningFee,
      franchiseAgreement: franchiseAgreement,
      feasibilityFinalization: feasibilityFinalization,
      explosiveLayout: explosiveLayout,
      drawing: drawing,
      topography: topography,
      issuanceOfDrawing: issuanceOfDrawing,
      appliedInExplosive: appliedInExplosive,
      dcNoc: dcNoc,
      capex: capex,
      leaseAgreement: leaseAgreement,
      hoto: hoto,
      construction: construction,
      inauguration: inauguration,
    );
  }

  void clearAll() {
    state = const FilterSelectionState();
  }

  void clearFields(List<String> fields) {
    state = state.copyWith(fieldsToNull: fields);
  }
}
