import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:ist_blood_donors/style.dart';
import 'package:ist_blood_donors/registerpage.dart';
import 'package:ist_blood_donors/mainlistpage.dart';
import 'package:page_transition/page_transition.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
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
                          child: Lottie.asset(
                            'asset_project/Blood_Drop.json',
                            height: 200,
                            width: 200,
                            fit: BoxFit.fill,
                            repeat: true,
                          ),
                        ),
                        TextFormField(
                          onChanged: (value) {},
                          decoration: AppInputDecoration("Phone Number"),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          onChanged: (value) {},
                          decoration: AppInputDecorationPass("Password"),
                          obscureText: true,
                          obscuringCharacter: '*',
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    child: Mainlistpage(),
                                    duration: Duration(milliseconds: 400),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minimumSize: Size(150, 50),
                              ),
                              child: Text("Login"),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: Registerpage(),
                                    duration: Duration(milliseconds: 300),
                                  ),
                                );
                              },
                              child: Text("Register"),
                            ),
                          ],
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
