import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/survey_form/models/survey_form_model.dart';
import 'package:tgpl_network/utils/extensions/nullable_fields_helper.dart';

final dealerProfileFormControllerProvider =
    NotifierProvider<DealerProfileFormController, DealerProfileFormState>(
      DealerProfileFormController.new,
    );

class DealerProfileFormState {
  final String? isThisDealer;
  final String? dealerPlatform;
  final String? dealerBusinesses;
  final String? selectedDealerInvolvement;
  final String? isDealerReadyToInvest;
  final String? dealerOpinion;
  final String? monthlySalary;
  final String? isDealerAgreedToFollowTgplStandards;

  const DealerProfileFormState({
    this.isThisDealer,
    this.dealerPlatform,
    this.dealerBusinesses,
    this.selectedDealerInvolvement,
    this.isDealerReadyToInvest,
    this.dealerOpinion,
    this.monthlySalary,
    this.isDealerAgreedToFollowTgplStandards,
  });

  DealerProfileFormState copyWith({
    String? isThisDealer,
    String? dealerPlatform,
    String? dealerBusinesses,
    String? selectedDealerInvolvement,
    String? isDealerReadyToInvest,
    String? dealerOpinion,
    String? monthlySalary,
    String? isDealerAgreedToFollowTgplStandards,
    List<String>? fieldsToNull,
  }) {
    return DealerProfileFormState(
      isThisDealer: fieldsToNull.apply("isThisDealer", isThisDealer, this.isThisDealer),
      dealerPlatform: fieldsToNull.apply(
        "dealerPlatform",
        dealerPlatform,
        this.dealerPlatform,
      ),
      dealerBusinesses: fieldsToNull.apply(
        "dealerBusinesses",
        dealerBusinesses,
        this.dealerBusinesses,
      ),
      selectedDealerInvolvement: fieldsToNull.apply(
        "selectedDealerInvolvement",
        selectedDealerInvolvement,
        this.selectedDealerInvolvement,
      ),
      isDealerReadyToInvest: fieldsToNull.apply(
        "isDealerReadyToInvest",
        isDealerReadyToInvest,
        this.isDealerReadyToInvest,
      ),
      dealerOpinion: fieldsToNull.apply("dealerOpinion", dealerOpinion, this.dealerOpinion),
      monthlySalary: fieldsToNull.apply("monthlySalary", monthlySalary, this.monthlySalary),
      isDealerAgreedToFollowTgplStandards: fieldsToNull.apply(
        "isDealerAgreedToFollowTgplStandards",
        isDealerAgreedToFollowTgplStandards,
        this.isDealerAgreedToFollowTgplStandards,
      ),
    );
  }

  @override
  String toString() {
    return 'DealerProfileFormState(isThisDealer: $isThisDealer, dealerPlatform: $dealerPlatform, dealerBusinesses: $dealerBusinesses, selectedDealerInvolvement: $selectedDealerInvolvement, isDealerReadyToInvest: $isDealerReadyToInvest, dealerOpinion: $dealerOpinion, monthlySalary: $monthlySalary, isDealerAgreedToFollowTgplStandards: $isDealerAgreedToFollowTgplStandards)';
  }

  DealerProfileFormState.loadFromApplication(ApplicationModel app)
      : isThisDealer = app.isThisDealerSite,
        dealerPlatform = app.platform,
        dealerBusinesses = app.whatOtherBusiness,
        selectedDealerInvolvement = app.howInvolveDealerInPetrol,
        isDealerReadyToInvest = app.isDealerReadyToCapitalInvestment,
        dealerOpinion = app.whyDoesTaj,
        monthlySalary = app.managerCurrentSalary?.toString(),
        isDealerAgreedToFollowTgplStandards = app.isAgreeToTGPLStandard;

  DealerProfileFormState.loadFromSurveyFormModel(SurveyFormModel form)
      : isThisDealer = form.isThisDealer,
        dealerPlatform = form.dealerPlatform,
        dealerBusinesses = form.dealerBusinesses,
        selectedDealerInvolvement = form.dealerInvolvement,
        isDealerReadyToInvest = form.isDealerReadyToInvest,
        dealerOpinion = form.dealerOpinion,
        monthlySalary = form.monthlySalary,
        isDealerAgreedToFollowTgplStandards = form.isDealerAgreedToFollowTgplStandards;
}

class DealerProfileFormController extends Notifier<DealerProfileFormState> {
  @override
  DealerProfileFormState build() {
    return const DealerProfileFormState();
  }

  void onChangeIsThisDealer(String answer) {
    state = state.copyWith(isThisDealer: answer);

    // Clear conditional fields if answer is not "Yes"
    if (answer != 'Yes') {
      state = state.copyWith(
        dealerBusinesses: '',
        dealerOpinion: '',
        monthlySalary: '',
        selectedDealerInvolvement: null,
        isDealerReadyToInvest: null,
        isDealerAgreedToFollowTgplStandards: null,
      );
    }
  }

  void updateDealerPlatform(String platform) {
    state = state.copyWith(dealerPlatform: platform);
  }

  void updateDealerBusinesses(String businesses) {
    state = state.copyWith(dealerBusinesses: businesses);
  }

  void onChangeDealerInvolvement(String involvement) {
    state = state.copyWith(selectedDealerInvolvement: involvement);
  }

  void onChangeIsDealerReadyToInvest(String answer) {
    state = state.copyWith(isDealerReadyToInvest: answer);
  }

  void updateDealerOpinion(String opinion) {
    state = state.copyWith(dealerOpinion: opinion);
  }

  void updateMonthlySalary(String salary) {
    state = state.copyWith(monthlySalary: salary);
  }

  void onChangeIsDealerAgreedToFollowTgplStandards(String answer) {
    state = state.copyWith(isDealerAgreedToFollowTgplStandards: answer);
  }

  void clearField(String fieldName) {
    state = state.copyWith(fieldsToNull: [fieldName]);
  }

  void loadFromApplication(ApplicationModel app) {
    state = DealerProfileFormState.loadFromApplication(app);
  }

  void loadFromSurveyFormModel(SurveyFormModel form) {
    state = DealerProfileFormState.loadFromSurveyFormModel(form);
  }

  // void prefillFormData({
  //   required String dealerPlatform,
  //   required String dealerBusinesses,
  //   required String dealerOpinion,
  //   required String monthlySalary,
  //   required String isThisDealer,
  //   required String selectedDealerInvolvement,
  //   required String isDealerReadyToInvest,
  //   required String isDealerAgreedToFollowTgplStandards,
  // }) {
  //   state = state.copyWith(
  //     dealerPlatform: dealerPlatform,
  //     dealerBusinesses: dealerBusinesses,
  //     dealerOpinion: dealerOpinion,
  //     monthlySalary: monthlySalary,
  //     isThisDealer: isThisDealer,
  //     selectedDealerInvolvement: selectedDealerInvolvement,
  //     isDealerReadyToInvest: isDealerReadyToInvest,
  //     isDealerAgreedToFollowTgplStandards: isDealerAgreedToFollowTgplStandards,
  //   );
  // }
}
