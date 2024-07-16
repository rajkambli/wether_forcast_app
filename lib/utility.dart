
import 'dart:ui';
import 'package:flutter/material.dart';
class Utility{

  static Color getHexColor(String hexValue){
    return Color(int.parse("0xFF$hexValue"));
  }

  static const TextStyle headline1 = TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle headline2 = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle labelText = TextStyle(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );

}