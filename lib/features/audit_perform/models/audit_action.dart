class AuditAction {
  final int inspectionId;
  final int questionId;
  final String title;
  final String description;
  final String priority;
  final String dueDate;
  final String assignedTo;
  final String siteId;

  AuditAction({
    required this.inspectionId,
    required this.questionId,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    required this.assignedTo,
    required this.siteId,
  });

}