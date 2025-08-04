import 'package:flutter/material.dart';
import 'package:ist_blood_donors/utils.dart';
import 'package:ist_blood_donors/apipage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ist_blood_donors/profilepage.dart';
import 'package:page_transition/page_transition.dart';

class Mainlistpage extends StatefulWidget {
  const Mainlistpage({super.key});

  @override
  State<Mainlistpage> createState() => _MainlistpageState();
}

bool Loading = false;
String? currentUserId;

class _MainlistpageState extends State<Mainlistpage> {
  @override
  void initState() {
    super.initState();

    getCurrentUserId();
    loadData(); // custom function call korbo ekhane
  }

  void loadData() async {
    setState(() {
      Loading = true; // 🌀 Show loading spinner
    });
    await fetchAllInformation(); // 🔁 fetch firestore data
    setState(() {
      Loading = false;
    }); // 🧠 UI update
  }

  void getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      currentUserId = user?.uid ?? 'unknown';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IST Blood Donors"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      drawer: Drawer(child: buildDrawerList(context)),
      body:
          Loading
              ? Center(child: (CircularProgressIndicator()))
              : (LayoutBuilder(
                builder: (context, constraints) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    padding: EdgeInsets.all(16),
                    itemCount: nameList.length,
                    itemBuilder: (context, index) {
                      // Dummy data for demonstration
                      return Card(
                        shadowColor: const Color.fromARGB(121, 227, 125, 125),
                        elevation: 2,
                        margin: EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      nameList[index],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Blood Group: ${bloodGroupList[index]}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      'Number: ${phoneList[index]}',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(height: 8),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.fade,
                                              child: ProfilePage(
                                                donorData: {
                                                  'name': nameList[index],
                                                  'phone': phoneList[index],
                                                  'bloodGroup':
                                                      bloodGroupList[index],
                                                  'department':
                                                      departmentList[index],
                                                  'session': sessionList[index],
                                                  'uid':
                                                      currentUserId ??
                                                      'unknown_user',
                                                },
                                                docId:
                                                    docIdList[index], // You'll need to collect this (below)
                                                currentUserId:
                                                    currentUserId ??
                                                    'unknown_user',
                                              ),
                                              duration: const Duration(
                                                milliseconds: 300,
                                              ),
                                            ),
                                          );
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
              )),
    );
  }
}
