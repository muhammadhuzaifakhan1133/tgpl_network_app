import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final surveyFormControllerProvider =
    NotifierProvider<SurveyFormController, SurveyFormState>(
        () => SurveyFormController());

class SurveyFormState {
  String? selectedCity;
  String? siteStatus;
  String? selectedPriority;
  String? selectedNearestDepo;
  String? selectedTypeOfTradeArea;
  String? isThisDealer;
  String? selectedDealerInvolvement;
  String? isDealerReadyToInvest;
  String? isDealerAgreedToFollowTgplStandards;
  String? selectedTM;
  String? selectedRM;
  String? selectedTMRecommendation;
  String? selectedRMRecommendation;

  SurveyFormState({
    this.selectedCity,
    this.siteStatus,
    this.selectedPriority,
    this.selectedNearestDepo,
    this.selectedTypeOfTradeArea,
    this.isThisDealer,
    this.selectedDealerInvolvement,
    this.isDealerReadyToInvest,
    this.isDealerAgreedToFollowTgplStandards,
    this.selectedTM,
    this.selectedRM,
    this.selectedTMRecommendation,
    this.selectedRMRecommendation,
  });

  SurveyFormState copyWith({
    String? selectedCity,
    String? siteStatus,
    String? selectedPriority,
    String? selectedNearestDepo,
    String? selectedTypeOfTradeArea,
    String? isThisDealer,
    String? selectedDealerInvolvement,
    String? isDealerReadyToInvest,
    String? isDealerAgreedToFollowTgplStandards,
    String? selectedTM,
    String? selectedRM,
    String? selectedTMRecommendation,
    String? selectedRMRecommendation,
  }) {
    return SurveyFormState(
      selectedCity: selectedCity ?? this.selectedCity,
      siteStatus: siteStatus ?? this.siteStatus,
      selectedPriority: selectedPriority ?? this.selectedPriority,
      selectedNearestDepo: selectedNearestDepo ?? this.selectedNearestDepo,
      selectedTypeOfTradeArea:
          selectedTypeOfTradeArea ?? this.selectedTypeOfTradeArea,
      isThisDealer: isThisDealer ?? this.isThisDealer,
      selectedDealerInvolvement:
          selectedDealerInvolvement ?? this.selectedDealerInvolvement,
      isDealerReadyToInvest:
          isDealerReadyToInvest ?? this.isDealerReadyToInvest,
      isDealerAgreedToFollowTgplStandards:
          isDealerAgreedToFollowTgplStandards ??
              this.isDealerAgreedToFollowTgplStandards,
      selectedTM: selectedTM ?? this.selectedTM,
      selectedRM: selectedRM ?? this.selectedRM,
      selectedTMRecommendation:
          selectedTMRecommendation ?? this.selectedTMRecommendation,
      selectedRMRecommendation:
          selectedRMRecommendation ?? this.selectedRMRecommendation,
    );
  }
}

class SurveyFormController extends Notifier<SurveyFormState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController applicantIdController = TextEditingController();
  TextEditingController entryCodeController = TextEditingController();
  TextEditingController dateConductedController = TextEditingController();
  TextEditingController conductedByController = TextEditingController();
  TextEditingController googleLocationController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController npNameController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController sourceNameController = TextEditingController();
  TextEditingController dealerNameController = TextEditingController();
  TextEditingController dealerContactController = TextEditingController();
  TextEditingController referencyByController = TextEditingController();
  TextEditingController locationAddressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController plotAreaController = TextEditingController();
  TextEditingController plotFrontController = TextEditingController();
  TextEditingController plotDepthController = TextEditingController();
  TextEditingController distanceFromDepoController = TextEditingController();
  TextEditingController dealerPlatformController = TextEditingController();
  TextEditingController dealerBusinessesController = TextEditingController();
  TextEditingController dealerOpinionController = TextEditingController();
  TextEditingController monthlySalaryController = TextEditingController();
  TextEditingController tmRemarksController = TextEditingController();
  TextEditingController rmRemarksController = TextEditingController();
  

  @override
  SurveyFormState build() {
    return SurveyFormState();
  }

  void onChangeCity(String city) {
    state = state.copyWith(selectedCity: city);
  }

  void onChangeSiteStatus(String status) {
    state = state.copyWith(siteStatus: status);
  }

  void onChangePriority(String priority) {
    state = state.copyWith(selectedPriority: priority);
  }

  void onChangeNearestDepo(String depo) {
    state = state.copyWith(selectedNearestDepo: depo);
  }

  void onChangeTypeOfTradeArea(String type) {
    state = state.copyWith(selectedTypeOfTradeArea: type);
  }

  void onChangeIsThisDealer(String answer) {
    state = state.copyWith(isThisDealer: answer);
  }

  void onChangeDealerInvolvement(String involvement) {
    state = state.copyWith(selectedDealerInvolvement: involvement);
  }

  void onChangeIsDealerReadyToInvest(String answer) {
    state = state.copyWith(isDealerReadyToInvest: answer);
  }

  void onChangeIsDealerAgreedToFollowTgplStandards(String answer) {
    state = state.copyWith(isDealerAgreedToFollowTgplStandards: answer);
  }

  void onChangeTM(String tm) {
    state = state.copyWith(selectedTM: tm);
  }

  void onChangeRM(String rm) {
    state = state.copyWith(selectedRM: rm);
  }

  void onChangeTMRecommendation(String recommendation) {
    state = state.copyWith(selectedTMRecommendation: recommendation);
  }

  void onChangeRMRecommendation(String recommendation) {
    state = state.copyWith(selectedRMRecommendation: recommendation);
  }

  void onChangePlotFrontAndDepth() {
    // calculate plot area
    final frontText = plotFrontController.text;
    final depthText = plotDepthController.text;
    if (frontText.isEmpty || depthText.isEmpty) {
      plotAreaController.text = '';
      return;
    }
    final front = double.tryParse(frontText);
    final depth = double.tryParse(depthText);
    if (front == null || depth == null) {
      plotAreaController.text = '';
      return;
    }
    final area = front * depth;
    plotAreaController.text = area.toStringAsFixed(2);
  }
}