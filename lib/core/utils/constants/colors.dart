import 'package:flutter/material.dart';

class AppColors {
  //Gradient background colors
  BoxDecoration buildGradientBackground(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final stopPoint = (screenHeight - 506) / screenHeight;

    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: const [Color(0xFFFFFFFF), Color(0xFF0088A3)],
        stops: [stopPoint.clamp(0.0, 1.0), 1.0],
      ),
    );
  }

  //Font colors
  static const Color primaryFontColor = Color(0XFF363636);
  static const Color secondaryFontColor = Color(0XFF737373);

  //TextField colors
  static const Color textFieldFillColor = Color(0xFFF5F5F5);
  //Button colors
  static const Color primaryButtonColor = Color(0xFF60BF7B);
  static const Color secondaryButtonColor = Color(0XFFE8F4F8);
  //Font color
  static const Color fontColor = Color(0xFF636363);
  //Border color
  static const Color borderColor = Color(0xFFEBEBEB);
  static const Color background = Color(0xFFFFFFFF);
  static const Color primaryColor = Color(0XFF60BF7B);
}
