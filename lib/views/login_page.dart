import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            GetStorage().write('isLoggedIn', true);
            Get.offNamed('/home');
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}