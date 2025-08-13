import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'English';

  String get currentLanguage => _currentLanguage;

  void setLanguage(String language) {
    _currentLanguage = language;
    notifyListeners();
  }

  String getText(String englishText, String banglaText) {
    return _currentLanguage == 'English' ? englishText : banglaText;
  }

  // Common text translations
  String get donorList => getText('Donor List', 'দাতার তালিকা');
  String get profile => getText('Profile', 'প্রোফাইল');
  String get settings => getText('Settings', 'সেটিংস');
  String get darkMode => getText('Dark Mode', 'ডার্ক মোড');
  String get language => getText('Language', 'ভাষা');
  String get developer => getText('Developer', 'ডেভেলপার');
  String get aboutUs => getText('About Us', 'আমাদের সম্পর্কে');
  String get appearance => getText('Appearance', 'দেখার ধরন');
  String get switchTheme => getText('Switch between light and dark themes', 'হালকা এবং গাঢ় থিমের মধ্যে পরিবর্তন করুন');
  String get english => getText('English', 'ইংরেজি');
  String get bangla => getText('বাংলা', 'বাংলা');
  String get developerDetails => getText('Developer Details', 'ডেভেলপার বিবরণ');
  String get viewDeveloperInfo => getText('View developer information', 'ডেভেলপার তথ্য দেখুন');
  String get appName => getText('IST Blood Donors App', 'আইএসটি ব্লাড ডোনার অ্যাপ');
  String get appDescription => getText(
    'This app serves as a comprehensive platform for managing blood donor information within the IST community. It facilitates quick access to donor details, blood group information, and contact details, ensuring efficient blood donation coordination during emergencies.',
    'এই অ্যাপটি আইএসটি সম্প্রদায়ের মধ্যে ব্লাড ডোনার তথ্য পরিচালনার জন্য একটি বিস্তৃত প্ল্যাটফর্ম হিসেবে কাজ করে। এটি জরুরি অবস্থায় দক্ষ রক্তদান সমন্বয় নিশ্চিত করে দাতার বিবরণ, রক্তের গ্রুপের তথ্য এবং যোগাযোগের বিবরণ দ্রুত অ্যাক্সেস করতে সহায়তা করে।'
  );
  String get version => getText('Version: 1.0.0', 'সংস্করণ: ১.০.০');
}
