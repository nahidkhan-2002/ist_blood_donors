import 'package:flutter/material.dart';
import 'package:ist_blood_donors/style.dart';
import 'package:ist_blood_donors/loginpage.dart';
import 'package:page_transition/page_transition.dart';

// Global variable to store current user's phone number
String currentUserPhone = '';

Widget buildDrawerList(BuildContext context) {
  SnackBar snackBar = SnackBar(
    content: Text('You have been logged out'),
    backgroundColor: colorGreen,
    duration: Duration(seconds: 2),
  );
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
        title: const Text('Profile'),
        leading: Icon(Icons.person),
        onTap: () {
          //Navigator.pushReplacementNamed(context, 'profile');
        },
      ),
      ListTile(
        title: const Text('See Donors List'),
        leading: Icon(Icons.list),
        onTap: () {
          Navigator.pushReplacementNamed(context, 'mainlistpage');
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
        leading: Icon(Icons.settings),
        onTap: () {
          Navigator.pushReplacementNamed(context, 'developer');
        },
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.5),
      ListTile(
        title: const Text('Quit'),
        leading: Icon(Icons.logout),
        onTap: () {
          // Clear current user session
          currentUserPhone = '';
          showtoast("Thank You");
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.leftToRightWithFade,
              child: Loginpage(),
              duration: Duration(milliseconds: 400),
            ),
          );
        },
      ),
    ],
  );
}
