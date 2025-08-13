import 'style.dart';
import 'package:flutter/material.dart';

// Global variables to store current user's information
String currentUserPhone = '';
String currentUserName = '';
String currentUserBloodGroup = '';
String currentUserDepartment = '';
String currentUserSession = '';

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
          Navigator.pushReplacementNamed(context, 'mainnavigation');
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
        subtitle: const Text('Go to Settings → Developer'),
        leading: Icon(Icons.developer_mode),
        onTap: () {
          Navigator.pushReplacementNamed(context, 'mainnavigation');
          // Navigate to main navigation, user can then go to Settings tab
          // and access Developer Details from there
        },
      ),
      ListTile(
        title: const Text('Quit'),
        subtitle: const Text('Logout from the app'),
        leading: Icon(Icons.logout),
        onTap: () {
          // Clear current user session
          currentUserPhone = '';
          currentUserName = '';
          currentUserBloodGroup = '';
          currentUserDepartment = '';
          currentUserSession = '';
          showtoast("Thank You");
          Navigator.pushReplacementNamed(context, 'login');
        },
      ),
    ],
  );
}
