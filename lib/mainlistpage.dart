import 'package:flutter/material.dart';
import 'package:ist_blood_donors/utils.dart';
import 'package:ist_blood_donors/apipage.dart';

class Mainlistpage extends StatefulWidget {
  const Mainlistpage({super.key});

  @override
  State<Mainlistpage> createState() => _MainlistpageState();
}

bool Loading = false;

class _MainlistpageState extends State<Mainlistpage> {
  @override
  void initState() {
    super.initState();
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
