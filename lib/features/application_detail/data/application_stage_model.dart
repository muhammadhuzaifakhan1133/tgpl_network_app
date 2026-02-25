import 'package:tgpl_network/features/applications/models/application_status.dart';
import 'package:tgpl_network/utils/extensions/datetime_extension.dart';

class ApplicationProgressSummary {
  final int totalStages;
  final int completedCount;
  final int notStartedCount;
  final int inProgressCount;
  final int overdueCount;
  final double completionPercentage;
  final List<ApplicationStageModel> stages;

  ApplicationProgressSummary({
    required this.totalStages,
    required this.completedCount,
    required this.notStartedCount,
    required this.inProgressCount,
    required this.overdueCount,
    required this.completionPercentage,
    required this.stages,
  });

  factory ApplicationProgressSummary.fromApplicationStatuses(
    List<ApplicationStatus> statuses,
  ) {
    final completedCount = statuses
        .where((status) => status.status == ApplicationStatusType.completed)
        .length;
    final notStartedCount = statuses
        .where((status) => status.status == ApplicationStatusType.notStarted)
        .length;
    final inProgressCount = statuses
        .where((status) => status.status == ApplicationStatusType.inProgress)
        .length;
    final overdueCount = statuses
        .where((status) => status.status == ApplicationStatusType.overdue)
        .length;
    final totalStages = statuses.length;
    final completionPercentage = totalStages > 0
        ? (completedCount / totalStages) * 100
        : 0;
        
    return ApplicationProgressSummary(
      totalStages: totalStages,
      completedCount: completedCount,
      notStartedCount: notStartedCount,
      inProgressCount: inProgressCount,
      overdueCount: overdueCount,
      completionPercentage: double.parse(
        completionPercentage.toStringAsFixed(0),
      ),
      stages: statuses
          .asMap()
          .entries
          .map(
            (entry) => ApplicationStageModel(
              stageName: entry.value.title,
              status: entry.value,
              dueDate: entry.value.dueDate.formatFromIsoToDDMMYYY(),
              completedDate: entry.value.completedDate.formatFromIsoToDDMMYYY(),
              orderIndex: entry.key + 1,
            ),
          )
          .toList(),
    );
  }
}

class ApplicationStageModel {
  final String stageName;
  final ApplicationStatus status; // COMPLETED, PENDING
  final String? dueDate;
  final String? completedDate;
  final int orderIndex;

  ApplicationStageModel({
    required this.stageName,
    required this.status,
    this.dueDate,
    this.completedDate,
    required this.orderIndex,
  });
}
