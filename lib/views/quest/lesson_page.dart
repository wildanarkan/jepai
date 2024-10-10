import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  List<Map<String, String>> letters = [];
  int progress = 0;
  int currentLetterIndex = 0;
  String type = '';

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments as Map;
    type = arguments['type'];
    progress = arguments['progress'];
    _loadLetterData();
  }

  Future<void> _loadLetterData() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/letters.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    setState(() {
      letters = (jsonData[type] as List<dynamic>)
          .map((item) => Map<String, String>.from(item))
          .toList();

      int startIndex = progress * 5;
      int endIndex = startIndex + 5;
      
      if (type == 'Hiragana' || type == 'Katakana') {
        if (startIndex == 40) {
          endIndex = startIndex + 6;
        }
      } else if (type == 'Kanji') {
        endIndex = min(startIndex + 5, letters.length);
      }
      
      letters = letters.sublist(startIndex, endIndex);
    });
  }

  void _playAudio() async {
    String? audioPath = letters[currentLetterIndex]['audio'];
    if (audioPath != null) {
      await _audioPlayer.play(AssetSource(audioPath));
    }
  }

  void _nextLetter() {
    setState(() {
      if (currentLetterIndex < letters.length - 1) {
        currentLetterIndex++;
      } else {
        Get.toNamed('/quest/quiz', arguments: {
          'type': type,
          'letters': letters,
        });
      }
    });
  }

  void _previousLetter() {
    setState(() {
      if (currentLetterIndex > 0) {
        currentLetterIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$type Lesson'),
      ),
      body: letters.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  letters[currentLetterIndex]['letter'] ?? '',
                  style: const TextStyle(fontSize: 64),
                ),
                const SizedBox(height: 20),
                Text(
                  letters[currentLetterIndex]['reading'] ?? '',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _playAudio,
                  child: const Icon(Icons.volume_up),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _previousLetter,
                      child: const Text('Back'),
                    ),
                    ElevatedButton(
                      onPressed: _nextLetter,
                      child: Text(
                        currentLetterIndex < letters.length - 1
                            ? 'Next'
                            : 'Start Quiz',
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}