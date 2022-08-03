import 'package:flutter/material.dart';

TextStyle getStyle(
    {FontWeight? weight = FontWeight.w400,
    double? fontSize = 18,
    FontStyle? fontStyle = FontStyle.normal,
    Color? color = Colors.black,
    double? height}) {
  return TextStyle(
      fontWeight: weight,
      fontSize: fontSize,
      fontStyle: fontStyle,
      height: height,
      color: color);
}

const Color colorPink = Colors.pink;
const Color colorWhite = Colors.white;
const Color colorGrey = Colors.grey;
