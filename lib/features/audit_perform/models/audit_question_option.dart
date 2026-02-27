class AuditQuestionOption {
  final int optionId;
  final String optionText;
  final bool isRedFlag;
  final int scoreValue;
  AuditQuestionOption({
    required this.optionId,
    required this.optionText,
    int? scoreValue,
    bool? isRedFlag,
  }): scoreValue = scoreValue ?? 0,
      isRedFlag = isRedFlag ?? false;
}