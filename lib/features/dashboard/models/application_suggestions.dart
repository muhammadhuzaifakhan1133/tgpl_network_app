class ApplicationSuggestion {
  final String applicationId;
  final String applicantName;
  final String proposedSiteName;
  final int statusId;
  final String contactNumber;
  final String whatsAppNumber;

  ApplicationSuggestion({
    required this.applicationId,
    required this.applicantName,
    required this.proposedSiteName,
    required this.contactNumber,
    required this.whatsAppNumber,
    this.statusId = 0,
  });

  factory ApplicationSuggestion.fromJson(Map<String, dynamic> json) {
    return ApplicationSuggestion(
      applicationId: (json['applicationId'] ?? "").toString(),
      applicantName: (json['applicantName'] ?? "").toString(),
      proposedSiteName: (json['proposedSiteName1'] ?? "").toString(),
      statusId: json['statusId'] ?? 0,
      contactNumber: (json['contactNumber'] ?? "").toString(),
      whatsAppNumber: (json['whatsAppNumber'] ?? "").toString(),
    );
  }
}
