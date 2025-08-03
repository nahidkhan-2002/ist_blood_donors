import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:ist_blood_donors/get_started.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: LottieBuilder.asset('lottie/main_Loading.json'),
      nextScreen: GetStarted(),
      splashIconSize: 400,
      duration: 6000,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
