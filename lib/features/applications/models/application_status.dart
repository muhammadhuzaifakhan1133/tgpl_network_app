class ApplicationStatus {
  final String title;
  final bool status;
  final String dueDate;
  final String completedDate;

  ApplicationStatus({required this.title, required this.status, required this.dueDate, required this.completedDate});

  bool get isOverdue {
    if (dueDate.isEmpty || status) return false; // Not overdue if no due date or already completed
    final due = DateTime.tryParse(dueDate);
    if (due == null) return false; // Invalid date format, treat as not overdue
    return DateTime.now().isAfter(due);
  }

  bool get isInProgress {
    return !status && dueDate.isNotEmpty && !isOverdue;
  }
}