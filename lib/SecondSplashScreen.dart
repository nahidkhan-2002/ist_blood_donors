import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'mainlistpage.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class Secondsplashscreen extends StatelessWidget {
  const Secondsplashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSplashScreen(
        splashIconSize: 300,
        duration: 6000,
        splash: Transform.scale(
          scale: 1.5,
          child: LottieBuilder.asset(
            'lottie/Loading_Animation.json',
            repeat: true,
            frameRate: FrameRate.max,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        nextScreen: Mainlistpage(),
      ),
    );
  }
}
