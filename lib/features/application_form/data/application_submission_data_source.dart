import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tgpl_network/constants/app_apis.dart';
import 'package:tgpl_network/core/network/dio_client.dart';
import 'package:tgpl_network/features/application_form/models/applicaiton_form_model.dart';
import 'package:tgpl_network/features/application_form/models/application_form_submission_response_model.dart';

class ApplicationSubmissionDataSource {
  final DioClient _dioClient;
  ApplicationSubmissionDataSource(this._dioClient);

  Future<ApplicationFormSubmissionResponseModel> submitApplication(
    ApplicationFormModel data,
  ) async {
    final response = await _dioClient.post(
      AppApis.submitApplicationFormEndpoint,
      data: data.toApiMap(),
    );
    return ApplicationFormSubmissionResponseModel.fromJson(response.data);
  }
}

final applicationSubmissionDataSourceProvider = 
    Provider.autoDispose<ApplicationSubmissionDataSource>((ref) {
  final dioClient = ref.read(dioClientProvider);
  return ApplicationSubmissionDataSource(dioClient);
});
