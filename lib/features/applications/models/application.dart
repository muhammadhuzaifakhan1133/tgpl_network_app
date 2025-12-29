import 'package:tgpl_network/features/applications/models/application_status.dart';

class Application {
  final String id;
  final String priority;
  final String name;
  final String city;
  final String date;

  Application({required this.id, required this.priority, required this.name, required this.city, required this.date});
}