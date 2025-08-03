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

Image ScreenBackground(context) {
  return Image.asset(
    'asset_project/loginbg.png',
    alignment: Alignment.center,
    colorBlendMode: BlendMode.screen,
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    fit: BoxFit.cover,
  );
}

SvgPicture ScreenBackgroundReg(context) {
  return SvgPicture.asset(
    'asset_project/reg_bg.svg',
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    fit: BoxFit.cover,
  );
}

void showtoast(String message)
{
  Fluttertoast.showToast(msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 16.0);
}