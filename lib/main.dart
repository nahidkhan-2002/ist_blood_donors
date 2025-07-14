import 'profilepage.dart';
import 'mainlistpage.dart';
import 'package:flutter/material.dart';
import 'package:ist_blood_donors/contactus.dart';
import 'package:ist_blood_donors/loginpage.dart';
import 'package:ist_blood_donors/registerpage.dart';
import 'package:ist_blood_donors/developerdetails.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IST BLOOD DONORS',
      debugShowCheckedModeBanner: false,
      home: const Loginpage(),
      routes: {
        'register': (context) => Registerpage(),
        'login': (context) => Loginpage(),
        'mainlistpage': (context) => Mainlistpage(),
        'profile': (context) => Profilepage(),
        'contact' : (context) => Contactus(),
        'developer' : (context) => Developerdetails()
      },
    );
  }
}
