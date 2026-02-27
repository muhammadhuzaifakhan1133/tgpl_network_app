import 'package:tgpl_network/features/audit_perform/models/audit_question.dart';
import 'package:tgpl_network/features/audit_perform/models/question_type.dart';

class AuditPage {
  final int pageId;
  final String title;
  final int totalQuestions;
  final List<AuditQuestion> questions;

  AuditPage({
    required this.pageId,
    required this.title,
    this.questions = const [],
  }) : totalQuestions = questions.length;

  int get totalScoreQuestions {
    return questions
        .where((q) => q.options.any((o) => o.scoreValue > 0))
        .length;
  }

  int get totalScoredQuestions {
    int scoredQuestions = 0;
    // question with no condiiton + question with condition and condition is met
    for (var question in questions) {
      if (question.options.any((o) => o.scoreValue > 0)) {
        if (question.conditionQuestionId == null) {
          scoredQuestions++;
        } else {
          // find the condition question
          var conditionQuestion = questions.firstWhere(
            (q) => q.questionId == question.conditionQuestionId,
            orElse: () => AuditQuestion(
              questionId: -1,
              questionText: "",
              isRequired: false,
              questionType: QuestionType.shortText,
              pageId: pageId,
              order: 0,
            ),
          );
          if (conditionQuestion.questionId != -1) {
            // check if condition is met
            if (conditionQuestion.response.responseValue ==
                question.conditionQuestionResponseValue) {
              scoredQuestions++;
            }
          }
        }
      }
    }
    return scoredQuestions;
  }

  (int, int) get score {
    int totalScore = 0;
    int obtainedScore = 0;
    for (var question in questions) {
      for (var option in question.options) {
        if (option.scoreValue > 0) {
          totalScore += option.scoreValue;
          if (option.optionText == question.response.responseValue) {
            obtainedScore += option.scoreValue;
          }
        }
      }
    }
    return (totalScore, obtainedScore);
  }
}
