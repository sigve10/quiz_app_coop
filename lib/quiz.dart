import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quiz_app_coop/answer_set.dart';
import 'package:quiz_app_coop/question.dart';
import 'package:quiz_app_coop/question_set.dart';
import 'package:quiz_app_coop/result_manager.dart';
import 'package:quiz_app_coop/result_screen.dart';

/// This class represents a quiz made up of questions and answers.
class Quiz {
  final AnswerSet answerSet;
  final QuestionSet questionSet;

  Quiz(this.answerSet, this.questionSet);
  /// Renders [QuizWidget] with parameters [questionSet], and [answerSet]
  render() => QuizWidget(questionSet, answerSet);
}

/// Displays the quiz
class QuizWidget extends StatefulWidget {
  final QuestionSet questionSet;
  final AnswerSet answerSet;

  /// Constructor with [questionSet], [answerSet]
  const QuizWidget(
    this.questionSet,
    this.answerSet,
    {super.key}
  );

  @override
  State<StatefulWidget> createState() => QuizState();
}

/// Manage the state of quiz
class QuizState extends State<QuizWidget> {
  int questionIndex = 0;
  List<Question> get questions => widget.questionSet.questions;
  final ScrollController _scrollController = ScrollController();

  /// Decrease the current step with [setState] on [questionIndex]
  void _decreaseStep() {
    setState(() {
      questionIndex = max(0, questionIndex - 1);
    });
  }

  /// Increase the current step by one,
  /// checks if the quiz is on the last question. If so [_showResult]
  void _increaseStep() {
    setState(() {
      if (questionIndex == questions.length - 1) {
        _showResult();
      } else {
        questionIndex = min(questionIndex + 1, questions.length - 1);
      }
    });
  }

  /// Displays the result when [_showResult] is called.
  void _showResult() {
    int totalPoints = ResultManager().calcTotalPoints(widget.questionSet, widget.answerSet);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          resultScore: totalPoints,
          resetHandler: _resetQuiz,
        ),
      ),
    );
  }

  /// Resets [questionIndex] using method [reset] in [answer_set]
  void _resetQuiz() {
    setState(() {
      questionIndex = 0;
      widget.answerSet.reset();
    });
    Navigator.of(context).pop();
  }

  /// Set state for stepper [questionIndex]
  void _setStep(index) {
    setState(() {
      questionIndex = index;
    });
  }

  ///Set state for [_setAnswer] in [answerSet]
  void _setAnswer(int questionIndex, int answerIndex) {
    setState(() {
      widget.answerSet.setAnswer(questionIndex, answerIndex);
    });
  }

  /// Creates [stepper] with [questionIndex], [_decreaseStep], [_increaseStep], [_setStep]
  /// as it's variables
  Widget _createStepper() {
    return Stepper(
      controller: _scrollController,
      currentStep: questionIndex,
      onStepCancel: _decreaseStep,
      onStepContinue: _increaseStep,
      onStepTapped: _setStep,
      steps: [
        for (var (int index, Question question) in questions.indexed)
          Step(
            title: Text("Question $index"),
            content: question.render(
              (answerIdx) => _setAnswer(index, answerIdx)
            )
          )
      ]
    );
  }

  /// Builds the UI on the state of questions.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Quiz"),
      ),
      body: () {
        if (questions.isEmpty) {
          return const Text("Loading...");
        }
        return _createStepper();
      }()
    );
  }
}