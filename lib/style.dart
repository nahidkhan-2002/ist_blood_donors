import 'package:flutter/material.dart';

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

ScreenBackground (){
  Svgpicture.
}