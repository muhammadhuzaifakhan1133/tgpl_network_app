import 'package:tgpl_network/features/audit_perform/models/audit_page.dart';
import 'package:tgpl_network/features/audit_perform/models/audit_question.dart';
import 'package:tgpl_network/features/audit_perform/models/audit_question_option.dart';
import 'package:tgpl_network/features/audit_perform/models/question_type.dart';

final List<AuditPage> auditPages = [
  AuditPage(
    pageId: 1,
    title: "Title Page",
    questions: [
      AuditQuestion(
        questionId: 1,
        questionText: "Site conducted",
        isRequired: true,
        questionType: QuestionType.site,
        pageId: 1,
        order: 1,
      ),
      AuditQuestion(
        questionId: 2,
        questionText: "Site Manager Name",
        isRequired: true,
        questionType: QuestionType.shortText,
        pageId: 1,
        order: 2,
      ),
      AuditQuestion(
        questionId: 3,
        questionText: "Conducted on",
        isRequired: true,
        questionType: QuestionType.datetime,
        pageId: 1,
        order: 3,
      ),
      AuditQuestion(
        questionId: 4,
        questionText: "Prepared by",
        isRequired: true,
        questionType: QuestionType.preparedBy,
        pageId: 1,
        order: 4,
      ),
      AuditQuestion(
        questionId: 5,
        questionText: "Location",
        isRequired: true,
        questionType: QuestionType.location,
        pageId: 1,
        order: 5,
      ),
      AuditQuestion(
        questionId: 6,
        questionText: "Take a selfie with the site in the background",
        isRequired: true,
        questionType: QuestionType.media,
        pageId: 1,
        order: 6,
      ),
    ],
  ),
  AuditPage(
    pageId: 2,
    title: "Mosque",
    questions: [
      AuditQuestion(
        questionId: 7,
        questionText: "Is Mosque available on site?",
        isRequired: true,
        questionType: QuestionType.multipleChoice,
        options: [
          AuditQuestionOption(optionId: 1, optionText: "Yes", scoreValue: 1),
          AuditQuestionOption(optionId: 2, optionText: "No", isRedFlag: true),
          AuditQuestionOption(optionId: 3, optionText: "N/A"),
        ],
        pageId: 2,
        order: 1,
      ),
      AuditQuestion(
        questionId: 8,
        questionText: "Mosque carpet is installed and clean",
        isRequired: false,
        questionType: QuestionType.multipleChoice,
        pageId: 2,
        order: 2,
        conditionQuestionId: 7,
        conditionQuestionResponseValue: "Yes",
      ),
      AuditQuestion(
        questionId: 9,
        questionText: "Picture of Mosque",
        isRequired: true,
        questionType: QuestionType.media,
        pageId: 2,
        order: 3,
        conditionQuestionId: 7,
        conditionQuestionResponseValue: "Yes",
      ),
    ],
  ),
];
