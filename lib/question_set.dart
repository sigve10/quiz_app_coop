import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'question.dart';

class QuestionSet {
  late List<Question> _questions;

  QuestionSet(this._questions);

  QuestionSet.import(String pathName) {
    _questions = <Question>[];

    _import(pathName).then(
      (data) {
        _questions = data;
      }
    );
  }

  Future<List<Question>> _import(pathName) async {
    List<Question> questions = <Question>[];

    String rawJson = await rootBundle.loadString(pathName);
    final Map<String, dynamic> data = await json.decode(rawJson);
    final container = data["questions"];

    for (dynamic item in container) {
      questions.add(
        Question(
          item["text"],
          List<String>.from(item["options"]),
          item["correctIndex"],
          item["points"]
        )
      );
    }

    return questions;
  }

  Widget render() {
    return Column(
      children: [
        for (Question question in _questions)
          question.render()
      ]
    );
  }
}