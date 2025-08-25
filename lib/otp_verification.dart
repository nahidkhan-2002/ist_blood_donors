import 'style.dart';
import 'utils.dart';
import 'SecondSplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerification extends StatefulWidget {
  final String verificationId;
  final Map<String, dynamic> formdata;

  const OTPVerification({
    super.key,
    required this.verificationId,
    required this.formdata,
  });

  @override
  State<OTPVerification> createState() => OTPVerificationState();
}

class OTPVerificationState extends State<OTPVerification> {
  final TextEditingController _otpController = TextEditingController();
  bool isVerifying = false;
  bool canResend = true;
  int resendCountdown = 60;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && resendCountdown > 0) {
        setState(() {
          resendCountdown--;
        });
        _startResendTimer();
      } else if (mounted) {
        setState(() {
          canResend = true;
        });
      }
    });
  }

  Future<void> _resendOTP() async {
    if (!canResend) return;

    setState(() {
      canResend = false;
      resendCountdown = 60;
    });

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+880${widget.formdata['phone']}',
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto verification completed
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Resend verification failed: ${e.code} - ${e.message}");
          showtoast('Failed to resend OTP: ${e.message}');
        },
        codeSent: (String verificationId, int? resendToken) {
          print(
            "OTP resent successfully. New verification ID: $verificationId",
          );
          showtoast('OTP resent successfully ✅');
          // Note: The verification ID is final, so we can't update it
          // The user will need to use the new OTP with the current verification ID
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print(
            "OTP auto-retrieval timeout for verification ID: $verificationId",
          );
        },
      );
    } catch (e) {
      print("Error resending OTP: $e");
      showtoast('Failed to resend OTP. Please try again.');
    }

    _startResendTimer();
  }

  Future<void> _verifyOTP(String otp) async {
    if (otp.length != 6) {
      showtoast('Please enter a valid 6-digit OTP');
      return;
    }

    setState(() {
      isVerifying = true;
    });

    try {
      // Debug logging
      debugOTPInfo(widget.formdata['phone'], widget.verificationId, otp);

      print("Verifying OTP: $otp");
      print("Verification ID: ${widget.verificationId}");

      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      print("Credential created, attempting to sign in...");

      // Sign in with the credential
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      print("Sign in successful for user: ${userCredential.user?.uid}");

      // Check if user already exists in Firestore
      final existingUser =
          await FirebaseFirestore.instance
              .collection('informations')
              .where('phone', isEqualTo: widget.formdata['phone'])
              .get();

      if (existingUser.docs.isEmpty) {
        // Add user data to Firestore only if they don't exist
        await FirebaseFirestore.instance.collection('informations').add({
          ...widget.formdata,
          'uid': userCredential.user?.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });
        print("User data saved to Firestore (informations collection)");
      } else {
        print("User already exists in Firestore (informations collection)");
      }

      showtoast('Registration successful ✅');

      // Navigate to next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Secondsplashscreen()),
      );
    } on FirebaseAuthException catch (e) {
      debugFirebaseError(e);
      print("Firebase Auth Error: ${e.code} - ${e.message}");
      String errorMessage = 'Verification failed';

      switch (e.code) {
        case 'invalid-verification-code':
          errorMessage = 'Invalid OTP code. Please check and try again.';
          break;
        case 'invalid-verification-id':
          errorMessage =
              'Verification session expired. Please request a new OTP.';
          break;
        case 'session-expired':
          errorMessage = 'OTP session expired. Please request a new code.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many attempts. Please try again later.';
          break;
        default:
          errorMessage = 'Verification failed: ${e.message}';
      }

      showtoast(errorMessage);
    } catch (e) {
      print("General Error during OTP verification: $e");
      showtoast('An unexpected error occurred. Please try again.');
    }

    setState(() {
      isVerifying = false;
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Enter the 6-digit code sent to your phone',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            PinCodeTextField(
              controller: _otpController,
              appContext: context,
              length: 6,
              keyboardType: TextInputType.number,
              autoFocus: true,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 50,
                fieldWidth: screenWidth / 8,
                activeFillColor: Colors.white,
                inactiveFillColor: Colors.grey.shade200,
                selectedFillColor: Colors.white,
                activeColor: Colors.red.shade700,
                inactiveColor: Colors.grey,
                selectedColor: Colors.red.shade400,
              ),
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              onChanged: (value) {},
              onCompleted: (value) => _verifyOTP(value), // CALL with value!
            ),

            const SizedBox(height: 32),

            isVerifying
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  onPressed:
                      () => _verifyOTP(
                        _otpController.text,
                      ), // CALL with current input
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenWidth * 0.6, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Verify & Register',
                    style: TextStyle(fontSize: 18),
                  ),
                ),

            const SizedBox(height: 16),

            // Resend OTP button
            TextButton(
              onPressed: canResend ? _resendOTP : null,
              child: Text(
                canResend ? 'Resend OTP' : 'Resend OTP in ${resendCountdown}s',
                style: TextStyle(
                  color: canResend ? Colors.red.shade700 : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
