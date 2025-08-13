import 'style.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'apipage.dart';
import 'loginpage.dart';
import 'package:page_transition/page_transition.dart';
import 'otp_verification.dart';

class Registerpage extends StatefulWidget {
  final bool isUpdateMode;
  final Map<String, String>? existingData;

  const Registerpage({super.key, this.isUpdateMode = false, this.existingData});

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

  @override
  void initState() {
    super.initState();
    if (widget.isUpdateMode && widget.existingData != null) {
      formdata = Map<String, String>.from(widget.existingData!);
    }
  }

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

      if (widget.isUpdateMode) {
        // Update existing user
        bool success = await updateUserInformation(
          formdata['phone']!,
          formdata,
        );
        setState(() => Loading = false);
        if (success) {
          Navigator.pop(context); // Go back to previous page
        }
      } else {
        // Register new user
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdateMode ? "Update Profile" : "Register"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          ScreenBackgroundReg(context),
          LayoutBuilder(
            builder: (context, constraints) {
              return Transform.scale(
                scale: 0.9,
                child: Center(
                  child: Container(
                    height: 750,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
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
                                enabled:
                                    !widget
                                        .isUpdateMode, // Disable editing in update mode
                                decoration: AppInputDecoration(
                                  widget.isUpdateMode
                                      ? 'Phone Number (Read-only)'
                                      : 'Phone Number',
                                ),
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
                                                0.85,
                                            MediaQuery.of(context).size.height *
                                                0.055,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              30,
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
                                            widget.isUpdateMode
                                                ? "Update"
                                                : "Register",
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
