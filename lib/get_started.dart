import 'package:flutter/material.dart';
import 'package:ist_blood_donors/style.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isWide = screenSize.width > 600;
    final isTall = screenSize.height > 800;

    return Scaffold(
      // appBar: AppBar(

      //   centerTitle: true,
      //   title: ShaderMask(
      //     shaderCallback:
      //         (bounds) => const LinearGradient(
      //           colors: [
      //             Color.fromARGB(255, 206, 55, 55),
      //             Color.fromARGB(255, 32, 29, 28),
      //           ],
      //           begin: Alignment.topLeft,
      //           end: Alignment.bottomRight,
      //         ).createShader(bounds),
      //     child: const Text(
      //       "IST Blood Donors",
      //       style: TextStyle(
      //         fontWeight: FontWeight.bold,
      //         fontSize: 24,
      //         color: Colors.white, // Masked by shader
      //       ),
      //     ),
      //   ),
      // ),
      body: Stack(
        children: [
          ScreenBackground(context),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 100 : 24,
                vertical: isTall ? 100 : 24,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: screenSize.height * 0.03),
                    Image.asset('asset_project/IST.png', fit: BoxFit.fill),
                    const SizedBox(height: 20),
                    const Text(
                      "IST Blood Donors",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Give Blood . Save Lives",
                      style: TextStyle(fontSize: 12),
                    ),

                    SizedBox(height: screenSize.height * 0.2),
                    ElevatedButton(
                      onPressed:
                          () =>
                              Navigator.pushReplacementNamed(context, 'login'),
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        minimumSize: Size(
                          screenSize.height * 0.5,
                          screenSize.width * 0.2,
                        ),
                      ),
                      child: const Text(
                        "Get Started",
                        style: TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
