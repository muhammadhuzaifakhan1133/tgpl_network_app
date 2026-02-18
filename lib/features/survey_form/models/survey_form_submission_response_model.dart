class SurveyFormSubmissionResponseModel {
  final String applicationId;
  final String message;
  final bool success;

  SurveyFormSubmissionResponseModel({
    required this.applicationId,
    required this.message,
    required this.success,
  });

  factory SurveyFormSubmissionResponseModel.fromJson(
      Map<String, dynamic> json) {
    return SurveyFormSubmissionResponseModel(
      applicationId: json['ApplicationId'].toString(),
      message: json['Message'] as String,
      success: json['Success'] as bool,
    );
  }
}