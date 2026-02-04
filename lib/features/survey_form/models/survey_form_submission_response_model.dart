class SurveyFormSubmissionResponseModel {
  final String message;
  final bool success;

  SurveyFormSubmissionResponseModel({
    required this.message,
    required this.success,
  });

  factory SurveyFormSubmissionResponseModel.fromJson(
      Map<String, dynamic> json) {
    return SurveyFormSubmissionResponseModel(
      message: json['message'] as String,
      success: json['success'] as bool,
    );
  }
}