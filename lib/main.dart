import 'package:flutter/material.dart';
import 'package:quiz_app_coop/Quiz.dart';
import 'package:quiz_app_coop/answer_set.dart';
import 'package:quiz_app_coop/front_page.dart';
import 'package:quiz_app_coop/question_set.dart';

// Majority of this code was provided by Android Studio's default flutter project.

void main() {
  runApp(const MainApp());
}

/// The main widget of the application.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PageContainer(title: "Quiz App: Assignment 1"),
    );
  }
}

/// The main material page container for the app
class PageContainer extends StatefulWidget {
  const PageContainer({super.key, required this.title});
  final String title;

  @override
  State<PageContainer> createState() => _PageContainerState();
}

/// State of the page container. Responsible for loading questions from
/// file before rendering anything.
class _PageContainerState extends State<PageContainer> {
  Quiz? quiz;
  bool isLoading = false;

  void lateLoader() {
    QuestionSet.awaitCreateFromImport("assets/questions.json")
      .then((questionSet) {
        AnswerSet answerSet = AnswerSet(questionSet.questions.length);
        setState(() {
          quiz = Quiz(answerSet, questionSet);
          isLoading = false;
        });
      });
  }

  @override
  void initState() {
    lateLoader();
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
        child: () {
          if (quiz != null) {
            return FrontPage(quiz!);
          }
          return const Text("Loading...");
        }()
      )
    );
  }
}
