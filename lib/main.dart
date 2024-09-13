import 'package:flutter/material.dart';
import 'package:quiz_app_coop/Quiz.dart';
import 'package:quiz_app_coop/answer_set.dart';
import 'package:quiz_app_coop/question_set.dart';

// Majority of this code was provided by Android Studio's default flutter project.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final QuestionSet questionSet;
  late final AnswerSet answerSet;
  late final Quiz quiz;

  @override
  void initState() {
    questionSet = QuestionSet.import("assets/questions.json");
    answerSet = AnswerSet(questionSet.questions.length);
    quiz = Quiz(answerSet, questionSet);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child:
            quiz.render()


      )
    );
  }
}
