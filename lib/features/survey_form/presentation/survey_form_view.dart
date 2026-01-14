import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/features/survey_form/presentation/survey_form_controller.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/applicant_info_form_card.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/contact_and_dealer_form_card.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/dealer_profile_form_card.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/survey_recommendation_form_card.dart';

class SurveyFormView extends ConsumerWidget {
  final String appId;
  const SurveyFormView({super.key, required this.appId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            CustomAppBar(
              title: "Site Survey & Dealer Profile",
              subtitle: "Form # $appId",
              showBackButton: true,
            ),
            Expanded(
              child: Form(
                key: ref
                    .read(surveyFormControllerProvider.notifier)
                    .formKey,
                child: ListView(
                   padding: const EdgeInsets.all(20.0),
                  children: [
                    ApplicantInfoFormCard(),
                    const SizedBox(height: 20),
                    ContactAndDealerFormCard(),
                    const SizedBox(height: 20),
                    DealerProfileFormCard(),
                    const SizedBox(height: 20),
                    SurveyRecommendationFormCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
