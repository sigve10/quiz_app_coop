/// Primarily a wrapper for [List] in order to hold answers to [Question]s.
class AnswerSet {
  late List<int> _answers;

  /// Creates a new answer set with the specified [amount] of answers.
  AnswerSet(int amount) {
    _answers = List.filled(amount, -1);
  }

  /// Sets the answer at [index] to [alternative],
  /// which should correspond to a [Question]'s option.
  void setAnswer(int index, int alternative) {
    _answers[index] = alternative;
  }

  List<int> get answers => _answers;

  void reset() {
    _answers = List.filled(_answers.length, -1);
  }
}
