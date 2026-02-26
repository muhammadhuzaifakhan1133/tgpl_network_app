class AuditQuestionOption {
  final String optionId;
  final String optionText;
  final int scoreValue;
  final bool isRedFlag;

  AuditQuestionOption({
    required this.optionId,
    required this.optionText,
    required this.scoreValue,
    required this.isRedFlag,
  });
}