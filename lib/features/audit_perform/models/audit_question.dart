import 'package:tgpl_network/features/audit_perform/models/audit_question_option.dart';
import 'package:tgpl_network/features/audit_perform/models/audit_question_response.dart';
import 'package:tgpl_network/features/audit_perform/models/question_type.dart';

class AuditQuestion {
  final int questionId;
  final String questionText;
  final bool isRequired;
  final QuestionType questionType;
  final List<AuditQuestionOption> options;
  final int pageId;
  final AuditQuestionResponse response;
  final int order;
  final int? conditionQuestionId;
  final String? conditionQuestionResponseValue;

  AuditQuestion({
    required this.questionId,
    required this.questionText,
    required this.isRequired,
    required this.questionType,
    this.options = const [],
    required this.pageId,
    AuditQuestionResponse? response,
    this.conditionQuestionId,
    this.conditionQuestionResponseValue,
    required this.order,
  }) : response = response ?? AuditQuestionResponse(questionId: questionId);
  // : questionType = getQuestionType(questionType);

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
      // case "checkbox": will be handled as multipleChoice (Yes/No)
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
