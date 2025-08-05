import 'style.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:ist_blood_donors/apipage.dart';
import 'package:ist_blood_donors/loginpage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:ist_blood_donors/otp_verification.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

var Loading = false;

class _RegisterpageState extends State<Registerpage> {
  Map<String, String> formdata = {
    'name': '',
    'phone': '',
    'email': '',
    'address': '',
    'bloodGroup': '',
    'department': '',
    'session': '',
  };

  void inputonchange(String key, String val) {
    setState(() {
      formdata.update(key, (value) => val);
    });
  }

  Future<void> validateAndSubmit() async {
    bool ok = true;
    for (var key in formdata.keys) {
      if (formdata[key] == null || formdata[key]!.trim().isEmpty) {
        showtoast('Please fill in all fields');
        ok = false;
        break;
      }
    }

    if (ok) {
      setState(() => Loading = true);

      await sendOTP(
        phoneNumber: formdata['phone']!,
        onCodeSent: (verificationId) {
          setState(() => Loading = false);
          print("Sending OTP");
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: OTPVerification(
                verificationId: verificationId,
                formdata: formdata,
              ),
              duration: const Duration(milliseconds: 300),
            ),
          );
        },
        onError: (error) {
          setState(() => Loading = false);
          showtoast('OTP sending failed: ${error.message}');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackgroundReg(context),
          LayoutBuilder(
            builder: (context, constraints) {
              return Transform.scale(
                scale: 0.9,
                child: Center(
                  child: BlurryContainer.expand(
                    blur: 15,
                    elevation: 5,
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(8),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: Center(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(20),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 400),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                onChanged: (value) {
                                  inputonchange('name', value);
                                },
                                decoration: AppInputDecoration('Name'),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {
                                  inputonchange('phone', value);
                                },
                                decoration: AppInputDecoration('Phone Number'),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {
                                  inputonchange('email', value);
                                },
                                decoration: AppInputDecoration('Email'),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {
                                  inputonchange('address', value);
                                },
                                decoration: AppInputDecoration('Address'),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {
                                  inputonchange('bloodGroup', value);
                                },
                                decoration: AppInputDecoration(
                                  "Blood Group (ex O+ AB+ B-)",
                                ),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {
                                  inputonchange('department', value);
                                },
                                decoration: AppInputDecoration("Department"),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                onChanged: (value) {
                                  inputonchange('session', value);
                                },
                                decoration: AppInputDecoration("Session"),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Loading
                                      ? CircularProgressIndicator()
                                      : (ElevatedButton(
                                        onPressed: () async {
                                          await validateAndSubmit();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        child: Shimmer.fromColors(
                                          baseColor: const Color.fromARGB(
                                            255,
                                            0,
                                            0,
                                            0,
                                          ),
                                          highlightColor: const Color.fromARGB(
                                            163,
                                            225,
                                            70,
                                            27,
                                          ),
                                          child: Text(
                                            "Register",
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      )),
                                  SizedBox(width: 10),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Already have an account?"),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          child: const Loginpage(),
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text("Login"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
