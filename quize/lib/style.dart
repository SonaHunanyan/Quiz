import 'package:flutter/material.dart';

TextStyle getStyle(
    {FontWeight? weight = FontWeight.w400,
    double? fontSize = 18,
    String fontFamily = fontNameDefault,
    FontStyle? fontStyle = FontStyle.normal,
    Color? color = Colors.black,
    double? height}) {
  return TextStyle(
      fontFamily: fontFamily,
      fontWeight: weight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      height: height,
      color: color);
}

const Color colorPink = Colors.pink;
const Color colorWhite = Colors.white;
const Color colorGrey = Colors.grey;

const String fontNameDefault = 'Quicksand';
