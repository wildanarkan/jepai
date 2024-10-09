import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LetterPage extends StatefulWidget {
  const LetterPage({super.key});

  @override
  _LetterPageState createState() => _LetterPageState();
}

class _LetterPageState extends State<LetterPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Abjad yang tersedia dengan bacaan dan path file suara
 final Map<String, List<Map<String, String>>> _letters = {
  'Hiragana': [
    {'letter': 'あ', 'reading': 'a', 'audio': 'audio/hiragana/hiragana_a.mp3'},
    {'letter': 'い', 'reading': 'i', 'audio': 'audio/hiragana/hiragana_i.mp3'},
    {'letter': 'う', 'reading': 'u', 'audio': 'audio/hiragana/hiragana_u.mp3'},
    {'letter': 'え', 'reading': 'e', 'audio': 'audio/hiragana/hiragana_e.mp3'},
    {'letter': 'お', 'reading': 'o', 'audio': 'audio/hiragana/hiragana_o.mp3'},
    {'letter': 'か', 'reading': 'ka', 'audio': 'audio/hiragana/hiragana_ka.mp3'},
    {'letter': 'き', 'reading': 'ki', 'audio': 'audio/hiragana/hiragana_ki.mp3'},
    {'letter': 'く', 'reading': 'ku', 'audio': 'audio/hiragana/hiragana_ku.mp3'},
    {'letter': 'け', 'reading': 'ke', 'audio': 'audio/hiragana/hiragana_ke.mp3'},
    {'letter': 'こ', 'reading': 'ko', 'audio': 'audio/hiragana/hiragana_ko.mp3'},
    {'letter': 'さ', 'reading': 'sa', 'audio': 'audio/hiragana/hiragana_sa.mp3'},
    {'letter': 'し', 'reading': 'shi', 'audio': 'audio/hiragana/hiragana_shi.mp3'},
    {'letter': 'す', 'reading': 'su', 'audio': 'audio/hiragana/hiragana_su.mp3'},
    {'letter': 'せ', 'reading': 'se', 'audio': 'audio/hiragana/hiragana_se.mp3'},
    {'letter': 'そ', 'reading': 'so', 'audio': 'audio/hiragana/hiragana_so.mp3'},
    {'letter': 'た', 'reading': 'ta', 'audio': 'audio/hiragana/hiragana_ta.mp3'},
    {'letter': 'ち', 'reading': 'chi', 'audio': 'audio/hiragana/hiragana_chi.mp3'},
    {'letter': 'つ', 'reading': 'tsu', 'audio': 'audio/hiragana/hiragana_tsu.mp3'},
    {'letter': 'て', 'reading': 'te', 'audio': 'audio/hiragana/hiragana_te.mp3'},
    {'letter': 'と', 'reading': 'to', 'audio': 'audio/hiragana/hiragana_to.mp3'},
    {'letter': 'な', 'reading': 'na', 'audio': 'audio/hiragana/hiragana_na.mp3'},
    {'letter': 'に', 'reading': 'ni', 'audio': 'audio/hiragana/hiragana_ni.mp3'},
    {'letter': 'ぬ', 'reading': 'nu', 'audio': 'audio/hiragana/hiragana_nu.mp3'},
    {'letter': 'ね', 'reading': 'ne', 'audio': 'audio/hiragana/hiragana_ne.mp3'},
    {'letter': 'の', 'reading': 'no', 'audio': 'audio/hiragana/hiragana_no.mp3'},
    {'letter': 'は', 'reading': 'ha', 'audio': 'audio/hiragana/hiragana_ha.mp3'},
    {'letter': 'ひ', 'reading': 'hi', 'audio': 'audio/hiragana/hiragana_hi.mp3'},
    {'letter': 'ふ', 'reading': 'fu', 'audio': 'audio/hiragana/hiragana_fu.mp3'},
    {'letter': 'へ', 'reading': 'he', 'audio': 'audio/hiragana/hiragana_he.mp3'},
    {'letter': 'ほ', 'reading': 'ho', 'audio': 'audio/hiragana/hiragana_ho.mp3'},
    {'letter': 'ま', 'reading': 'ma', 'audio': 'audio/hiragana/hiragana_ma.mp3'},
    {'letter': 'み', 'reading': 'mi', 'audio': 'audio/hiragana/hiragana_mi.mp3'},
    {'letter': 'む', 'reading': 'mu', 'audio': 'audio/hiragana/hiragana_mu.mp3'},
    {'letter': 'め', 'reading': 'me', 'audio': 'audio/hiragana/hiragana_me.mp3'},
    {'letter': 'も', 'reading': 'mo', 'audio': 'audio/hiragana/hiragana_mo.mp3'},
    {'letter': 'ら', 'reading': 'ra', 'audio': 'audio/hiragana/hiragana_ra.mp3'},
    {'letter': 'り', 'reading': 'ri', 'audio': 'audio/hiragana/hiragana_ri.mp3'},
    {'letter': 'る', 'reading': 'ru', 'audio': 'audio/hiragana/hiragana_ru.mp3'},
    {'letter': 'れ', 'reading': 're', 'audio': 'audio/hiragana/hiragana_re.mp3'},
    {'letter': 'ろ', 'reading': 'ro', 'audio': 'audio/hiragana/hiragana_ro.mp3'},
    {'letter': 'や', 'reading': 'ya', 'audio': 'audio/hiragana/hiragana_ya.mp3'},
    {'letter': 'ゆ', 'reading': 'yu', 'audio': 'audio/hiragana/hiragana_yu.mp3'},
    {'letter': 'よ', 'reading': 'yo', 'audio': 'audio/hiragana/hiragana_yo.mp3'},
    {'letter': 'わ', 'reading': 'wa', 'audio': 'audio/hiragana/hiragana_wa.mp3'},
    {'letter': 'を', 'reading': 'wo', 'audio': 'audio/hiragana/hiragana_wo.mp3'},
    {'letter': 'ん', 'reading': 'n', 'audio': 'audio/hiragana/hiragana_n.mp3'},
  ],
  'Katakana': [
    {'letter': 'ア', 'reading': 'a', 'audio': 'audio/katakana/katakana_a.mp3'},
    {'letter': 'イ', 'reading': 'i', 'audio': 'audio/katakana/katakana_i.mp3'},
    {'letter': 'ウ', 'reading': 'u', 'audio': 'audio/katakana/katakana_u.mp3'},
    {'letter': 'エ', 'reading': 'e', 'audio': 'audio/katakana/katakana_e.mp3'},
    {'letter': 'オ', 'reading': 'o', 'audio': 'audio/katakana/katakana_o.mp3'},
    {'letter': 'カ', 'reading': 'ka', 'audio': 'audio/katakana/katakana_ka.mp3'},
    {'letter': 'キ', 'reading': 'ki', 'audio': 'audio/katakana/katakana_ki.mp3'},
    {'letter': 'ク', 'reading': 'ku', 'audio': 'audio/katakana/katakana_ku.mp3'},
    {'letter': 'ケ', 'reading': 'ke', 'audio': 'audio/katakana/katakana_ke.mp3'},
    {'letter': 'コ', 'reading': 'ko', 'audio': 'audio/katakana/katakana_ko.mp3'},
    {'letter': 'サ', 'reading': 'sa', 'audio': 'audio/katakana/katakana_sa.mp3'},
    {'letter': 'シ', 'reading': 'shi', 'audio': 'audio/katakana/katakana_shi.mp3'},
    {'letter': 'ス', 'reading': 'su', 'audio': 'audio/katakana/katakana_su.mp3'},
    {'letter': 'セ', 'reading': 'se', 'audio': 'audio/katakana/katakana_se.mp3'},
    {'letter': 'ソ', 'reading': 'so', 'audio': 'audio/katakana/katakana_so.mp3'},
    {'letter': 'タ', 'reading': 'ta', 'audio': 'audio/katakana/katakana_ta.mp3'},
    {'letter': 'チ', 'reading': 'chi', 'audio': 'audio/katakana/katakana_chi.mp3'},
    {'letter': 'ツ', 'reading': 'tsu', 'audio': 'audio/katakana/katakana_tsu.mp3'},
    {'letter': 'テ', 'reading': 'te', 'audio': 'audio/katakana/katakana_te.mp3'},
    {'letter': 'ト', 'reading': 'to', 'audio': 'audio/katakana/katakana_to.mp3'},
    {'letter': 'ナ', 'reading': 'na', 'audio': 'audio/katakana/katakana_na.mp3'},
    {'letter': 'ニ', 'reading': 'ni', 'audio': 'audio/katakana/katakana_ni.mp3'},
    {'letter': 'ヌ', 'reading': 'nu', 'audio': 'audio/katakana/katakana_nu.mp3'},
    {'letter': 'ネ', 'reading': 'ne', 'audio': 'audio/katakana/katakana_ne.mp3'},
    {'letter': 'ノ', 'reading': 'no', 'audio': 'audio/katakana/katakana_no.mp3'},
    {'letter': 'ハ', 'reading': 'ha', 'audio': 'audio/katakana/katakana_ha.mp3'},
    {'letter': 'ヒ', 'reading': 'hi', 'audio': 'audio/katakana/katakana_hi.mp3'},
    {'letter': 'フ', 'reading': 'fu', 'audio': 'audio/katakana/katakana_fu.mp3'},
    {'letter': 'ヘ', 'reading': 'he', 'audio': 'audio/katakana/katakana_he.mp3'},
    {'letter': 'ホ', 'reading': 'ho', 'audio': 'audio/katakana/katakana_ho.mp3'},
    {'letter': 'マ', 'reading': 'ma', 'audio': 'audio/katakana/katakana_ma.mp3'},
    {'letter': 'ミ', 'reading': 'mi', 'audio': 'audio/katakana/katakana_mi.mp3'},
    {'letter': 'ム', 'reading': 'mu', 'audio': 'audio/katakana/katakana_mu.mp3'},
    {'letter': 'メ', 'reading': 'me', 'audio': 'audio/katakana/katakana_me.mp3'},
    {'letter': 'モ', 'reading': 'mo', 'audio': 'audio/katakana/katakana_mo.mp3'},
    {'letter': 'ラ', 'reading': 'ra', 'audio': 'audio/katakana/katakana_ra.mp3'},
    {'letter': 'リ', 'reading': 'ri', 'audio': 'audio/katakana/katakana_ri.mp3'},
    {'letter': 'ル', 'reading': 'ru', 'audio': 'audio/katakana/katakana_ru.mp3'},
    {'letter': 'レ', 'reading': 're', 'audio': 'audio/katakana/katakana_re.mp3'},
    {'letter': 'ロ', 'reading': 'ro', 'audio': 'audio/katakana/katakana_ro.mp3'},
    {'letter': 'ヤ', 'reading': 'ya', 'audio': 'audio/katakana/katakana_ya.mp3'},
    {'letter': 'ユ', 'reading': 'yu', 'audio': 'audio/katakana/katakana_yu.mp3'},
    {'letter': 'ヨ', 'reading': 'yo', 'audio': 'audio/katakana/katakana_yo.mp3'},
    {'letter': 'ワ', 'reading': 'wa', 'audio': 'audio/katakana/katakana_wa.mp3'},
    {'letter': 'ヲ', 'reading': 'wo', 'audio': 'audio/katakana/katakana_wo.mp3'},
    {'letter': 'ン', 'reading': 'n', 'audio': 'audio/katakana/katakana_n.mp3'},
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
  ]
};


  late String _selectedAlphabet;

  @override
  void initState() {
    super.initState();
    _selectedAlphabet = Get.arguments ?? 'Hiragana';
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _letters[_selectedAlphabet]!.length,
                itemBuilder: (context, index) {
                  final letterInfo = _letters[_selectedAlphabet]![index];
                  return GestureDetector(
                    onTap: () => _playAudio(letterInfo['audio']!),
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
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            letterInfo['reading']!,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                          // const Icon(Icons.volume_up, color: Colors.white, size: 16),
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
