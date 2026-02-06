import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tgpl_network/common/providers/auto_validate_form.dart';
import 'package:tgpl_network/common/widgets/application_fields_shimmer_widget.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/common/widgets/error_widget.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/features/survey_form/presentation/survey_form_controller.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/application_info/applicant_info_form_card.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/contact_and_dealer/contact_and_dealer_form_card.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/dealer_profile/dealer_profile_form_card.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/survey_recommendation/survey_recommendation_form_card.dart';
import 'package:tgpl_network/routes/app_router.dart';
import 'package:tgpl_network/utils/extensions/string_validation_extension.dart';
import 'package:tgpl_network/utils/show_snackbar.dart';

class SurveyFormView extends ConsumerStatefulWidget {
  final String appId;
  const SurveyFormView({super.key, required this.appId});

  @override
  ConsumerState<SurveyFormView> createState() => _SurveyFormViewState();
}

class _SurveyFormViewState extends ConsumerState<SurveyFormView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(surveyFormControllerProvider(widget.appId));
    final autoValidate = ref.watch(autoValidateFormModeProvider);
    final controller = ref.read(
      surveyFormControllerProvider(widget.appId).notifier,
    );
    ref.listen(surveyFormControllerProvider(widget.appId), (p, n) {
      if (n.value?.errorMessage.isNullOrEmpty == false) {
        showSnackBar(
          context,
          'Error submitting form: ${n.value?.errorMessage}',
          bgColor: AppColors.emailUsIconColor,
        );
      }
    });

    ref.listen(surveyFormStatusChangedProvider(widget.appId), (previous, next) {
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
                title: "Site Survey & Dealer Profile",
                subtitle: "Form # ${widget.appId}",
                showBackButton: true,
              ),
              Expanded(
                child: _buildForm(controller, autoValidate: autoValidate),
              ),
            ],
          ),
          loading: () =>
              ApplicationFieldsShimmer(title: "Site Survey & Dealer Profile"),
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

  Widget _buildForm(
    SurveyFormController controller, {
    required bool autoValidate,
  }) {
    return Form(
      key: _formKey,
      autovalidateMode: autoValidate
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              const ApplicantInfoFormCard(),
              SizedBox(height: 20.h),
              const ContactAndDealerFormCard(),
              SizedBox(height: 20.h),
              const DealerProfileFormCard(),
              SizedBox(height: 20.h),
              const SurveyRecommendationFormCard(),
              SizedBox(height: 30.h),
              Consumer(
                builder: (context, ref, child) {
                  final isLoading =
                      ref.watch(
                        surveyFormControllerProvider(
                          widget.appId,
                        ).select((s) => s.value?.isSubmitting),
                      ) ??
                      false;
                  return CustomButton(
                    onPressed: isLoading
                        ? null
                        : () => _handleSubmit(controller),
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
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit(SurveyFormController controller) async {
    // Unfocus any active text field
    FocusScope.of(context).unfocus();

    bool? success;

    // Turn on auto-validation after first submit attempt
    if (!ref.read(autoValidateFormModeProvider)) {
      ref.read(autoValidateFormModeProvider.notifier).state = true;
    }

    // Validate form
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      // Submit form (validation happens inside too)
      success = await controller.submitSurveyForm();
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
