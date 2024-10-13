import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestPage extends StatefulWidget {
  const QuestPage({super.key});

  @override
  _QuestPageState createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  final RxInt hiraganaProgress = 0.obs;
  final RxInt katakanaProgress = 0.obs;
  final RxInt kanjiProgress = 0.obs;
  final RxInt writingProgress = 0.obs;  // New progress for writing
  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  void _loadProgress() async {
    if (userId != null) {
      try {
        var userDoc = FirebaseFirestore.instance.collection('users').doc(userId);
        var snapshot = await userDoc.get();
        if (snapshot.exists) {
          var data = snapshot.data();
          if (data != null) {
            setState(() {
              hiraganaProgress.value = data['hiraganaProgress'] as int? ?? 0;
              katakanaProgress.value = data['katakanaProgress'] as int? ?? 0;
              kanjiProgress.value = data['kanjiProgress'] as int? ?? 0;
              writingProgress.value = data['writingProgress'] as int? ?? 0;  // Load writing progress
            });
          }
        } else {
          print('User document does not exist');
        }
      } catch (e) {
        print('Error loading progress: $e');
      }
    }
  }

  void _handleQuestTap(String type, RxInt progress, int maxProgress) async {
    if (progress.value >= maxProgress) {
      Get.snackbar('Quest Completed', 'You have already completed this quest!');
    } else {
      final result = await Get.toNamed('/quest/lesson', arguments: {
        'type': type,
        'progress': progress.value,
      });
      if (result == true) {
        await _updateProgress(type.toLowerCase());
        _loadProgress();
      }
    }
  }

  void _handleWritingTap() async {
    final result = await Get.toNamed('/quest/writing', arguments: {
      'progress': writingProgress.value,
    });
    if (result == true) {
      await _updateProgress('writing');
      _loadProgress();
    }
  }

  Future<void> _updateProgress(String type) async {
    if (userId != null) {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

      try {
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          final snapshot = await transaction.get(userDoc);

          if (snapshot.exists) {
            final data = snapshot.data() as Map<String, dynamic>;
            final String progressField = '${type}Progress';
            final int currentProgress = data[progressField] as int? ?? 0;

            transaction.update(userDoc, {progressField: currentProgress + 1});
          } else {
            transaction.set(
                userDoc,
                {
                  '${type}Progress': 1,
                },
                SetOptions(merge: true));
          }
        });

        _loadProgress();
      } catch (e) {
        print('Error updating progress: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quest'),
      ),
      body: Obx(() => ListView(
            padding: const EdgeInsets.all(10),
            children: [
              _buildQuestTile(
                  title: 'Basic Hiragana',
                  progress: hiraganaProgress.value,
                  maxProgress: 9,
                  color: Colors.amber,
                  onTap: () => _handleQuestTap('Hiragana', hiraganaProgress, 9)),
              _buildQuestTile(
                  title: 'Basic Katakana',
                  progress: katakanaProgress.value,
                  maxProgress: 9,
                  color: Colors.red,
                  onTap: () => _handleQuestTap('Katakana', katakanaProgress, 9)),
              _buildQuestTile(
                  title: 'Basic Kanji',
                  progress: kanjiProgress.value,
                  maxProgress: 6,
                  color: Colors.blue,
                  onTap: () => _handleQuestTap('Kanji', kanjiProgress, 6)),
              _buildQuestTile(
                  title: 'Writing Practice',
                  progress: writingProgress.value,
                  maxProgress: 10,
                  color: Colors.green,
                  onTap: _handleWritingTap),
            ].expand((widget) => [widget, const SizedBox(height: 16)]).toList()
              ..removeLast(),
          )),
    );
  }

  Widget _buildQuestTile({
    required String title,
    required int progress,
    required int maxProgress,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text('$progress/$maxProgress'),
              ],
            ),
            progress >= maxProgress
                ? const Icon(Icons.check_circle)
                : const Icon(Icons.arrow_forward_rounded)
          ],
        ),
      ),
    );
  }
}