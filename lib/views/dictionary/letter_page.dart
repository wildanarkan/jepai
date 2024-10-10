import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

class LetterPage extends StatefulWidget {
  const LetterPage({super.key});

  @override
  _LetterPageState createState() => _LetterPageState();
}

class _LetterPageState extends State<LetterPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late String _selectedAlphabet;
  Map<String, List<Map<String, String>>> _letters = {};

  @override
  void initState() {
    super.initState();
    _selectedAlphabet = Get.arguments ?? 'Hiragana';
    _loadLetterData();
  }

  Future<void> _loadLetterData() async {
    final String jsonString = await rootBundle.loadString('assets/data/letters.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    
    setState(() {
      _letters = jsonData.map((key, value) => MapEntry(
        key,
        (value as List<dynamic>).map((item) => Map<String, String>.from(item)).toList(),
      ));
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playAudio(String audioPath) async {
    await _audioPlayer.play(AssetSource(audioPath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Japanese Letters'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedAlphabet,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedAlphabet = newValue!;
                });
              },
              items: _letters.keys.map((String alphabet) {
                return DropdownMenuItem<String>(
                  value: alphabet,
                  child: Text(alphabet),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _letters.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: _letters[_selectedAlphabet]!.length,
                      itemBuilder: (context, index) {
                        final letterInfo = _letters[_selectedAlphabet]![index];
                        return GestureDetector(
                          onTap: () => letterInfo['audio'] != null 
                              ? _playAudio(letterInfo['audio']!)
                              : null,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  letterInfo['letter']!,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  letterInfo['reading']!,
                                  style: const TextStyle(
                                    fontSize: 12, 
                                    color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}