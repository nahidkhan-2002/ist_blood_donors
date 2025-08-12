import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:ist_blood_donors/style.dart';
import 'package:ist_blood_donors/apipage.dart';
import 'package:ist_blood_donors/registerpage.dart';
import 'package:ist_blood_donors/mainlistpage.dart';
import 'package:ist_blood_donors/utils.dart';
import 'package:page_transition/page_transition.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isWide = screenSize.width > 600;
    final isTall = screenSize.height > 800;
    final TextEditingController phoneController = TextEditingController();
    bool isLoading = false;

    Future<void> handleLogin() async {
      final phone = phoneController.text.trim();

      if (phone.isEmpty) {
        showtoast("Please enter your phone number");
        return;
      }

      setState(() => isLoading = true);

      final success = await checkPhoneLogin(phone);

      if (success) {
        // Store the current user's phone number
        currentUserPhone = phone;
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            child: const Mainlistpage(),
            duration: const Duration(milliseconds: 400),
          ),
        );
      }

      setState(() => isLoading = false);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ShaderMask(
          shaderCallback:
              (bounds) => const LinearGradient(
                colors: [
                  Color.fromARGB(255, 206, 55, 55),
                  Color.fromARGB(255, 32, 29, 28),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
          child: const Text(
            "IST Blood Donors",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
      ),
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
                    Lottie.asset(
                      'asset_project/Blood_Drop.json',
                      height: 200,
                      width: 200,
                      fit: BoxFit.fill,
                      repeat: true,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: phoneController,
                      onChanged: (value) {},
                      decoration: AppInputDecoration("Phone Number"),
                    ),
                    const SizedBox(height: 16),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            handleLogin();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(150, 50),
                          ),
                          child: const Text("Login"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const Registerpage(),
                                duration: const Duration(milliseconds: 300),
                              ),
                            );
                          },
                          child: const Text("Register"),
                        ),
                      ],
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
