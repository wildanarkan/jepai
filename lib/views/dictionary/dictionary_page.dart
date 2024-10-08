import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  List<dynamic> _dictionaryResults = [];
  bool _isLoading = false;
  String _error = '';

  // Kontrol untuk mengelola input pencarian
  final TextEditingController _searchController = TextEditingController();

  // Fungsi untuk mengambil data dari Jisho API
  Future<void> searchWord(String query) async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    final url = 'https://jisho.org/api/v1/search/words?keyword=$query';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _dictionaryResults = data['data'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load dictionary');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Failed to fetch data. Please try again.';
      });
    }
  }

  void _performSearch() {
    String query = _searchController.text;
    if (query.isNotEmpty) {
      searchWord(query);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Japanese Dictionary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => Get.toNamed('/dictionary/letters', arguments: 'Hiragana'),
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.amber,
                    child: const Center(child: Text('Hiragana')),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed('/dictionary/letters', arguments: 'Katakana'),
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                    child: const Center(child: Text('Katakana')),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed('/dictionary/letters', arguments: 'Kanji'),
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.blue,
                    child: const Center(child: Text('Kanji')),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onSubmitted: (query) => _performSearch(),
                decoration: InputDecoration(
                  hintText: 'Search for a word...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error.isNotEmpty
                    ? Center(child: Text(_error))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _dictionaryResults.length,
                          itemBuilder: (context, index) {
                            final entry = _dictionaryResults[index];
                            final word = entry['japanese'][0]['word'] ??
                                entry['japanese'][0]['reading'];
                            final meaning = entry['senses'][0]
                                    ['english_definitions']
                                .join(', ');
                            final partsOfSpeech =
                                entry['senses'][0]['parts_of_speech'].join(', ');
        
                            return ListTile(
                              title: Text(word),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Meaning (English): $meaning'),
                                  Text('Part of Speech: $partsOfSpeech'),
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
