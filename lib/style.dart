import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

const colorRed = Color.fromARGB(255, 225, 83, 83);
const colorBlue = Color.fromARGB(255, 0, 123, 255);
const colorGreen = Color.fromARGB(255, 40, 167, 69);

InputDecoration AppInputDecoration(label) {
  return InputDecoration(
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(215, 243, 56, 23),
        width: 1.0,
      ),
    ),
    fillColor: Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 213, 192, 192),
        width: 1.0,
      ),
    ),
    border: OutlineInputBorder(),
    labelText: label,
    labelStyle: TextStyle(color: const Color.fromARGB(136, 0, 0, 0)),
  );
}

InputDecoration AppInputDecorationPass(label) {
  return InputDecoration(
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(215, 243, 56, 23),
        width: 1.0,
      ),
    ),
    fillColor: Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 20),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromARGB(255, 213, 192, 192),
        width: 1.0,
      ),
    ),
    border: OutlineInputBorder(),
    labelText: label,
    labelStyle: TextStyle(color: const Color.fromARGB(136, 0, 0, 0)),
    suffixIcon: TextButton(
      onPressed: () {},
      child: Text(
        "Show Password",
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Container ScreenBackground(context) {
  return Container(
    decoration: const BoxDecoration(
      gradient: RadialGradient(
        center: Alignment.bottomLeft,
        radius: 1.5,
        colors: [
          Color.fromARGB(255, 242, 76, 76), // Deep red
          Color.fromARGB(120, 255, 200, 200), // Soft red blur
          Color(0xFFFFFFFF), // White
        ],
        stops: [0.2, 0.6, 1.0],
      ),
    ),
  );
}

Container ScreenBackgroundReg(context) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 255, 132, 71), // গাঢ় নীল
          Color(0xFF2C5364), // গাঢ় পার্পল/ম্যাজেন্টা
        ],
        stops: [0.5, 0.9],
      ),
    ),
  );
}

void showtoast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black54,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
