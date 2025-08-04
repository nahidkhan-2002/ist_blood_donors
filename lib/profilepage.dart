import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> donorData;
  final String docId;
  final String currentUserId;

  const ProfilePage({
    super.key,
    required this.donorData,
    required this.docId,
    required this.currentUserId,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController bloodController;
  late TextEditingController departmentController;
  late TextEditingController sessionController;

  bool get isEditable => widget.donorData['uid'] == widget.currentUserId;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.donorData['name']);
    phoneController = TextEditingController(text: widget.donorData['phone']);
    bloodController = TextEditingController(
      text: widget.donorData['bloodGroup'],
    );
    departmentController = TextEditingController(
      text: widget.donorData['department'],
    );
    sessionController = TextEditingController(
      text: widget.donorData['session'],
    );
  }

  Future<void> updateDonor() async {
    try {
      await FirebaseFirestore.instance
          .collection('informations')
          .doc(widget.docId)
          .update({
            'name': nameController.text.trim(),
            'phone': phoneController.text.trim(),
            'bloodGroup': bloodController.text.trim(),
            'department': departmentController.text.trim(),
            'session': sessionController.text.trim(),
          });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Profile updated successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Failed to update profile')),
      );
      print("Update error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 220,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Donor Profile',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            buildField("Name", Icons.person, nameController, isEditable),
            buildField("Phone", Icons.phone, phoneController, isEditable),
            buildField(
              "Blood Group",
              Icons.bloodtype,
              bloodController,
              isEditable,
            ),
            buildField(
              "Department",
              Icons.school,
              departmentController,
              isEditable,
            ),
            buildField(
              "Session",
              Icons.calendar_today,
              sessionController,
              isEditable,
            ),
            const SizedBox(height: 30),
            if (isEditable)
              ElevatedButton(
                onPressed: updateDonor,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color(0xFF7F00FF),
                ),
                child: const Text(
                  "Update Profile",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget buildField(
    String label,
    IconData icon,
    TextEditingController controller,
    bool editable,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: controller,
        enabled: editable,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.deepPurple),
          hintText: label,
          filled: true,
          fillColor: editable ? Colors.white : Colors.grey[300],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
