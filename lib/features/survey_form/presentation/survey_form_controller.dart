import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/survey_form/models/survey_form_model.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/application_info/application_info_form_controller.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/contact_and_dealer/contact_and_dealer_form_controller.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/dealer_profile/dealer_profile_form_controller.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/survey_recommendation/survey_recommendation_form_controller.dart';

final surveyFormControllerProvider =
    AsyncNotifierProvider.autoDispose<SurveyFormController, void>(
  SurveyFormController.new,
);

class SurveyFormController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // Initialize empty state
  }

  /// Initialize form with data (for edit mode)
  Future<void> initialize(String appId) async {
    state = const AsyncValue.loading();
    
    state = await AsyncValue.guard(() async {
      // TODO: Fetch existing data from API if editing
      // Example:
      // final data = await ref.read(surveyRepositoryProvider).getSurveyForm(appId);
      // if (data != null) {
      //   _prefillFormData(data);
      // }
      
      // For now, just complete successfully
      await Future.delayed(const Duration(milliseconds: 500));
    });
  }

  /// Submit the survey form
  Future<bool> submitSurveyForm() async {
    state = const AsyncValue.loading();

    try {
      // Gather all form data
      final surveyFormData = _gatherFormData();

      // Validate all required fields
      if (!_validateFormData(surveyFormData)) {
        state = const AsyncValue.data(null);
        return false;
      }

      // TODO: Submit to API
      // Example:
      // await ref.read(surveyRepositoryProvider).submitSurveyForm(surveyFormData);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      debugPrint('Survey Form Data: ${surveyFormData.toJson()}');

      state = const AsyncValue.data(null);
      return true;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      debugPrint('Error submitting form: $e');
      return false;
    }
  }

  /// Gather data from all form sections
  SurveyFormModel _gatherFormData() {
    final applicationInfo = ref.read(applicationInfoFormControllerProvider);
    final contactAndDealer = ref.read(contactAndDealerFormControllerProvider);
    final dealerProfile = ref.read(dealerProfileFormControllerProvider);
    final recommendation = ref.read(surveyRecommendationFormControllerProvider);

    return SurveyFormModel(
      // Application Info
      applicantId: applicationInfo.applicantId,
      entryCode: applicationInfo.entryCode,
      dateConducted: applicationInfo.dateConducted,
      conductedBy: applicationInfo.conductedBy,
      googleLocation: applicationInfo.googleLocation,
      city: applicationInfo.selectedCity,
      district: applicationInfo.district,
      siteStatus: applicationInfo.siteStatus,
      npName: applicationInfo.npName,
      source: applicationInfo.source,
      sourceName: applicationInfo.sourceName,
      priority: applicationInfo.selectedPriority,
      
      // Contact & Dealer
      dealerName: contactAndDealer.dealerName,
      dealerContact: contactAndDealer.dealerContact,
      referenceBy: contactAndDealer.referenceBy,
      locationAddress: contactAndDealer.locationAddress,
      landmark: contactAndDealer.landmark,
      plotFront: contactAndDealer.plotFront,
      plotDepth: contactAndDealer.plotDepth,
      plotArea: contactAndDealer.plotArea,
      nearestDepo: contactAndDealer.nearestDepo,
      distanceFromDepo: contactAndDealer.distanceFromDepo,
      typeOfTradeArea: contactAndDealer.typeOfTradeArea,
      
      // Dealer Profile
      isThisDealer: dealerProfile.isThisDealer,
      dealerPlatform: dealerProfile.dealerPlatform,
      dealerBusinesses: dealerProfile.dealerBusinesses,
      dealerInvolvement: dealerProfile.selectedDealerInvolvement,
      isDealerReadyToInvest: dealerProfile.isDealerReadyToInvest,
      dealerOpinion: dealerProfile.dealerOpinion,
      monthlySalary: dealerProfile.monthlySalary,
      isDealerAgreedToFollowTgplStandards: dealerProfile.isDealerAgreedToFollowTgplStandards,
      
      // Recommendations
      selectedTM: recommendation.selectedTM,
      tmRecommendation: recommendation.selectedTMRecommendation,
      tmRemarks: recommendation.tmRemarks,
      selectedRM: recommendation.selectedRM,
      rmRecommendation: recommendation.selectedRMRecommendation,
      rmRemarks: recommendation.rmRemarks,
    );
  }

  /// Validate form data
  bool _validateFormData(SurveyFormModel data) {
    // Add custom validation logic here if needed
    // For example, check if required fields are not empty
    
    if (data.conductedBy == null || data.conductedBy!.isEmpty) {
      debugPrint('Validation failed: Conducted By is required');
      return false;
    }
    
    if (data.googleLocation == null || data.googleLocation!.isEmpty) {
      debugPrint('Validation failed: Google Location is required');
      return false;
    }
    
    // Add more validation as needed
    
    return true;
  }

  /// Prefill form data (for edit mode)
  void _prefillFormData(SurveyFormModel data) {
    ref.read(applicationInfoFormControllerProvider.notifier).prefillFormData(
      applicantId: data.applicantId ?? '',
      entryCode: data.entryCode ?? '',
      dateConducted: data.dateConducted ?? '',
      conductedBy: data.conductedBy ?? '',
      googleLocation: data.googleLocation ?? '',
      district: data.district ?? '',
      npName: data.npName ?? '',
      source: data.source ?? '',
      sourceName: data.sourceName ?? '',
      city: data.city ?? '',
      status: data.siteStatus ?? '',
      priority: data.priority ?? '',
    );

    ref.read(contactAndDealerFormControllerProvider.notifier).prefillFormData(
      dealerName: data.dealerName ?? '',
      dealerContact: data.dealerContact ?? '',
      referenceBy: data.referenceBy ?? '',
      locationAddress: data.locationAddress ?? '',
      nearestDepo: data.nearestDepo ?? '',
      typeOfTradeArea: data.typeOfTradeArea ?? '',
      landmark: data.landmark ?? '',
      plotFront: data.plotFront ?? '',
      plotDepth: data.plotDepth ?? '',
      distanceFromDepo: data.distanceFromDepo ?? '',
    );

    ref.read(dealerProfileFormControllerProvider.notifier).prefillFormData(
      dealerPlatform: data.dealerPlatform ?? '',
      dealerBusinesses: data.dealerBusinesses ?? '',
      dealerOpinion: data.dealerOpinion ?? '',
      monthlySalary: data.monthlySalary ?? '',
      isThisDealer: data.isThisDealer ?? '',
      selectedDealerInvolvement: data.dealerInvolvement ?? '',
      isDealerReadyToInvest: data.isDealerReadyToInvest ?? '',
      isDealerAgreedToFollowTgplStandards: data.isDealerAgreedToFollowTgplStandards ?? '',
    );

    ref.read(surveyRecommendationFormControllerProvider.notifier).prefillFormData(
      selectedTM: data.selectedTM ?? '',
      selectedRM: data.selectedRM ?? '',
      selectedTMRecommendation: data.tmRecommendation ?? '',
      selectedRMRecommendation: data.rmRecommendation ?? '',
      tmRemarks: data.tmRemarks ?? '',
      rmRemarks: data.rmRemarks ?? '',
    );
  }
}