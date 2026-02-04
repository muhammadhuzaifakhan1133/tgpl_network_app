class TrafficTradeFormSubmissionResponseModel {
  final String message;
  final bool success;

  TrafficTradeFormSubmissionResponseModel({
    required this.message,
    required this.success,
  });

  factory TrafficTradeFormSubmissionResponseModel.fromJson(
      Map<String, dynamic> json) {
    return TrafficTradeFormSubmissionResponseModel(
      message: json['message'] as String,
      success: json['success'] as bool,
    );
  }
}