import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Selamat Datang",
          body: "Ini adalah aplikasi pembelajaran bahasa yang inovatif.",
          image: Image.asset("assets/images/splash_logo.png"),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Fitur Utama",
          body: "Jelajahi fitur-fitur menarik yang kami tawarkan.",
          image: Image.asset("assets/images/splash_logo.png"),
          decoration: getPageDecoration(),
        ),
        PageViewModel(
          title: "Mulai Sekarang",
          body: "Mari kita mulai perjalanan belajar Anda!",
          image: Image.asset("assets/images/splash_logo.png"),
          decoration: getPageDecoration(),
        ),
      ],
      onDone: () {
        GetStorage().write('isFirstTime', false);
        Get.offNamed('/login');
      },
      showSkipButton: true,
      showBottomPart: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward_rounded, size: 30,),
      done: const Text("Start"),
      dotsDecorator: const DotsDecorator(
          // activeColor: Colors.black,
          // color: Colors.grey,
          ),
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      pageColor: Colors.white,
      contentMargin: EdgeInsets.all(0),
      bodyPadding: EdgeInsets.symmetric(horizontal: 20),
      pageMargin: EdgeInsets.all(0),
      footerPadding: EdgeInsets.all(0),
      imagePadding: EdgeInsets.all(50),
      titlePadding: EdgeInsets.all(0),
      bodyFlex: 1,
      safeArea: 0,
      imageFlex: 1,
      footerFlex: 1,
      footerFit: FlexFit.tight,
      bodyAlignment: Alignment.center,
      imageAlignment: Alignment.bottomCenter,
      bodyTextStyle: TextStyle(fontSize: 16.0),
    );
  }
}