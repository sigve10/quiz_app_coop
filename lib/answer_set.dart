class AnswerSet {
  late List<int> _answers;

  AnswerSet(int amount) {
    _answers = <int>[amount];
  }

  void setAnswer(int index, int alternative) {
    _answers[index] = alternative;
  }

  List<int> getAnswers() {
    return _answers;
  }
}