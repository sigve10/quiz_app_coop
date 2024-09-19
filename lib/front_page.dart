import 'package:flutter/material.dart';
import 'package:quiz_app_coop/Quiz.dart';

class FrontPage extends StatelessWidget {
  const FrontPage(
    this.quiz,
    { super.key }
  );

  final Quiz quiz;

  void _goToQuizScreen(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder:
        (context) => quiz.render()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => _goToQuizScreen(context),
        child: const Text("Start Quiz")
      )
    );
  }
}