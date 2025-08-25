import 'style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<String> nameList = [];
List<String> phoneList = [];
List<String> bloodGroupList = [];
List<String> departmentList = [];
List<String> sessionList = [];

Future<bool> createRequest(formdata) async {
  try {
    CollectionReference collectionref = FirebaseFirestore.instance.collection(
      'informations',
    );
    await collectionref.add(formdata);
    return true;
  } catch (e) {
    showtoast('something went wrong');
    print('Firestore add error : $e');
    return false;
  }
}

Future<void> fetchAllInformation() async {
  try {
    final collection = FirebaseFirestore.instance.collection('informations');
    final snapshot = await collection.get();

    // Clear previous data if re-fetching
    nameList.clear();
    phoneList.clear();
    bloodGroupList.clear();
    departmentList.clear();
    sessionList.clear();

    for (var doc in snapshot.docs) {
      final data = doc.data();

      nameList.add(data['name'] ?? '');
      phoneList.add(data['phone'] ?? '');
      bloodGroupList.add(data['bloodGroup'] ?? '');
      departmentList.add(data['department'] ?? '');
      sessionList.add(data['session'] ?? '');
    }
  } catch (e) {
    showtoast('Something went wrong while fetching data');
    print("Firestore fetch error: $e");
  }
}

Future<bool> checkPhoneLogin(String phone) async {
  try {
    print("Attempting login with phone: $phone");

    // Check the 'informations' collection
    final infoSnapshot =
        await FirebaseFirestore.instance
            .collection('informations')
            .where('phone', isEqualTo: phone)
            .get();

    if (infoSnapshot.docs.isNotEmpty) {
      print("User found in 'informations' collection");
      showtoast("Login successful ✅");
      return true;
    }

    // User not found
    print("User not found in 'informations' collection");
    showtoast("Phone number not registered. Please register first.");
    return false;
  } catch (e) {
    showtoast("Something went wrong during login");
    print("Login error: $e");
    return false;
  }
}

Future<void> sendOTP({
  required String phoneNumber,
  required Function(String verificationId) onCodeSent,
  required Function(FirebaseAuthException error) onError,
}) async {
  try {
    // Format phone number for Bangladesh (+88 country code)
    String formattedPhone = phoneNumber.trim();

    // Remove any existing country code
    if (formattedPhone.startsWith('+')) {
      formattedPhone = formattedPhone.substring(1);
    }
    if (formattedPhone.startsWith('88')) {
      formattedPhone = formattedPhone.substring(2);
    }

    // For Bangladesh numbers, remove leading 0 if present
    // Input: 01621009683 -> After processing: 1621009683
    if (formattedPhone.startsWith('0')) {
      formattedPhone = formattedPhone.substring(1);
    }

    // Validate the final phone number format
    // Should be 10 digits starting with 1 (after removing leading 0)
    if (formattedPhone.length != 10 || !formattedPhone.startsWith('1')) {
      throw Exception(
        'Invalid phone number format. Expected 10 digits starting with 1 after removing leading 0 (e.g., 1621009683)',
      );
    }

    final fullPhoneNumber = '+88$formattedPhone';
    print("Sending OTP to: $fullPhoneNumber");
    print("Original phone: $phoneNumber");
    print("Formatted phone: $formattedPhone");

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: fullPhoneNumber,
      timeout: const Duration(seconds: 120), // Increased timeout
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("Auto verification completed for: ${credential.smsCode}");
        // This is optional and only works on some Android devices
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification failed: ${e.code} - ${e.message}");
        onError(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        print("OTP code sent successfully. Verification ID: $verificationId");
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(
          "OTP auto-retrieval timeout for verification ID: $verificationId",
        );
      },
    );
  } catch (e) {
    print("Error in sendOTP: $e");
    // Create a generic FirebaseAuthException for the error callback
    final error = FirebaseAuthException(
      code: 'unknown',
      message: 'Failed to send OTP: $e',
    );
    onError(error);
  }
}

Future<bool> updateUserInformation(
  String phone,
  Map<String, String> formdata,
) async {
  try {
    final collection = FirebaseFirestore.instance.collection('informations');
    final querySnapshot =
        await collection.where('phone', isEqualTo: phone).get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      await collection.doc(docId).update(formdata);
      showtoast('Profile updated successfully ✅');
      return true;
    } else {
      showtoast('User not found');
      return false;
    }
  } catch (e) {
    showtoast('Failed to update profile');
    print('Firestore update error: $e');
    return false;
  }
}

Future<Map<String, String>?> fetchUserByPhone(String phone) async {
  try {
    print("Fetching user data for phone: $phone");

    // Fetch from the 'informations' collection
    final infoSnapshot =
        await FirebaseFirestore.instance
            .collection('informations')
            .where('phone', isEqualTo: phone)
            .get();

    if (infoSnapshot.docs.isNotEmpty) {
      print("User data found in 'informations' collection");
      final data = infoSnapshot.docs.first.data();
      return {
        'name': data['name'] ?? '',
        'phone': data['phone'] ?? '',
        'email': data['email'] ?? '',
        'address': data['address'] ?? '',
        'bloodGroup': data['bloodGroup'] ?? '',
        'department': data['department'] ?? '',
        'session': data['session'] ?? '',
      };
    }

    print("User data not found in 'informations' collection");
    return null;
  } catch (e) {
    print('Error fetching user data: $e');
    return null;
  }
}
