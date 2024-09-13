/// Primarily a wrapper for [List] in order to hold answers to [Question]s.
class AnswerSet {
  late List<int> _answers;

  /// Creates a new answer set of length [amount].
  AnswerSet(int amount) {
    _answers = <int>[amount];
  }

  /// Sets the answer at [index] to the index [alternative],
  /// which should correspond to a [Question]'s option.
  void setAnswer(int index, int alternative) {
    answers[index] = alternative;
  }

  List<int> get answers => _answers;
}