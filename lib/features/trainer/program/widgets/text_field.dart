import 'package:flutter/material.dart';

Widget buildTextField(
  String hint, {
  IconData? suffixIcon,
  int maxLines = 1,
   TextEditingController? controller, TextInputType? keyboardType,
}) {
  return TextField(
    maxLines: maxLines,
    controller: controller,
    decoration: InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.green, width: 1.5),
      ),
      suffixIcon: suffixIcon != null
          ? Icon(suffixIcon, color: Colors.grey)
          : null,
    ),
  );
}
