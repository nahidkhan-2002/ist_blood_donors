import 'package:ist_blood_donors/style.dart';
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

    showtoast("Data loaded successfully ✅");
  } catch (e) {
    showtoast('Something went wrong while fetching data');
    print("Firestore fetch error: $e");
  }
}

Future<bool> checkPhoneLogin(String phone) async {
  try {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('informations')
            .where('phone', isEqualTo: phone)
            .get();

    if (snapshot.docs.isNotEmpty) {
      showtoast("Login successful ✅");
      return true;
    } else {
      showtoast("Wrong phone number ❌");
      return false;
    }
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
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: '+88$phoneNumber', // ⚠️ Include country code if needed
    timeout: const Duration(seconds: 60),
    verificationCompleted: (PhoneAuthCredential credential) async {
      // Optional: auto sign-in (only on Android sometimes)
    },
    verificationFailed: (FirebaseAuthException e) {
      onError(e); // 🟥 This must be called properly
    },
    codeSent: (String verificationId, int? resendToken) {
      onCodeSent(verificationId); // ✅ THIS triggers OTP screen
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      // optional
    },
  );
}
