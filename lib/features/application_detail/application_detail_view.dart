import 'package:flutter/material.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/features/application_detail/widgets/applicant_info_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/contact_dealer_tgpl_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/dealer_profile_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/feasibility_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/site_detail_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/recommendation_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/traffic_count_card.dart';
import 'package:tgpl_network/features/application_detail/widgets/volum_and_financial_estimation_card.dart';

class ApplicationDetailView extends StatelessWidget {
  final String appId;
  final int statusId;
  const ApplicationDetailView({
    super.key,
    required this.appId,
    required this.statusId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: appId,
            subtitle: "Application Details",
            showBackButton: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ApplicantInfoCard(),
                    const SizedBox(height: 20),
                    SiteDetailCard(),
                    const SizedBox(height: 20),
                    ContactDealerTGPLCard(),
                    const SizedBox(height: 20),
                    DealerProfileCard(),
                    const SizedBox(height: 20),
                    RecommendationCard(),
                    if (statusId >= 3) ...[
                      const SizedBox(height: 20),
                      TrafficCountCard(),
                      const SizedBox(height: 20),
                      VolumAndFinancialEstimationCard(),
                      const SizedBox(height: 20),
                      RecommendationCard(),
                    ],
                    if (statusId >= 4) ...[
                      const SizedBox(height: 20),
                      FeasibilityCard(),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
