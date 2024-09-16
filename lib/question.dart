import 'package:flutter/material.dart';

class Question {
  final String questionText;
  final List<String> alternatives;
  final int correctIndex;
  final int points;

  Question(
      this.questionText,
      this.alternatives,
      this.correctIndex,
      this.points
      );

  Widget render(Function(int) onAnswerSelected) {
    return QuestionWidget(onAnswerSelected, this);
  }
}

class QuestionWidget extends StatefulWidget {
  final Question question;

  final Function onAnswerSelected;

  const QuestionWidget(
      this.onAnswerSelected,
      this.question,
      { super.key }
      );

  @override
  State<StatefulWidget> createState() => QuestionState();
}

class QuestionState extends State <QuestionWidget> {
  int? selectedIdx;

  String get questionText => widget.question.questionText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            questionText,
            style: const TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ...List<Widget>.generate(widget.question.alternatives.length, (index) {
            return RadioListTile<int>(
              title: Text(
                widget.question.alternatives[index],
                style: const TextStyle(fontSize: 18),
              ),
              value: index,
              groupValue: selectedIdx,
              onChanged: (value) {
                setState(() {
                  selectedIdx = value;
                });
                widget.onAnswerSelected(value!);
              }
            );
          }),
        ],
      ),
    );
  }

}