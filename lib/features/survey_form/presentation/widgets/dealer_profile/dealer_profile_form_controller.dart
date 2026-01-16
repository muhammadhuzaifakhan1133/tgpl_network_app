import 'package:flutter_riverpod/flutter_riverpod.dart';

final dealerProfileFormControllerProvider =
    NotifierProvider<DealerProfileFormController, DealerProfileFormState>(
        DealerProfileFormController.new);

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
  }) {
    return DealerProfileFormState(
      isThisDealer: isThisDealer ?? this.isThisDealer,
      dealerPlatform: dealerPlatform ?? this.dealerPlatform,
      dealerBusinesses: dealerBusinesses ?? this.dealerBusinesses,
      selectedDealerInvolvement:
          selectedDealerInvolvement ?? this.selectedDealerInvolvement,
      isDealerReadyToInvest:
          isDealerReadyToInvest ?? this.isDealerReadyToInvest,
      dealerOpinion: dealerOpinion ?? this.dealerOpinion,
      monthlySalary: monthlySalary ?? this.monthlySalary,
      isDealerAgreedToFollowTgplStandards:
          isDealerAgreedToFollowTgplStandards ??
              this.isDealerAgreedToFollowTgplStandards,
    );
  }

  @override
  String toString() {
    return 'DealerProfileFormState(isThisDealer: $isThisDealer, dealerPlatform: $dealerPlatform, dealerBusinesses: $dealerBusinesses, selectedDealerInvolvement: $selectedDealerInvolvement, isDealerReadyToInvest: $isDealerReadyToInvest, dealerOpinion: $dealerOpinion, monthlySalary: $monthlySalary, isDealerAgreedToFollowTgplStandards: $isDealerAgreedToFollowTgplStandards)';
  }
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

  void prefillFormData({
    required String dealerPlatform,
    required String dealerBusinesses,
    required String dealerOpinion,
    required String monthlySalary,
    required String isThisDealer,
    required String selectedDealerInvolvement,
    required String isDealerReadyToInvest,
    required String isDealerAgreedToFollowTgplStandards,
  }) {
    state = state.copyWith(
      dealerPlatform: dealerPlatform,
      dealerBusinesses: dealerBusinesses,
      dealerOpinion: dealerOpinion,
      monthlySalary: monthlySalary,
      isThisDealer: isThisDealer,
      selectedDealerInvolvement: selectedDealerInvolvement,
      isDealerReadyToInvest: isDealerReadyToInvest,
      isDealerAgreedToFollowTgplStandards: isDealerAgreedToFollowTgplStandards,
    );
  }
}