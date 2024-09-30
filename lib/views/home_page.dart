import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            GetStorage().write('isFirstTime', true);
            Get.offNamed('/introduction');
          },
          child: const Text('LOGOUT'),
        ),
      ),
    );
  }
}
