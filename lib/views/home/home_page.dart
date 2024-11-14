import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  final String name;
  final String photoUrl;

  const HomePage({super.key, required this.name, required this.photoUrl});

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
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (widget.photoUrl.isNotEmpty)
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(widget.photoUrl),
                      )
                    else
                      CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        child: Icon(
                          Icons.person,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Welcome back,',
                        ),
                        Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
            const Divider(
              indent: 0,
              endIndent: 0,
              height: 0,
              thickness: 0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Progress :',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                      color: Colors.greenAccent[100],
                      borderRadius: BorderRadius.circular(15)),
                  height: 140,
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            const Positioned(
                              left: 24,
                              child: Text(
                                'Hiragana',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Center(
                              child: CircularProgressIndicator(
                                value: hiraganaProgress.value / 9,
                                backgroundColor: Colors.grey[300],
                                color: const Color(0xff6e81ce),
                                strokeWidth: 8,
                                strokeAlign: 5,
                              ),
                            ),
                            Center(
                              child: Text(
                                '${(hiraganaProgress.value / 9 * 100).toStringAsFixed(0)}%',
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
                              child: Text(
                                'Katakana',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Center(
                              child: CircularProgressIndicator(
                                value: katakanaProgress.value / 9,
                                backgroundColor: Colors.grey[300],
                                color: const Color(0xff5b9279),
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
                              child: Text(
                                'Kanji',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Center(
                              child: CircularProgressIndicator(
                                value: kanjiProgress.value / 6,
                                backgroundColor: Colors.grey[300],
                                color: const Color(0xfff0c808),
                                strokeWidth: 8,
                                strokeAlign: 5,
                              ),
                            ),
                            Center(
                              child: Text(
                                '${(kanjiProgress.value / 6 * 100).toStringAsFixed(0)}%',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // const Text(
            //   'Games :',
            //   style: TextStyle(
            //     fontSize: 17,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ].expand((widget) => [widget, const SizedBox(height: 16)]).toList()
            ..removeLast(),
        ),
      ),
    );
  }
}
