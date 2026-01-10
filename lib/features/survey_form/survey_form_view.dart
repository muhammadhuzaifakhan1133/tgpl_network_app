import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/features/survey_form/widgets/applicant_info_form_card.dart';

class SurveyFormView extends StatelessWidget {
  final String appId;
  const SurveyFormView({super.key, required this.appId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Site Survey & Dealer Profile",
            subtitle: "Form # $appId",
            showBackButton: true,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [ApplicantInfoFormCard()]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
