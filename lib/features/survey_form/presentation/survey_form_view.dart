import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/constants/app_colors.dart';
import 'package:tgpl_network/features/survey_form/presentation/survey_form_controller.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/application_info/applicant_info_form_card.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/contact_and_dealer/contact_and_dealer_form_card.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/dealer_profile/dealer_profile_form_card.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/survey_recommendation/survey_recommendation_form_card.dart';
import 'package:tgpl_network/routes/app_router.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(surveyFormControllerProvider.notifier).initialize(widget.appId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(surveyFormControllerProvider);
    final controller = ref.read(surveyFormControllerProvider.notifier);

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            CustomAppBar(
              title: "Site Survey & Dealer Profile",
              subtitle: "Form # ${widget.appId}",
              showBackButton: true,
            ),
            Expanded(
              child: asyncValue.when(
                data: (_) => _buildForm(controller),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: $error'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            ref.refresh(surveyFormControllerProvider),
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

  Widget _buildForm(SurveyFormController controller) {
    final isSubmitting = ref.watch(
      surveyFormControllerProvider.select((state) => state.isLoading),
    );

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const ApplicantInfoFormCard(),
              const SizedBox(height: 20),
              const ContactAndDealerFormCard(),
              const SizedBox(height: 20),
              const DealerProfileFormCard(),
              const SizedBox(height: 20),
              const SurveyRecommendationFormCard(),
              const SizedBox(height: 30),
              CustomButton(
                onPressed: isSubmitting
                    ? null
                    : () => _handleSubmit(controller),
                text: isSubmitting ? "Submitting..." : "Submit",
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit(SurveyFormController controller) async {
    // Unfocus any active text field
    FocusScope.of(context).unfocus();

    bool? success ;
    
    // Validate form
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      success = await controller.submitSurveyForm();
      return;
    }


    if (!mounted) return;

    if (success == true) {
      showSnackBar(context, "Form submitted successfully!", bgColor: AppColors.onlineStatusColor);
      // Navigate back or to success screen
      ref.read(goRouterProvider).pop(true);
    } else {
      showSnackBar(context, 'Please correct the errors in the form.', bgColor: AppColors.emailUsIconColor);
    }
  }
}
