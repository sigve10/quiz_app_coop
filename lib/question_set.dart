import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'question.dart';

/// A set of [Question]s. Used primarily as a [List] wrapper,
/// but also includes a [render] function.
class QuestionSet {
  late List<Question> _questions;

  /// Creates a new [QuestionSet] using a predefined list of [Question]s.
  QuestionSet(this._questions);

  /// Creates a new [QuestionSet] from a JSON file at [pathName].
  ///
  /// JSON file should have a structure like:
  /// ```
  /// "questions": [
  ///   {
  ///     "text": ...,
  ///     "options": [ "option", ... ],
  ///     "correctIndex": 5,
  ///     "points": 10
  ///   },
  ///   ...
  /// ]
  /// ```
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

  List<Question> get questions => _questions;
}