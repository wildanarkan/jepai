import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LetterPage extends StatefulWidget {
  const LetterPage({super.key});

  @override
  _LetterPageState createState() => _LetterPageState();
}

class _LetterPageState extends State<LetterPage> {
  // Abjad yang tersedia dengan bacaannya
  final Map<String, List<Map<String, String>>> _letters = {
    'Hiragana': [
      {'letter': 'あ', 'reading': 'a'},
      {'letter': 'い', 'reading': 'i'},
      {'letter': 'う', 'reading': 'u'},
      {'letter': 'え', 'reading': 'e'},
      {'letter': 'お', 'reading': 'o'},
      {'letter': 'か', 'reading': 'ka'},
      {'letter': 'き', 'reading': 'ki'},
      {'letter': 'く', 'reading': 'ku'},
      {'letter': 'け', 'reading': 'ke'},
      {'letter': 'こ', 'reading': 'ko'},
      {'letter': 'さ', 'reading': 'sa'},
      {'letter': 'し', 'reading': 'shi'},
      {'letter': 'す', 'reading': 'su'},
      {'letter': 'せ', 'reading': 'se'},
      {'letter': 'そ', 'reading': 'so'},
      {'letter': 'た', 'reading': 'ta'},
      {'letter': 'ち', 'reading': 'chi'},
      {'letter': 'つ', 'reading': 'tsu'},
      {'letter': 'て', 'reading': 'te'},
      {'letter': 'と', 'reading': 'to'},
      {'letter': 'な', 'reading': 'na'},
      {'letter': 'に', 'reading': 'ni'},
      {'letter': 'ぬ', 'reading': 'nu'},
      {'letter': 'ね', 'reading': 'ne'},
      {'letter': 'の', 'reading': 'no'},
      {'letter': 'は', 'reading': 'ha'},
      {'letter': 'ひ', 'reading': 'hi'},
      {'letter': 'ふ', 'reading': 'fu'},
      {'letter': 'へ', 'reading': 'he'},
      {'letter': 'ほ', 'reading': 'ho'},
      {'letter': 'ま', 'reading': 'ma'},
      {'letter': 'み', 'reading': 'mi'},
      {'letter': 'む', 'reading': 'mu'},
      {'letter': 'め', 'reading': 'me'},
      {'letter': 'も', 'reading': 'mo'},
      {'letter': 'や', 'reading': 'ya'},
      {'letter': 'ゆ', 'reading': 'yu'},
      {'letter': 'よ', 'reading': 'yo'},
      {'letter': 'ら', 'reading': 'ra'},
      {'letter': 'り', 'reading': 'ri'},
      {'letter': 'る', 'reading': 'ru'},
      {'letter': 'れ', 'reading': 're'},
      {'letter': 'ろ', 'reading': 'ro'},
      {'letter': 'わ', 'reading': 'wa'},
      {'letter': 'を', 'reading': 'wo'},
      {'letter': 'ん', 'reading': 'n'},
    ],
    'Katakana': [
      {'letter': 'ア', 'reading': 'a'},
      {'letter': 'イ', 'reading': 'i'},
      {'letter': 'ウ', 'reading': 'u'},
      {'letter': 'エ', 'reading': 'e'},
      {'letter': 'オ', 'reading': 'o'},
      {'letter': 'カ', 'reading': 'ka'},
      {'letter': 'キ', 'reading': 'ki'},
      {'letter': 'ク', 'reading': 'ku'},
      {'letter': 'ケ', 'reading': 'ke'},
      {'letter': 'コ', 'reading': 'ko'},
      {'letter': 'サ', 'reading': 'sa'},
      {'letter': 'シ', 'reading': 'shi'},
      {'letter': 'ス', 'reading': 'su'},
      {'letter': 'セ', 'reading': 'se'},
      {'letter': 'ソ', 'reading': 'so'},
      {'letter': 'タ', 'reading': 'ta'},
      {'letter': 'チ', 'reading': 'chi'},
      {'letter': 'ツ', 'reading': 'tsu'},
      {'letter': 'テ', 'reading': 'te'},
      {'letter': 'ト', 'reading': 'to'},
      {'letter': 'ナ', 'reading': 'na'},
      {'letter': 'ニ', 'reading': 'ni'},
      {'letter': 'ヌ', 'reading': 'nu'},
      {'letter': 'ネ', 'reading': 'ne'},
      {'letter': 'ノ', 'reading': 'no'},
      {'letter': 'ハ', 'reading': 'ha'},
      {'letter': 'ヒ', 'reading': 'hi'},
      {'letter': 'フ', 'reading': 'fu'},
      {'letter': 'ヘ', 'reading': 'he'},
      {'letter': 'ホ', 'reading': 'ho'},
      {'letter': 'マ', 'reading': 'ma'},
      {'letter': 'ミ', 'reading': 'mi'},
      {'letter': 'ム', 'reading': 'mu'},
      {'letter': 'メ', 'reading': 'me'},
      {'letter': 'モ', 'reading': 'mo'},
      {'letter': 'ヤ', 'reading': 'ya'},
      {'letter': 'ユ', 'reading': 'yu'},
      {'letter': 'ヨ', 'reading': 'yo'},
      {'letter': 'ラ', 'reading': 'ra'},
      {'letter': 'リ', 'reading': 'ri'},
      {'letter': 'ル', 'reading': 'ru'},
      {'letter': 'レ', 'reading': 're'},
      {'letter': 'ロ', 'reading': 'ro'},
      {'letter': 'ワ', 'reading': 'wa'},
      {'letter': 'ヲ', 'reading': 'wo'},
      {'letter': 'ン', 'reading': 'n'},
    ],
    'Kanji': [
      {'letter': '一', 'reading': 'ichi'},
      {'letter': '二', 'reading': 'ni'},
      {'letter': '三', 'reading': 'san'},
      {'letter': '四', 'reading': 'shi'},
      {'letter': '五', 'reading': 'go'},
      {'letter': '六', 'reading': 'roku'},
      {'letter': '七', 'reading': 'shichi'},
      {'letter': '八', 'reading': 'hachi'},
      {'letter': '九', 'reading': 'kyuu'},
      {'letter': '十', 'reading': 'juu'},
      {'letter': '日', 'reading': 'nichi'},
      {'letter': '月', 'reading': 'getsu'},
      {'letter': '火', 'reading': 'ka'},
      {'letter': '水', 'reading': 'sui'},
      {'letter': '木', 'reading': 'moku'},
      {'letter': '金', 'reading': 'kin'},
      {'letter': '土', 'reading': 'do'},
      {'letter': '山', 'reading': 'yama'},
      {'letter': '川', 'reading': 'kawa'},
      {'letter': '田', 'reading': 'ta'},
      {'letter': '人', 'reading': 'hito'},
      {'letter': '口', 'reading': 'kuchi'},
      {'letter': '目', 'reading': 'me'},
      {'letter': '耳', 'reading': 'mimi'},
      {'letter': '手', 'reading': 'te'},
      {'letter': '足', 'reading': 'ashi'},
      {'letter': '力', 'reading': 'chikara'},
      {'letter': '心', 'reading': 'kokoro'},
      {'letter': '空', 'reading': 'sora'},
      {'letter': '雨', 'reading': 'ame'},
    ],
  };

  late String _selectedAlphabet;

  @override
  void initState() {
    super.initState();
    _selectedAlphabet = Get.arguments ?? 'Hiragana';
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _letters[_selectedAlphabet]!.length,
                itemBuilder: (context, index) {
                  final letterInfo = _letters[_selectedAlphabet]![index];
                  return Container(
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
                              fontSize: 24, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          letterInfo['reading']!,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ],
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
