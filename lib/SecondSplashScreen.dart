import 'main_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class Secondsplashscreen extends StatefulWidget {
  const Secondsplashscreen({super.key});

  @override
  State<Secondsplashscreen> createState() => _SecondsplashscreenState();
}

class _SecondsplashscreenState extends State<Secondsplashscreen> {
  @override
  void initState() {
    super.initState();
    _navigateToMain();
  }

  void _navigateToMain() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigation()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LottieBuilder.asset(
          'lottie/Loading_Animation.json',
          repeat: true,
          frameRate: FrameRate.max,
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
    );
  }
}
