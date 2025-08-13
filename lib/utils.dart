import 'style.dart';
import 'loginpage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

// Global variable to store current user's phone number
String currentUserPhone = '';

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
      Spacer(),
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
