import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Frequently Asked Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('1. Bagaimana cara mengganti bahasa aplikasi?'),
            Text('Jawaban: Anda bisa mengganti bahasa melalui pengaturan di halaman Settings.'),
            SizedBox(height: 10),
            Text('2. Bagaimana cara mengaktifkan mode gelap?'),
            Text('Jawaban: Anda bisa mengaktifkan mode gelap melalui pengaturan di halaman Settings.'),
          ],
        ),
      ),
    );
  }
}
