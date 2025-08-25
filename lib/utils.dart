import 'style.dart';
import 'apipage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Global variables to store current user's information
String currentUserPhone = '';
String currentUserName = '';
String currentUserBloodGroup = '';
String currentUserDepartment = '';
String currentUserSession = '';

Widget buildDrawerList(BuildContext context) {
  return ListView(
    padding: EdgeInsets.zero,
    children: [
      const DrawerHeader(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset_project/IST.png'),
            opacity: 1.0,
            fit: BoxFit.scaleDown,
          ),
        ),
        child: SizedBox(),
      ),
      ListTile(
        title: const Text('See Donors List'),
        leading: Icon(Icons.list),
        onTap: () {
          Navigator.pushReplacementNamed(context, 'mainnavigation');
        },
      ),
      ListTile(
        title: const Text('Contact Us'),
        leading: Icon(Icons.call),
        onTap: () {
          //Navigator.pushReplacementNamed(context, 'contact');
        },
      ),
      ListTile(
        title: const Text('About Developer'),
        subtitle: const Text('Go to Settings → Developer'),
        leading: Icon(Icons.developer_mode),
        onTap: () {
          Navigator.pushReplacementNamed(context, 'mainnavigation');
          // Navigate to main navigation, user can then go to Settings tab
          // and access Developer Details from there
        },
      ),
      ListTile(
        title: const Text('Quit'),
        subtitle: const Text('Logout from the app'),
        leading: Icon(Icons.logout),
        onTap: () {
          // Clear current user session
          currentUserPhone = '';
          currentUserName = '';
          currentUserBloodGroup = '';
          currentUserDepartment = '';
          currentUserSession = '';
          showtoast("Thank You");
          Navigator.pushReplacementNamed(context, 'login');
        },
      ),
    ],
  );
}

void debugOTPInfo(String phoneNumber, String verificationId, String otp) {
  print("=== OTP DEBUG INFO ===");
  print("Phone Number: $phoneNumber");
  print("Verification ID: $verificationId");
  print("OTP Length: ${otp.length}");
  print("OTP: $otp");
  print("Firebase Auth Instance: ${FirebaseAuth.instance}");
  print("Current User: ${FirebaseAuth.instance.currentUser}");
  print("=====================");
}

void debugFirebaseError(dynamic error) {
  print("=== FIREBASE ERROR DEBUG ===");
  if (error is FirebaseAuthException) {
    print("Error Code: ${error.code}");
    print("Error Message: ${error.message}");
    print("Error Details: ${error.toString()}");
  } else {
    print("General Error: $error");
    print("Error Type: ${error.runtimeType}");
  }
  print("===========================");
}

// Test function for phone number validation
void testPhoneNumberValidation(String phoneNumber) {
  print("=== PHONE NUMBER VALIDATION TEST ===");
  print("Input: '$phoneNumber'");
  
  String phone = phoneNumber.trim();
  
  // Remove any existing country code
  if (phone.startsWith('+')) {
    phone = phone.substring(1);
    print("After removing +: '$phone'");
  }
  if (phone.startsWith('88')) {
    phone = phone.substring(2);
    print("After removing 88: '$phone'");
  }
  
  // For Bangladesh numbers, remove leading 0 if present
  if (phone.startsWith('0')) {
    phone = phone.substring(1);
    print("After removing leading 0: '$phone'");
  }
  
  print("Final processed phone: '$phone' (length: ${phone.length})");
  
  // Check if it's a valid Bangladesh mobile number
  bool isValid = phone.length == 10 && phone.startsWith('1');
  print("Is valid: $isValid");
  
  if (isValid) {
    final fullPhoneNumber = '+88$phone';
    print("Full formatted number: $fullPhoneNumber");
  }
  
  print("=====================================");
}

// Test function for login system
Future<void> testLoginSystem(String phoneNumber) async {
  print("=== LOGIN SYSTEM TEST ===");
  print("Testing login for phone: $phoneNumber");
  
  try {
    // Test checkPhoneLogin function
    print("Testing checkPhoneLogin...");
    final loginResult = await checkPhoneLogin(phoneNumber);
    print("Login result: $loginResult");
    
    if (loginResult) {
      // Test fetchUserByPhone function
      print("Testing fetchUserByPhone...");
      final userData = await fetchUserByPhone(phoneNumber);
      print("User data: $userData");
    }
  } catch (e) {
    print("Error testing login system: $e");
  }
  
  print("===============================");
}
