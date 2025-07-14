import 'package:flutter/material.dart';
import 'package:ist_blood_donors/utils.dart';

class Mainlistpage extends StatefulWidget {
  const Mainlistpage({super.key});

  @override
  State<Mainlistpage> createState() => _MainlistpageState();
}

class _MainlistpageState extends State<Mainlistpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IST Blood Donors"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      drawer: Drawer(child: buildDrawerList(context)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: 10, // Replace with your data length
            itemBuilder: (context, index) {
              // Dummy data for demonstration
              final profilePicUrl =
                  'https://www.svgrepo.com/svg/382109/male-avatar-boy-face-man-user-7';
              final bloodGroup =
                  [
                    'A+',
                    'B+',
                    'O-',
                    'AB+',
                    'A-',
                    'B-',
                    'O+',
                    'AB-',
                    'A+',
                    'O+',
                  ][index];
              final phoneNumber = '+1234567890$index';

              return Card(
                margin: EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(profilePicUrl),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name ${index + 1}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Blood Group: $bloodGroup',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Number: $phoneNumber',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 8),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  // Handle see details action
                                },
                                child: Text(
                                  'See Details',
                                  style: TextStyle(
                                    color: const Color.fromARGB(
                                      255,
                                      240,
                                      31,
                                      31,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
