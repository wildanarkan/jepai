import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jepai/firebase_options.dart';
import 'package:jepai/views/home_page.dart';
import 'package:jepai/views/introduction_page.dart';
import 'package:jepai/views/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(const JepaiApp());
}

class JepaiApp extends StatelessWidget {
  const JepaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: _determineInitialRoute(),
      getPages: [
        GetPage(name: '/introduction', page: () => const IntroductionPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/home', page: () => const HomePage()),
      ],
    );
  }

  String _determineInitialRoute() {
    final storage = GetStorage();
    final bool isFirstTime = storage.read('isFirstTime') ?? true;
    final bool isLoggedIn = storage.read('isLoggedIn') ?? false;

    if (isFirstTime) {
      return '/introduction';
    } else if (isLoggedIn) {
      return '/home';
    } else {
      return '/login';
    }
  }
}
