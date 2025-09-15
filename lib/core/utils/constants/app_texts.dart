import 'package:flutter/material.dart';

TextStyle getTextStyles({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  double? letterSpacing,
  double? height,
  TextDecoration? decoration,
}) {
  return TextStyle(
    fontFamily: 'Rajdhani',
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    letterSpacing: letterSpacing,
    height: height,
    decoration: decoration,
  );
}
