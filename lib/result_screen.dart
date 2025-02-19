import 'package:flutter/material.dart';

/// Displays the result screen with [resultScore] and function [resetHandler]
class ResultScreen extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;

  const ResultScreen({super.key,
    required this.resultScore,
    required this.resetHandler,
  });

  /// Builds the result screen up with [resultScore]
  @override
  Widget build(BuildContext context) {
    String resultText = "Your score is $resultScore";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              resultText,
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetHandler,
              child: const Text('Retry Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
