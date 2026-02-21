import 'dart:ui';

import 'package:tgpl_network/constants/app_colors.dart';

class ApplicationStatus {
  final String title;
  final bool _status;
  final String dueDate;
  final String completedDate;

  ApplicationStatus({
    required this.title,
    required bool status,
    required this.dueDate,
    required this.completedDate,
  }) : _status = status;

  bool get _isOverdue {
    if (dueDate.isEmpty || _status)
      return false; // Not overdue if no due date or already completed
    final due = DateTime.tryParse(dueDate);
    if (due == null) return false; // Invalid date format, treat as not overdue
    return DateTime.now().isAfter(due);
  }

  bool get _isInProgress {
    return !_status && dueDate.isNotEmpty && !_isOverdue;
  }

  ApplicationStatusType get status {
    if (_status) return ApplicationStatusType.completed;
    if (_isOverdue) return ApplicationStatusType.overdue;
    if (_isInProgress) return ApplicationStatusType.inProgress;
    return ApplicationStatusType.notStarted;
  }

  Color getStatusBackgroundColor([double opacity = 0.1]) {
    switch (status) {
      case ApplicationStatusType.completed:
        return AppColors.nextStep2Color.withOpacity(opacity);
      case ApplicationStatusType.overdue:
        return AppColors.emailUsIconColor.withOpacity(opacity);
      case ApplicationStatusType.inProgress:
        return AppColors.nextStep1Color.withOpacity(opacity);
      case ApplicationStatusType.notStarted:
        return AppColors.inactiveStatusColor.withOpacity(opacity);
    }
  }

  String getStatusText() {
    switch (status) {
      case ApplicationStatusType.completed:
        return "Completed";
      case ApplicationStatusType.overdue:
        return "Overdue";
      case ApplicationStatusType.inProgress:
        return "In Progress";
      case ApplicationStatusType.notStarted:
        return "Not Started";
    }
  }
}

enum ApplicationStatusType { completed, inProgress, overdue, notStarted }
