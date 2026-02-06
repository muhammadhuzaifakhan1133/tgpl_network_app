import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/providers/auto_validate_form.dart';
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
    final autoValidate = ref.watch(autoValidateFormModeProvider);
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

    ref.listen(trafficTradeFormStatusChangedProvider(widget.appId), (previous, next) {
      if (next) {
        // Status changed - navigate back to module applications
        showSnackBar(
          context,
          'Application status has changed. Form is no longer available.',
          bgColor: AppColors.emailUsIconColor,
        );
        ref.read(goRouterProvider).pop();
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
              Expanded(child: _buildForm(controller, autoValidate: autoValidate)),
            ],
          ),
          loading: () => ApplicationFieldsShimmer(title: "Traffic / Trade"),
          error: (error, stack) {
            // Check if error is due to status change
            if (error.toString().contains('status has changed')) {
              // Navigate back on next frame
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  showSnackBar(
                    context,
                    'Application status has changed. Redirecting...',
                    bgColor: AppColors.emailUsIconColor,
                  );
                  ref.read(goRouterProvider).pop();
                }
              });
              return const Center(child: CircularProgressIndicator());
            }
            return errorWidget(error.toString());
          },
        ),
      ),
    );
  }

  Widget _buildForm(TrafficTradeFormController controller, {
    required bool autoValidate,
  }) {
    return Form(
      key: _formKey,
      autovalidateMode: autoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  children: [
                    NearbySitesFormSection(),
                    SizedBox(height: 20.h),
                    TrafficCountCardForm(),
                    SizedBox(height: 20.h),
                    VolumAndFinancialEstimationCardForm(),
                    SizedBox(height: 20.h),
                    TrafficRecommendationCardForm(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                          child: CircularProgressIndicator(
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

    // Turn on auto-validation after first submit attempt
    if (!ref.read(autoValidateFormModeProvider)) {
      ref.read(autoValidateFormModeProvider.notifier).state = true;
    }

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
