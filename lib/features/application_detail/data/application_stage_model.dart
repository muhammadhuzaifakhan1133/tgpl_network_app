import 'package:tgpl_network/features/applications/models/application_status.dart';
import 'package:tgpl_network/utils/extensions/datetime_extension.dart';

class ApplicationProgressSummary {
  final int totalStages;
  final int completedStages;
  final int pendingStages;
  final double completionPercentage;
  final List<ApplicationStageModel> stages;

  ApplicationProgressSummary({
    required this.totalStages,
    required this.completedStages,
    required this.pendingStages,
    required this.completionPercentage,
    required this.stages,
  });

  factory ApplicationProgressSummary.fromApplicationStatuses(List<ApplicationStatus> statuses) {
    
    final completedStages =
        statuses.where((status) => status.status).length;
    final pendingStages = statuses.where((status) => !status.status).length;
    final totalStages = statuses.length;
    final completionPercentage =
        totalStages > 0 ? (completedStages / totalStages) * 100 : 0;

    return ApplicationProgressSummary(
      totalStages: totalStages,
      completedStages: completedStages,
      pendingStages: pendingStages,
      completionPercentage: double.parse(completionPercentage.toStringAsFixed(0)),
      stages: statuses
          .asMap()
          .entries
          .map((entry) => ApplicationStageModel(
                stageName: entry.value.title,
                status: entry.value.status ? 'COMPLETED' : 'PENDING',
                dueDate: entry.value.dueDate.formatFromIsoToDDMMYYY(),
                completedDate: entry.value.completedDate.formatFromIsoToDDMMYYY(),
                orderIndex: entry.key + 1,
              ))
          .toList(),
    );
  }
}

class ApplicationStageModel {
  final String stageName;
  final String status; // COMPLETED, PENDING
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

  bool get isCompleted => status == 'COMPLETED';
  bool get isPending => status == 'PENDING';
}