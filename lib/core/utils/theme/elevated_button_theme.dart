import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';

ElevatedButtonThemeData getElevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryButtonColor,
      foregroundColor: Colors.white,
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      minimumSize: Size(double.maxFinite, 48),
      elevation: 0,
    ),
  );
}
