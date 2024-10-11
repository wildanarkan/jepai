import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RxInt hiraganaProgress = 0.obs;
  final RxInt katakanaProgress = 0.obs;
  final RxInt kanjiProgress = 0.obs;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  void _loadProgress() async {
    if (userId != null) {
      try {
        var userDoc =
            FirebaseFirestore.instance.collection('users').doc(userId);
        var snapshot = await userDoc.get();
        if (snapshot.exists) {
          var data = snapshot.data();
          if (data != null) {
            hiraganaProgress.value = data['hiraganaProgress'] as int? ?? 0;
            katakanaProgress.value = data['katakanaProgress'] as int? ?? 0;
            kanjiProgress.value = data['kanjiProgress'] as int? ?? 0;
          }
        } else {
          print('User document does not exist');
        }
      } catch (e) {
        print('Error loading progress: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Obx(() => ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                decoration: const BoxDecoration(color: Colors.amber),
                height: 140,
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          const Positioned(
                            left: 24,
                            child: Text('Hiragana'),
                          ),
                          Center(
                            child: CircularProgressIndicator(
                              value: katakanaProgress.value / 9,
                              backgroundColor: Colors.grey[300],
                              color: Colors.red,
                              strokeWidth: 8,
                              strokeAlign: 5,
                            ),
                          ),
                          Center(
                            child: Text(
                              '${(katakanaProgress.value / 9 * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          const Positioned(
                            left: 24,
                            child: Text('Katakana'),
                          ),
                          Center(
                            child: CircularProgressIndicator(
                              value: katakanaProgress.value / 9,
                              backgroundColor: Colors.grey[300],
                              color: Colors.red,
                              strokeWidth: 8,
                              strokeAlign: 5,
                            ),
                          ),
                          Center(
                            child: Text(
                              '${(katakanaProgress.value / 9 * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          const Positioned(
                            left: 38,
                            child: Text('Kanji'),
                          ),
                          Center(
                            child: CircularProgressIndicator(
                              value: katakanaProgress.value / 9,
                              backgroundColor: Colors.grey[300],
                              color: Colors.red,
                              strokeWidth: 8,
                              strokeAlign: 5,
                            ),
                          ),
                          Center(
                            child: Text(
                              '${(katakanaProgress.value / 9 * 100).toStringAsFixed(0)}%',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
