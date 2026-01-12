import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/traffic_trade_form_controller.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/nearby_sites_form_section.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/trafffic_recommendation_card_form.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/traffic_count_card_form.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/volum_and_financial_estimation_card_form.dart';

class TrafficTradeFormView extends ConsumerWidget {
  final String appId;
  const TrafficTradeFormView({super.key, required this.appId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            CustomAppBar(
              title: "Traffic / Trade",
              subtitle: "Form # $appId",
              showBackButton: true,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: ref
                        .read(trafficTradeFormControllerProvider.notifier)
                        .formKey,
                    child: Column(
                      children: [
                        NearbySitesFormSection(),
                        const SizedBox(height: 20),
                        TrafficCountCardForm(),
                        const SizedBox(height: 20),
                        VolumAndFinancialEstimationCardForm(),
                        const SizedBox(height: 20),
                        TrafficRecommendationCardForm(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
