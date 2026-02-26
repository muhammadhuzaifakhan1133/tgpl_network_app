import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tgpl_network/features/audit_perform/models/audit_action.dart';

class AuditQuestionResponse {
  final String questionId;
  final List<AuditAction> actions;
  final List<File> mediaFiles;
  final String note;
  final String response;
  final LatLng? location;

  AuditQuestionResponse({
    required this.questionId,
    required this.response,
    this.actions = const [],
    this.mediaFiles = const [],
    this.note = '',
    this.location,
  });
}