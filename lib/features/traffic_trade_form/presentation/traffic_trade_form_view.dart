import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/application_fields_shimmer_widget.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/error_widget.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/traffic_trade_form_controller.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/nearby_sites/nearby_sites_form_section.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/traffic_recommendation/trafffic_recommendation_card_form.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/traffic_count/traffic_count_card_form.dart';
import 'package:tgpl_network/features/traffic_trade_form/presentation/widget/volume_and_financial_estimation/volum_and_financial_estimation_card_form.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';
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
    final controller = ref.read(
      trafficTradeFormControllerProvider(widget.appId).notifier,
    );

    ref.listen(trafficTradeFormControllerProvider(widget.appId), (
      previous,
      next,
    ) {
      if (next.value?.errorMessage.isNullOrEmpty == false) {
        showSnackBar(
          context,
          'Error submitting form: ${next.value?.errorMessage}',
          bgColor: AppColors.emailUsIconColor,
        );
      }
    });

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: asyncValue.when(
          data: (_) => Column(
            children: [
              CustomAppBar(
                title: "Traffic / Trade",
                subtitle: "Form # ${widget.appId}",
                showBackButton: true,
              ),
              Expanded(child: _buildForm(controller)),
            ],
          ),
          loading: () => ApplicationFieldsShimmer(title: "Traffic / Trade"),
          error: (error, stack) => errorWidget(error.toString()),
        ),
      ),
    );
  }

  Widget _buildForm(TrafficTradeFormController controller) {
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
            child: Consumer(
              builder: (context, ref, child) {
                final isLoading =
                    ref.watch(
                      trafficTradeFormControllerProvider(
                        widget.appId,
                      ).select((s) => s.value?.isSubmitting),
                    ) ??
                    false;
                return CustomButton(
                  onPressed: isLoading ? null : () => _handleSubmit(controller),
                  text: "Submit",
                  child: isLoading
                      ? Center(
                          child: const CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                        )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSubmit(TrafficTradeFormController controller) async {
    // Unfocus any active text field
    FocusScope.of(context).unfocus();

    bool? success;

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      // Submit form (validation happens inside too)
      success = await controller.submitTrafficTradeForm();
    } else {
      showSnackBar(
        context,
        'Please correct the errors in the form.',
        bgColor: AppColors.emailUsIconColor,
      );
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
    }
  }
}
