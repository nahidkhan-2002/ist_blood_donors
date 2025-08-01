import 'package:ist_blood_donors/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

List<String> nameList = [];
List<String> phoneList = [];
List<String> bloodGroupList = [];
List<String> departmentList = [];
List<String> sessionList = [];

Future<void> productcreateRequest(formdata) async {
  try {
    CollectionReference collectionref = FirebaseFirestore.instance.collection(
      'informations',
    );
    await collectionref.add(formdata);
  } catch (e) {
    showtoast('something went wrong');
    print('Firestore add error : $e');
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
      final data = doc.data() as Map<String, dynamic>;

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
