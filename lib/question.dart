import 'package:flutter/material.dart';

class Question {
  final String questionText;
  final List<String> alternatives;
  final int correctIndex;
  final int points;

  const Question(
    this.questionText,
    this.alternatives,
    this.correctIndex,
    this.points
  );

  Widget render() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Text(
        questionText,
        style: const TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
