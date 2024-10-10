import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<Map<String, String>> letters = [];
  String type = '';
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  List<String> options = [];
  int correctAnswers = 0;
  late List<int> shuffledIndices;

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments as Map;
    type = arguments['type'];
    letters = List<Map<String, String>>.from(arguments['letters']);
    _shuffleQuestions();
    _generateOptions();
  }

  void _shuffleQuestions() {
    shuffledIndices = List<int>.generate(letters.length, (index) => index);
    shuffledIndices.shuffle();
  }

  void _generateOptions() {
    final correctAnswer =
        letters[shuffledIndices[currentQuestionIndex]]['reading']!;
    options = [correctAnswer];

    while (options.length < 3) {
      final randomLetter = letters[Random().nextInt(letters.length)];
      final randomOption = randomLetter['reading']!;
      if (!options.contains(randomOption)) {
        options.add(randomOption);
      }
    }

    options.shuffle();
  }

  void _submitAnswer() {
    if (selectedAnswer == null) return;

    final correctAnswer =
        letters[shuffledIndices[currentQuestionIndex]]['reading']!;
    if (selectedAnswer == correctAnswer) {
      correctAnswers++;
    }

    if (currentQuestionIndex < letters.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        _generateOptions();
      });
    } else {
      _showQuizResultDialog();
    }
  }

  void _showQuizResultDialog() {
  final bool allCorrect = correctAnswers == letters.length;
  Get.defaultDialog(
    title: 'Quiz Completed',
    content: Text('You got $correctAnswers out of ${letters.length} correct!'),
    actions: [
      if (allCorrect)
        ElevatedButton(
          onPressed: () {
            Get.back(); // Close dialog
            Get.back(); // Close dialog
            Get.back(result: true); // Close quiz page and return result
          },
          child: const Text('OK'),
        )
      else
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.back(); // Close dialog
                Get.back(); // Return to lesson page
              },
              child: const Text('Back to Lesson'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back(); // Close dialog
                _resetQuiz();
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
    ],
  );
}

  void _resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      selectedAnswer = null;
      correctAnswers = 0;
      _shuffleQuestions();
      _generateOptions();
    });
  }

  void _playAudio() async {
    String? audioPath = letters[shuffledIndices[currentQuestionIndex]]['audio'];
    if (audioPath != null) {
      await _audioPlayer.play(AssetSource(audioPath));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$type Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1} of ${letters.length}',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'What is the reading for this character?',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              letters[shuffledIndices[currentQuestionIndex]]['letter']!,
              style: const TextStyle(fontSize: 64),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _playAudio,
              child: const Icon(Icons.volume_up),
            ),
            const SizedBox(height: 20),
            ...options.map((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: selectedAnswer,
                onChanged: (value) {
                  setState(() {
                    selectedAnswer = value;
                  });
                },
              );
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitAnswer,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
