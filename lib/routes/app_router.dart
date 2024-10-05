import 'package:get/get.dart';
import 'package:jepai/views/home_page.dart';
import 'package:jepai/views/introduction_page.dart';
import 'package:jepai/views/login_page.dart';
import 'package:jepai/views/register_page.dart';

class AppRouter {
  static String initialRoute(bool isFirstTime, bool isLoggedIn) {
    if (isFirstTime) {
      return '/introduction';
    } else if (isLoggedIn) {
      return '/home';
    } else {
      return '/login';
    }
  }

  static final List<GetPage> routes = [
    GetPage(name: '/introduction', page: () => const IntroductionPage()),
    GetPage(name: '/register', page: () => const RegisterPage()),
    GetPage(name: '/login', page: () =>  const LoginPage()),
    GetPage(name: '/home', page: () => HomePage()),
  ];
}
