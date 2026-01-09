import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/utils/yes_no_enum_with_extension.dart';

final filterSelectionDialogControllerProvider =
    NotifierProvider<
      FilterSelectionDialogController,
      FilterSelectionDialogState
    >(() {
      return FilterSelectionDialogController();
    });

class FilterSelectionDialogState {
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

  const FilterSelectionDialogState({
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
  });

  FilterSelectionDialogState copyWith({
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
  }) {
    return FilterSelectionDialogState(
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
    );
  }
}

class FilterSelectionDialogController
    extends Notifier<FilterSelectionDialogState> {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController receiveDateController = TextEditingController();
  TextEditingController condDateController = TextEditingController();
  TextEditingController applicationIdController = TextEditingController();
  TextEditingController entryCodeController = TextEditingController();
  TextEditingController preparedByController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController dealerNameController = TextEditingController();
  TextEditingController dealerContactController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController referredByController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController sourceNameController = TextEditingController();
  TextEditingController siteNameController = TextEditingController();

  @override
  FilterSelectionDialogState build() {
    return FilterSelectionDialogState();
  }

  Future<void> onSelectDate({
    required BuildContext context,
    DateTime? initialDate,
    required void Function(DateTime) onUserSelectedDate,
  }) async {
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDate: initialDate,
    );
    if (selectedDate != null) {
      onUserSelectedDate(selectedDate);
    }
  }

  void onChangeCity(String city) {
    state = state.copyWith(selectedCity: city);
  }

  void onChangePriority(String priority) {
    state = state.copyWith(selectedPriority: priority);
  }

  void onChangeStatus(String status) {
    state = state.copyWith(selectedStatus: status);
  }

  void onChangeYesNoField({
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
}
