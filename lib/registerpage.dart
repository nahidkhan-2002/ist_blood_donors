import 'style.dart';
import 'utils.dart';
import 'apipage.dart';
import 'loginpage.dart';
import 'otp_verification.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

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

    // Validate phone number format
    if (ok && formdata['phone'] != null) {
      String phone = formdata['phone']!.trim();
      print("Original phone number: '$phone'");

      // Test the phone number validation
      testPhoneNumberValidation(phone);

      // Remove any existing country code
      if (phone.startsWith('+')) {
        phone = phone.substring(1);
        print("After removing +: '$phone'");
      }
      if (phone.startsWith('88')) {
        phone = phone.substring(2);
        print("After removing 88: '$phone'");
      }

      // For Bangladesh numbers, we need to handle the leading 0 properly
      // Valid formats: 01XXXXXXXXX, 016XXXXXXXX, 017XXXXXXXX, 018XXXXXXXX, 019XXXXXXXX
      if (phone.startsWith('0')) {
        phone = phone.substring(1);
        print("After removing leading 0: '$phone'");
      }

      print("Final processed phone: '$phone' (length: ${phone.length})");

      // Check if it's a valid Bangladesh mobile number
      // Should be 10 digits after removing leading 0, and should start with 1
      if (phone.length != 10 || !phone.startsWith('1')) {
        print(
          "Phone validation failed: length=${phone.length}, startsWith1=${phone.startsWith('1')}",
        );
        showtoast(
          'Please enter a valid Bangladesh mobile number (e.g., 01621009683, 01712345678)',
        );
        ok = false;
      } else {
        // Update the phone number to the cleaned format (without leading 0)
        formdata['phone'] = phone;
        print("Phone number validated successfully: ${formdata['phone']}");
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
                              // Phone number format hint
                              if (!widget.isUpdateMode) ...[
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 16,
                                    top: 4,
                                  ),
                                  child: Text(
                                    'Format: 01XXXXXXXXX (e.g., 01621009683)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                              ],
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
