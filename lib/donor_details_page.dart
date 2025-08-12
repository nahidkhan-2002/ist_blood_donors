import 'package:flutter/material.dart';
import 'package:ist_blood_donors/utils.dart';
import 'package:ist_blood_donors/registerpage.dart';
import 'package:page_transition/page_transition.dart';

class DonorDetailsPage extends StatelessWidget {
  final String name;
  final String phone;
  final String bloodGroup;
  final String department;
  final String session;

  const DonorDetailsPage({
    super.key,
    required this.name,
    required this.phone,
    required this.bloodGroup,
    required this.department,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = currentUserPhone == phone;

    return Scaffold(
      appBar: AppBar(
        title: Text('Donor Details'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 206, 55, 55),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header Card
            Card(
              elevation: 4,
              shadowColor: const Color.fromARGB(121, 227, 125, 125),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 206, 55, 55),
                      const Color.fromARGB(255, 240, 31, 31),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: const Color.fromARGB(255, 206, 55, 55),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        bloodGroup,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 206, 55, 55),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            // Information Cards
            _buildInfoCard(
              icon: Icons.phone,
              title: 'Phone Number',
              value: phone,
              color: Colors.blue,
            ),
            _buildInfoCard(
              icon: Icons.school,
              title: 'Department',
              value: department,
              color: Colors.green,
            ),
            _buildInfoCard(
              icon: Icons.grade,
              title: 'Session',
              value: session,
              color: Colors.orange,
            ),

            SizedBox(height: 24),

            // Update Profile Button (only for current user)
            if (isCurrentUser)
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: Registerpage(),
                        duration: Duration(milliseconds: 400),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 206, 55, 55),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Update Profile',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            SizedBox(height: 16),

            // Contact Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle call action
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: Text('Call Donor'),
                              content: Text('Would you like to call $name?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Add actual call functionality here
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Calling $name...'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  },
                                  child: Text('Call'),
                                ),
                              ],
                            ),
                      );
                    },
                    icon: Icon(Icons.call),
                    label: Text('Call'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle message action
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: Text('Message Donor'),
                              content: Text('Would you like to message $name?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Add actual messaging functionality here
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Opening message...'),
                                        backgroundColor: Colors.blue,
                                      ),
                                    );
                                  },
                                  child: Text('Message'),
                                ),
                              ],
                            ),
                      );
                    },
                    icon: Icon(Icons.message),
                    label: Text('Message'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
