class TrafficTradeFormSubmissionResponseModel {
  final String applicationId;
  final String message;
  final bool success;

  TrafficTradeFormSubmissionResponseModel({
    required this.applicationId,
    required this.message,
    required this.success,
  });

  factory TrafficTradeFormSubmissionResponseModel.fromJson(
      Map<String, dynamic> json) {
    return TrafficTradeFormSubmissionResponseModel(
      applicationId: json['ApplicationId'].toString(),
      message: json['Message'] as String,
      success: json['Success'] as bool,
    );
  }
}