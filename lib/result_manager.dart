import 'package:quiz_app_coop/answer_set.dart';
import 'package:quiz_app_coop/question.dart';
import 'package:quiz_app_coop/question_set.dart';

/// handles the [questionSet] and [answerSet] and calculate the total points with [calcTotalPoints]
class ResultManager {
  static int calcTotalPoints(QuestionSet questionSet, AnswerSet answerSet) {
    int totalPoints = 0;

    int length = questionSet.questions.length;
    for (int index = 0; index < length; index++) {
      Question question = questionSet.questions[index];
      int correctIndex = question.correctIndex;
      int selectedIndex = answerSet.answers[index];

      if (correctIndex == selectedIndex) {
        totalPoints += question.points;
      }
    }

    return totalPoints;
  }
}