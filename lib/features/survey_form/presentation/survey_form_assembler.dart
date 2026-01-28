import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/master_data/models/application_model.dart';
import 'package:tgpl_network/features/survey_form/models/survey_form_model.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/application_info/application_info_form_controller.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/contact_and_dealer/contact_and_dealer_form_controller.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/dealer_profile/dealer_profile_form_controller.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/survey_recommendation/survey_recommendation_form_controller.dart';

class SurveyFormAssembler {
  static void dessembleFromApp(Ref ref, ApplicationModel app) {
    ref.read(applicationInfoFormControllerProvider.notifier).loadFromApplication(app);
    ref.read(contactAndDealerFormControllerProvider.notifier).loadFromApplication(app);
    ref.read(dealerProfileFormControllerProvider.notifier).loadFromApplication(app);
    ref.read(surveyRecommendationFormControllerProvider.notifier).loadFromApplication(app);
  }

  static void dessembleFromSurveyFormModel(Ref ref, SurveyFormModel form) {
    ref.read(applicationInfoFormControllerProvider.notifier).loadFromSurveyFormModel(form);
    ref.read(contactAndDealerFormControllerProvider.notifier).loadFromSurveyFormModel(form);
    ref.read(dealerProfileFormControllerProvider.notifier).loadFromSurveyFormModel(form);
    ref.read(surveyRecommendationFormControllerProvider.notifier).loadFromSurveyFormModel(form);
  }


  static SurveyFormModel assemble(Ref ref) {

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

}
