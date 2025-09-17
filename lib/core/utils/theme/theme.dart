import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/core/utils/theme/elevated_button_theme.dart';
import 'package:gokul_ramk/core/utils/theme/textfield_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Rajdhani',
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: getElevatedButtonThemeData(),
    inputDecorationTheme: getInputDecorationTheme()
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Rajdhani',
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: Colors.black,
    elevatedButtonTheme: getElevatedButtonThemeData(),
    inputDecorationTheme: getInputDecorationTheme()
  );
}
