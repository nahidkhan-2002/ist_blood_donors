import 'package:flutter/material.dart';
import 'package:ist_blood_donors/style.dart';

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
          Navigator.pushReplacementNamed(context, 'profile');
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
          Navigator.pushReplacementNamed(context, 'contact');
        },
      ),
      ListTile(
        title: const Text('About Developer'),
        leading: Icon(Icons.settings),
        onTap: () {
          Navigator.pushReplacementNamed(context, 'developer');
        },
      ),
      const SizedBox(height: 150),
      ListTile(
        title: const Text('Logout'),
        leading: Icon(Icons.logout),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushReplacementNamed(context, 'login');
        },
      ),
    ],
  );
  
}
