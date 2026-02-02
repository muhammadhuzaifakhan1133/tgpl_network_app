import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:tgpl_network/features/application_detail/data/application_detail_data_source.dart';
import 'package:tgpl_network/features/data_sync/presentation/data_sync_controller.dart';
import 'package:tgpl_network/features/survey_form/data/survey_form_local_data_source.dart';
import 'package:tgpl_network/features/survey_form/data/survey_form_remote_data_source.dart';
import 'package:tgpl_network/features/survey_form/models/survey_form_model.dart';
import 'package:tgpl_network/features/survey_form/presentation/survey_form_assembler.dart';

final surveyFormControllerProvider = AsyncNotifierProvider.family
    .autoDispose<SurveyFormController, SurveyFormModel, String>((
      applicationId,
    ) {
      return SurveyFormController(applicationId);
    });

final surveyFormStatusChangedProvider = StateProvider.autoDispose.family<bool, String>((ref, applicationId) {
  return false;
});

class SurveyFormController extends AsyncNotifier<SurveyFormModel> {
  final String applicationId;

  SurveyFormController(this.applicationId);

  @override
  Future<SurveyFormModel> build() async {
    // Check if application status is still valid for survey form
    final application = await ref
        .read(applicationDetailDataSourceProvider)
        .getApplicationDetail(applicationId);
    
    // statusId should be less than 2 for survey form
    if ((application.statusId ?? 0) >= 2) {
      // Mark status as changed so UI can navigate back
      Future.microtask(() {
        ref.read(surveyFormStatusChangedProvider(applicationId).notifier).state = true;
      });
      throw Exception('Application status has changed. Survey form is no longer available.');
    }

    final surveyForm = await ref
        .read(surveyFormLocalDataSourceProvider)
        .getSingleSurveyForm(applicationId);
    
    if (surveyForm == null) {
      // Prefill all form controllers from application data
      SurveyFormAssembler.dessembleFromApp(
        ref,
        application,
      ); // fill all form controllers
      return SurveyFormAssembler.assemble(ref);
    } else {
      // Refill form controllers with updated application data
      // (in case data changed but status is still valid)
      SurveyFormAssembler.dessembleFromApp(ref, application);
      
      // Then overlay with saved form data
      SurveyFormAssembler.dessembleFromSurveyFormModel(ref, surveyForm);
      return surveyForm;
    }
  }

  Future<bool> isStatusValid() async {
    try {
      final application = await ref
          .read(applicationDetailDataSourceProvider)
          .getApplicationDetail(applicationId);
      return (application.statusId??0) < 2;
    } catch (e) {
      return false;
    }
  }

  Future<bool> submitSurveyForm() async {
    try {
      if (!await isStatusValid()) {
        state = AsyncValue.data(
          state.requireValue.copyWith(
            errorMessage: 'Application status has changed. Cannot submit form.',
          ),
        );
        ref.read(surveyFormStatusChangedProvider(applicationId).notifier).state = true;
        return false;
      }
      // Gather all form data
      final surveyFormData = SurveyFormAssembler.assemble(ref);
      debugPrint('Survey Form Data: ${surveyFormData.toDatabaseMap()}');
      final validateMessage = surveyFormData.validate;
      if (validateMessage != null) {
        state = AsyncValue.data(
          state.requireValue.copyWith(errorMessage: validateMessage),
        );
        return false;
      }
      state = AsyncValue.data(
        state.requireValue.copyWith(isSubmitting: true, errorMessage: null),
      );
      if (false) {
      // if (await InternetConnectivity.hasInternet()) {
        final response = await ref
            .read(surveyFormRemoteDataSourceProvider)
            .submitSurveyForm(surveyFormData);
        if (response.success) {
          // TODO: Remove local copy if any
          return true;
        } else {
          state = AsyncValue.data(
            state.requireValue.copyWith(
              errorMessage: 'Submission failed: ${response.message}',
              isSubmitting: false,
            ),
          );
          return false;
        }
      } else {
        // Save locally if no internet
        await ref
            .read(surveyFormLocalDataSourceProvider)
            .saveSurveyForm(surveyFormData);
        ref.invalidate(dataSyncControllerProvider);
      }
      return true;
    } catch (e, _) {
      state = AsyncValue.data(
        state.requireValue.copyWith(isSubmitting: false, errorMessage: 'An error occurred: $e'),
      );
      return false;
    }
  }
}
