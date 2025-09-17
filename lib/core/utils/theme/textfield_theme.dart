import 'package:flutter/material.dart';

InputDecorationTheme getInputDecorationTheme() {
  return InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[200],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  );
}
