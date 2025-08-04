import 'profilepage.dart';
import 'mainlistpage.dart';
import 'mainsplashScreen.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ist_blood_donors/contactus.dart';
import 'package:ist_blood_donors/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ist_blood_donors/registerpage.dart';
import 'package:ist_blood_donors/developerdetails.dart';
import 'package:ist_blood_donors/SecondSplashScreen.dart';

void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      home: const Splashscreen(),
      routes: {
        'register': (context) => Registerpage(),
        'login': (context) => Loginpage(),
        'mainlistpage': (context) => Mainlistpage(),
        'contact': (context) => Contactus(),
        'developer': (context) => Developerdetails(),
        'secondsplashscreen': (context) => Secondsplashscreen(),
      },
    );
  }
}
