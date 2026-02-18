import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/constants/app_apis.dart';
import 'package:tgpl_network/core/network/dio_client.dart';
import 'package:tgpl_network/features/survey_form/models/survey_form_model.dart';
import 'package:tgpl_network/features/survey_form/models/survey_form_submission_response_model.dart';

class SurveyFormRemoteDataSource {
  final DioClient _dioClient;
  SurveyFormRemoteDataSource(this._dioClient);

  Future<List<SurveyFormSubmissionResponseModel>> submitSurveyForms(
    {required List<SurveyFormModel> surveyForms, int? userPositionId}
  ) async {
    final data = surveyForms.map((form) => form.toApiMap()).toList();
    for (var item in data) {
      item["userpositionId"] = userPositionId.toString();
    }
    final response = await _dioClient.post(
      AppApis.submitSurveyFormEndpoint,
      data: data,
    );
    List<SurveyFormSubmissionResponseModel> responses = [];
    for (var item in response.data) {
      responses.add(SurveyFormSubmissionResponseModel.fromJson(item));
    }
    return responses;
  }
}

final surveyFormRemoteDataSourceProvider = Provider<SurveyFormRemoteDataSource>(
  (ref) {
    final dioClient = ref.watch(dioClientProvider);
    return SurveyFormRemoteDataSource(dioClient);
  },
);
