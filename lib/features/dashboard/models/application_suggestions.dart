class ApplicationSuggestion {
  final String applicationId;
  final String applicantName;
  final String proposedSiteName;

  ApplicationSuggestion({
    required this.applicationId,
    required this.applicantName,
    required this.proposedSiteName,
  });

  factory ApplicationSuggestion.fromJson(Map<String, dynamic> json) {
    return ApplicationSuggestion(
      applicationId: (json['applicationId'] ?? "").toString(),
      applicantName: (json['applicantName'] ?? "").toString(),
      proposedSiteName: (json['proposedSiteName1'] ?? "").toString(),
    );
  }
}
