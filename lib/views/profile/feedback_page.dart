import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackPage extends StatelessWidget {
  final _feedbackController = TextEditingController();

  FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('We value your feedback!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: _feedbackController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Write your feedback here...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Simpan atau kirim feedback
                Get.snackbar(
                  'Feedback',
                  'Thank you for your feedback!',
                  colorText: Colors.black,
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
