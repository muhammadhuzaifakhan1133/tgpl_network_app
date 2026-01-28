import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/traffic_trade_form_controller.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/nearby_sites/nearby_sites_form_section.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/traffic_recommendation/trafffic_recommendation_card_form.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/traffic_count/traffic_count_card_form.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/volume_and_financial_estimation/volum_and_financial_estimation_card_form.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/utils/show_snackbar.dart';

class TrafficTradeFormView extends ConsumerStatefulWidget {
  final String appId;
  const TrafficTradeFormView({super.key, required this.appId});

  @override
  ConsumerState<TrafficTradeFormView> createState() =>
      _TrafficTradeFormViewState();
}

class _TrafficTradeFormViewState extends ConsumerState<TrafficTradeFormView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(
      trafficTradeFormControllerProvider(widget.appId),
    );
    final submissionController = ref.read(
      trafficTradeFormSubmissionControllerProvider.notifier,
    );

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            CustomAppBar(
              title: "Traffic / Trade",
              subtitle: "Form # ${widget.appId}",
              showBackButton: true,
            ),
            Expanded(
              child: asyncValue.when(
                data: (_) => _buildForm(submissionController),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: $error'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.refresh(
                          trafficTradeFormControllerProvider(widget.appId),
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(TrafficTradeFormSubmissionController submissionController) {
    final isSubmitting = ref.watch(
      trafficTradeFormSubmissionControllerProvider.select(
        (state) => state.isLoading,
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: const [
                    NearbySitesFormSection(),
                    SizedBox(height: 20),
                    TrafficCountCardForm(),
                    SizedBox(height: 20),
                    VolumAndFinancialEstimationCardForm(),
                    SizedBox(height: 20),
                    TrafficRecommendationCardForm(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CustomButton(
              onPressed: isSubmitting
                  ? null
                  : () => _handleSubmit(submissionController),
              text: isSubmitting ? "Submitting..." : "Submit",
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSubmit(
    TrafficTradeFormSubmissionController submissionController,
  ) async {
    // Unfocus any active text field
    FocusScope.of(context).unfocus();

    bool? success;

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      // Submit form (validation happens inside)
      success = await submissionController.submitTrafficTradeForm();
    }

    if (!mounted) return;

    if (success == true) {
      showSnackBar(
        context,
        "Form submitted successfully!",
        bgColor: AppColors.onlineStatusColor,
      );
      // Navigate back or to success screen
      ref.read(goRouterProvider).pop(true);
    } else {
      showSnackBar(
        context,
        'Please correct the errors in the form.',
        bgColor: AppColors.emailUsIconColor,
      );
    }
  }
}
