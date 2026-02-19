class ApplicationFormSubmissionResponseModel {
  final int applicationId;
  final String message;
  final bool success;

  ApplicationFormSubmissionResponseModel({
    required this.applicationId,
    required this.message,
    required this.success,
  });

  factory ApplicationFormSubmissionResponseModel.fromJson(
      Map<String, dynamic> json) {
    return ApplicationFormSubmissionResponseModel(
      applicationId: (json['Id'] ?? json['ApplicationId'] ?? 0) as int,
      message: (json['Message'] ?? "") as String,
      success: (json['Success'] ?? false) as bool,
    );
  }
}