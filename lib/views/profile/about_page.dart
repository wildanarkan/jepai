import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('JEPAI', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Version: 1.0.0'),
            SizedBox(height: 20),
            Text(
              'JEPAI adalah aplikasi pembelajaran bahasa Jepang berbasis AI yang membantu '
              'pengguna belajar bahasa Jepang dengan cara yang interaktif dan menyenangkan.',
            ),
          ],
        ),
      ),
    );
  }
}
