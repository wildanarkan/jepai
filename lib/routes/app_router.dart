import 'package:get/get.dart';
import 'package:jepai/views/dictionary/letter_page.dart';
import 'package:jepai/views/introduction/introduction_page.dart';
import 'package:jepai/views/login/login_page.dart';
import 'package:jepai/views/login/register_page.dart';
import 'package:jepai/views/main_page.dart';
import 'package:jepai/views/profile/about_page.dart';
import 'package:jepai/views/profile/feedback_page.dart';
import 'package:jepai/views/profile/help_page.dart';
import 'package:jepai/views/profile/setting_page.dart';

class AppRouter {
  static String initialRoute(bool isFirstTime, bool isLoggedIn) {
    if (isFirstTime) {
      return '/introduction';
    } else if (isLoggedIn) {
      return '/main';
    } else {
      return '/login';
    }
  }

  static final List<GetPage> routes = [
    GetPage(name: '/introduction', page: () => const IntroductionPage()),
    GetPage(name: '/register', page: () => const RegisterPage()),
    GetPage(name: '/login', page: () =>  const LoginPage()),
    GetPage(name: '/main', page: () => const MainPage()),

    // PROFILE
    GetPage(name: '/profile/setting', page: () => const SettingPage()),
    GetPage(name: '/profile/about', page: () => const AboutPage()),
    GetPage(name: '/profile/help', page: () => const HelpPage()),
    GetPage(name: '/profile/feedback', page: () => FeedbackPage()),

    // DICTIANORY
    GetPage(name: '/dictionary/letters', page: () => const LetterPage()),
  ];
}
