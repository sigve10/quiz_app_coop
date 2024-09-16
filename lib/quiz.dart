import 'dart:math';

import 'package:flutter/material.dart';
import 'package:quiz_app_coop/answer_set.dart';
import 'package:quiz_app_coop/question.dart';
import 'package:quiz_app_coop/question_set.dart';

class Quiz {
  final AnswerSet answerSet;
  final QuestionSet questionSet;

  Quiz(this.answerSet, this.questionSet);

  render() => QuizWidget(questionSet, answerSet);
}

class QuizWidget extends StatefulWidget {
  final QuestionSet questionSet;
  final AnswerSet answerSet;

  const QuizWidget(
    this.questionSet,
    this.answerSet,
    {super.key}
  );

  @override
  State<StatefulWidget> createState() => QuizState();
}

class QuizState extends State<QuizWidget> {
  int questionIndex = 0;
  List<Question> get questions => widget.questionSet.questions;

  void _decreaseStep() {
    setState(() {
      questionIndex = max(1, questionIndex - 1);
    });
  }

  void _increaseStep() {
    setState(() {
      questionIndex = min(
        questionIndex + 1,
        questions.length
      );
    });
  }

  void _setStep(index) {
    setState(() {
      questionIndex = index;
    });
  }

  void _setAnswer(int questionIndex, int answerIndex) {
    setState(() {
      widget.answerSet.setAnswer(questionIndex, answerIndex);
    });
  }

  Widget _createStepper() {
    return Stepper(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        if (questions.isNotEmpty)
          _createStepper()
      ],)
    );
  }
}