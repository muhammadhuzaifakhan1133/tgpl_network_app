import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/constants/app_apis.dart';
import 'package:tgpl_network/core/network/dio_client.dart';
import 'package:tgpl_network/features/survey_form/models/survey_form_model.dart';
import 'package:tgpl_network/features/survey_form/models/survey_form_submission_response_model.dart';

class SurveyFormRemoteDataSource {
  final DioClient _dioClient;
  SurveyFormRemoteDataSource(this._dioClient);

  Future<SurveyFormSubmissionResponseModel?> submitSurveyForm(
    SurveyFormModel surveyForm,
  ) async {
    final response = await _dioClient.post(
      AppApis.submitSurveyFormEndpoint,
      data: surveyForm.toApiMap(),
    );
    if (response.statusCode == 200) {
      return SurveyFormSubmissionResponseModel.fromJson(response.data);
    }
    return null;
  }
}

final surveyFormRemoteDataSourceProvider = Provider<SurveyFormRemoteDataSource>(
  (ref) {
    final dioClient = ref.watch(dioClientProvider);
    return SurveyFormRemoteDataSource(dioClient);
  },
);
