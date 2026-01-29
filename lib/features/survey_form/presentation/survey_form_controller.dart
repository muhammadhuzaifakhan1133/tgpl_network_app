import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/features/application_detail/data/application_detail_data_source.dart';
import 'package:tgpl_network/features/survey_form/data/survey_form_local_data_source.dart';
import 'package:tgpl_network/features/survey_form/data/survey_form_remote_data_source.dart';
import 'package:tgpl_network/features/survey_form/models/survey_form_model.dart';
import 'package:tgpl_network/features/survey_form/presentation/survey_form_assembler.dart';
import 'package:tgpl_network/utils/internet_connectivity.dart';

final surveyFormControllerProvider = AsyncNotifierProvider.family
    .autoDispose<SurveyFormController, SurveyFormModel, String>((
      applicationId,
    ) {
      return SurveyFormController(applicationId);
    });

final surveyFormSubmissionControllerProvider =
    AsyncNotifierProvider<SurveyFormSubmissionController, void>(
        SurveyFormSubmissionController.new);

class SurveyFormController extends AsyncNotifier<SurveyFormModel> {
  final String applicationId;

  SurveyFormController(this.applicationId);

  @override
  Future<SurveyFormModel> build() async {
    final surveyForm = await ref
        .read(surveyFormLocalDataSourceProvider)
        .getSingleSurveyForm(applicationId);
    if (surveyForm == null) {
      // Prefill all form controllers from application data
      final application = await ref
          .read(applicationDetailDataSourceProvider)
          .getApplicationDetail(applicationId);
      SurveyFormAssembler.dessembleFromApp(
        ref,
        application,
      ); // fill all form controllers
      return SurveyFormAssembler.assemble(ref);
    } else {
      // Prefill all form controllers from saved survey form
      SurveyFormAssembler.dessembleFromSurveyFormModel(ref, surveyForm);
      return surveyForm;
    }
  }
}

class SurveyFormSubmissionController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {}

  Future<bool> submitSurveyForm() async {
    try {
      // Gather all form data
      final surveyFormData = SurveyFormAssembler.assemble(ref);
      debugPrint('Survey Form Data: ${surveyFormData.toDatabaseMap()}');
      final validateMessage = surveyFormData.validate;
      if (validateMessage == null) {
        if (await InternetConnectivity.hasInternet()) {
          final response = await ref
              .read(surveyFormRemoteDataSourceProvider)
              .submitSurveyForm(surveyFormData);
          if (response.success) {
            return true;
          } else {
            state = AsyncValue.error(
              Exception('Submission failed: ${response.message}'),
              StackTrace.current,
            );
            return false;
          }
        } else {
          // Save locally if no internet
          await ref
              .read(surveyFormLocalDataSourceProvider)
              .saveSurveyForm(surveyFormData);
        }
        return true;
      } else {
        state = AsyncValue.error(validateMessage, StackTrace.current);
        return false;
      }
    } catch (e, s) {
      state = AsyncValue.error(e, s);
      return false;
    }
  }
}
