import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/common/widgets/custom_app_bar.dart';
import 'package:tgpl_network/common/widgets/custom_button.dart';
import 'package:tgpl_network/features/survey_form/presentation/survey_form_controller.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/application_info/applicant_info_form_card.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/contact_and_dealer/contact_and_dealer_form_card.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/dealer_profile/dealer_profile_form_card.dart';
import 'package:tgpl_network/features/survey_form/presentation/widgets/survey_recommendation/survey_recommendation_form_card.dart';

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
    // Load initial data if needed (for edit mode)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(surveyFormControllerProvider.notifier).initialize(widget.appId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(surveyFormControllerProvider);

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
                data: (_) => _buildForm(),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: $error'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref.refresh(surveyFormControllerProvider),
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

  Widget _buildForm() {
    final isSubmitting = ref.watch(
      surveyFormControllerProvider.select((state) => state.isLoading),
    );

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(20.0),
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
            onPressed: isSubmitting ? null : _handleSubmit,
            text: isSubmitting ? "Submitting..." : "Submit",
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> _handleSubmit() async {
    // Unfocus any active text field
    FocusScope.of(context).unfocus();

    // Validate form
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please correct the errors in the form.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Submit form
    final success = await ref
        .read(surveyFormControllerProvider.notifier)
        .submitSurveyForm();

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      // Navigate back or to success screen
      Navigator.of(context).pop(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to submit form. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}