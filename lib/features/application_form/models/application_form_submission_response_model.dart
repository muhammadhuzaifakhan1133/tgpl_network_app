class ApplicationFormSubmissionResponseModel {
  final String message;
  final bool success;

  ApplicationFormSubmissionResponseModel({
    required this.message,
    required this.success,
  });

  factory ApplicationFormSubmissionResponseModel.fromJson(
      Map<String, dynamic> json) {
    return ApplicationFormSubmissionResponseModel(
      message: json['message'] as String,
      success: json['success'] as bool,
    );
  }
}