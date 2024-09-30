import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            GetStorage().write('isFirstTime', false);
            Get.offNamed('/login');
          },
          child: const Text('Lanjut ke Login'),
        ),
      ),
    );
  }
}