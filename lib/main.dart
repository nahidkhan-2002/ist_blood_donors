import 'contactus.dart';
import 'loginpage.dart';
import 'profilepage.dart';
import 'mainlistpage.dart';
import 'registerpage.dart';
import 'theme_provider.dart';
import 'main_navigation.dart';
import 'mainsplashScreen.dart';
import 'firebase_options.dart';
import 'developerdetails.dart';
import 'language_provider.dart';
import 'SecondSplashScreen.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully");

    // Test Firebase connection
    try {
      await FirebaseAuth.instance.authStateChanges().first;
      print("Firebase Auth is working properly");

      // Test Firestore connection
      try {
        await FirebaseFirestore.instance.collection('test').limit(1).get();
        print("Firestore is working properly");
      } catch (e) {
        print("Firestore test failed: $e");
      }
    } catch (e) {
      print("Firebase Auth test failed: $e");
    }
  } catch (e) {
    print("Firebase initialization failed: $e");
    // You might want to show an error dialog here
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themeProvider, languageProvider, child) {
          return MaterialApp(
            title: 'IST BLOOD DONORS',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.themeData,
            home: const Splashscreen(),
            routes: {
              'register': (context) => Registerpage(),
              'login': (context) => Loginpage(),
              'mainlistpage': (context) => Mainlistpage(),
              'mainnavigation': (context) => MainNavigation(),
              'profile': (context) => Profilepage(),
              'contact': (context) => Contactus(),
              'developer': (context) => Developerdetails(),
              'secondsplashscreen': (context) => Secondsplashscreen(),
            },
          );
        },
      ),
    );
  }
}
