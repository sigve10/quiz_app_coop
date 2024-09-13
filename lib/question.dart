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

  Widget render(int selectedIdx, Function(int) onAnswerSelected) {
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
          ...List<Widget>.generate(alternatives.length, (index) {
            return RadioListTile<int>(
              title: Text(
                alternatives[index],
                style: const TextStyle(fontSize: 18),
              ),
              value: index,
              groupValue: selectedIdx,
              onChanged: (value) => onAnswerSelected(value!),
            );
          }),
        ],
      ),
    );
  }
}
