import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/survey_form/presentation/survey_form_assembler.dart';

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
    // Validate form using FormKey
    

    state = const AsyncValue.loading();

    try {
      // Gather all form data
      final surveyFormData = SurveyFormAssembler.assemble(ref);

      // Additional custom validation if needed
      // if (!_validateFormData(surveyFormData)) {
      //   state = const AsyncValue.data(null);
      //   return false;
      // }

      // TODO: Submit to API
      // Example:
      // await ref.read(surveyRepositoryProvider).submitSurveyForm(surveyFormData);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      log('Survey Form Data: ${surveyFormData.toJson()}');

      state = const AsyncValue.data(null);
      return true;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      log('Error submitting form: $e');
      return false;
    }
  }

  /// Additional custom validation (optional)
  /// This is for business logic validation beyond form field validators
  // bool _validateFormData(SurveyFormModel data) {
  //   // Add custom validation logic here if needed
  //   // For example, cross-field validation
    
  //   // Example: If dealer is ready to invest, monthly salary should be provided
  //   if (data.isDealerReadyToInvest == 'Yes' && 
  //       (data.monthlySalary == null || data.monthlySalary!.isEmpty)) {
  //     log('Validation failed: Monthly salary required when dealer is ready to invest');
  //     return false;
  //   }
    
  //   // Add more custom validation as needed
    
  //   return true;
  // }

  /// Prefill form data (for edit mode)
  // void _prefillFormData(SurveyFormModel data) {
  //   ref.read(applicationInfoFormControllerProvider.notifier).prefillFormData(
  //     applicantId: data.applicantId ?? '',
  //     entryCode: data.entryCode ?? '',
  //     dateConducted: data.dateConducted ?? '',
  //     conductedBy: data.conductedBy ?? '',
  //     googleLocation: data.googleLocation ?? '',
  //     district: data.district ?? '',
  //     npName: data.npName ?? '',
  //     source: data.source ?? '',
  //     sourceName: data.sourceName ?? '',
  //     city: data.city ?? '',
  //     status: data.siteStatus ?? '',
  //     priority: data.priority ?? '',
  //   );

  //   ref.read(contactAndDealerFormControllerProvider.notifier).prefillFormData(
  //     dealerName: data.dealerName ?? '',
  //     dealerContact: data.dealerContact ?? '',
  //     referenceBy: data.referenceBy ?? '',
  //     locationAddress: data.locationAddress ?? '',
  //     nearestDepo: data.nearestDepo ?? '',
  //     typeOfTradeArea: data.typeOfTradeArea ?? '',
  //     landmark: data.landmark ?? '',
  //     plotFront: data.plotFront ?? '',
  //     plotDepth: data.plotDepth ?? '',
  //     distanceFromDepo: data.distanceFromDepo ?? '',
  //   );

  //   ref.read(dealerProfileFormControllerProvider.notifier).prefillFormData(
  //     dealerPlatform: data.dealerPlatform ?? '',
  //     dealerBusinesses: data.dealerBusinesses ?? '',
  //     dealerOpinion: data.dealerOpinion ?? '',
  //     monthlySalary: data.monthlySalary ?? '',
  //     isThisDealer: data.isThisDealer ?? '',
  //     selectedDealerInvolvement: data.dealerInvolvement ?? '',
  //     isDealerReadyToInvest: data.isDealerReadyToInvest ?? '',
  //     isDealerAgreedToFollowTgplStandards: data.isDealerAgreedToFollowTgplStandards ?? '',
  //   );

  //   ref.read(surveyRecommendationFormControllerProvider.notifier).prefillFormData(
  //     selectedTM: data.selectedTM ?? '',
  //     selectedRM: data.selectedRM ?? '',
  //     selectedTMRecommendation: data.tmRecommendation ?? '',
  //     selectedRMRecommendation: data.rmRecommendation ?? '',
  //     tmRemarks: data.tmRemarks ?? '',
  //     rmRemarks: data.rmRemarks ?? '',
  //   );
  // }
}