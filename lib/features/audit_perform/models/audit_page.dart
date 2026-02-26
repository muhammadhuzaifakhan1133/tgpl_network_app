import 'package:tgpl_network/features/audit_perform/models/audit_question.dart';
import 'package:tgpl_network/features/audit_perform/models/audit_section.dart';

class AuditPage {
  final int pageId;
  final String title;
  final int totalQuestions;
  final List<AuditSection> sections;
  final List<AuditQuestion> questions;

  AuditPage({
    required this.pageId,
    required this.title,
    this.sections = const [],
    this.questions = const [],
  }): totalQuestions = questions.length;
}