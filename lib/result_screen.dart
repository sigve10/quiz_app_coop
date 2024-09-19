import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int resultScore;
  final VoidCallback resetHandler;

  const ResultScreen({super.key,
    required this.resultScore,
    required this.resetHandler,
  });

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
