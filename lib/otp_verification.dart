import 'package:flutter/material.dart';
import 'package:ist_blood_donors/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ist_blood_donors/SecondSplashScreen.dart';

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

  Future<void> _verifyOTP(String otp) async {
    if (otp.length != 6) {
      showtoast('Please enter a valid 6-digit OTP');
      return;
    }

    setState(() {
      isVerifying = true;
    });

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Save user data after successful verification
      await FirebaseFirestore.instance.collection('users').add(widget.formdata);

      showtoast('Registration successful ✅');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Secondsplashscreen()),
      );
    } catch (e) {
      print("OTP Verification failed: $e");
      showtoast('Invalid OTP or verification failed');
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
          ],
        ),
      ),
    );
  }
}