import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jepai/routes/app_router.dart';
import 'package:jepai/theme/app_theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  runApp(const JepaiApp());
}

class JepaiApp extends StatelessWidget {
  const JepaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final bool isFirstTime = storage.read('isFirstTime') ?? true;
    final bool isLoggedIn = storage.read('isLoggedIn') ?? false;
    
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppRouter.initialRoute(isFirstTime, isLoggedIn),
      getPages: AppRouter.routes,
    );
  }
}
