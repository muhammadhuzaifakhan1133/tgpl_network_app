import 'package:tgpl_network/features/data_sync/presentation/widgets/sync_list_section.dart';
import 'package:tgpl_network/features/survey_form/models/survey_form_model.dart';
import 'package:tgpl_network/features/traffic_trade_form/models/traffic_trade_form_model.dart';

class SyncItem {
  final String id;
  final String title;
  final String subtitle;
  final SyncItemStatus status;
  final SurveyFormModel? surveyForm;
  final TrafficTradeFormModel? trafficTradeForm;
  final DateTime? date;

  const SyncItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.status,
    this.surveyForm,
    this.trafficTradeForm,
    this.date,
  });

  SyncItem copyWith({
    String? title,
    String? subtitle,
    SyncItemStatus? status,
    SurveyFormModel? surveyForm,
    TrafficTradeFormModel? trafficTradeForm,
  }) {
    return SyncItem(
      id: id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      status: status ?? this.status,
      surveyForm: surveyForm ?? this.surveyForm,
      trafficTradeForm: trafficTradeForm ?? this.trafficTradeForm,
    );
  }
}
