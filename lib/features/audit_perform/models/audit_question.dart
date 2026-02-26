import 'package:tgpl_network/features/audit_perform/models/audit_question_option.dart';
import 'package:tgpl_network/features/audit_perform/models/question_type.dart';

class AuditQuestion {
  final String questionId;
  final String questionText;
  final bool isRequired;
  final QuestionType questionType;
  final List<AuditQuestionOption> options;
  final int pageId;
  final int sectionId;

  AuditQuestion({
    required this.questionId,
    required this.questionText,
    required this.isRequired,
    required String questionType,
    this.options = const [],
    required this.pageId,
    required this.sectionId,
  }) : questionType = getQuestionType(questionType);

  static QuestionType getQuestionType(String questionType) {
    switch (questionType.toLowerCase()) {
      case "shorttext":
        return QuestionType.shortText;
      case "paragraph":
        return QuestionType.paragraph;
      case "number":
        return QuestionType.number;
      case "multiplechoice":
        return QuestionType.multipleChoice;
      case "multiplechoicemultiselection":
        return QuestionType.multipleChoiceMultiSelection;
      // case "checkbox": will be handled as multipleChoiceMultiSelection
      //   return QuestionType.checkbox;
      case "datetime":
        return QuestionType.datetime;
      case "media":
        return QuestionType.media;
      // case "slider": will be handled as number with specific options
      //   return QuestionType.slider;
      case "signature":
        return QuestionType.signature;
      case "location":
        return QuestionType.location;
      case "site":
        return QuestionType.site;
      case "preparedby":
        return QuestionType.preparedBy;
      default:
        throw Exception("Unknown question type: $questionType");
    }
  }
}