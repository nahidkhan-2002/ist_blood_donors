import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:ist_blood_donors/main.dart';
import 'package:ist_blood_donors/style.dart';

class Getstarted extends StatefulWidget {
  const Getstarted({super.key});

  @override
  State<Getstarted> createState() => _GetstartedState();
}

class _GetstartedState extends State<Getstarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [
                const Color.fromARGB(255, 206, 55, 55),
                const Color.fromARGB(255, 32, 29, 28),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Text(
            "IST Blood Donors",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white, // This will be masked by the shader
            ),
          ),
        ),
        centerTitle: true,
      ),

      body: Stack(
        children: [
          ScreenBackground(context),
          LayoutBuilder(
            builder: (context, constraints) {
              double horizontalPadding =
                  constraints.maxWidth > 600 ? 100.0 : 24.0;
              double verticalPadding =
                  constraints.maxHeight > 800 ? 100.0 : 24.0;
              return Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        SizedBox(
                          child: Lottie.asset(
                            'asset_project/Blood_Drop.json',
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.7,
                            fit: BoxFit.cover,
                            repeat: true,
                          ),
                        ),
                        //Spacer(),
                        Text(
                          "IST Blood Donors",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, 'register');
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            minimumSize: Size(
                              MediaQuery.of(context).size.height * 0.5,
                              MediaQuery.of(context).size.width * 0.2,
                            ),
                          ),
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              fontSize: 24,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
