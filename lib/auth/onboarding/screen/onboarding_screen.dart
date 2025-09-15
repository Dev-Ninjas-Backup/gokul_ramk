import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/utils/constants/app_texts.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 540,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Imagepath.onboarding1),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              'Your Fitness Journey Starts Here',
              textAlign: TextAlign.center,
              style: getTextStyles(
                fontWeight: FontWeight.w700,
                fontSize: 32,
                color: AppColors.primaryFontColor,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              'Track workouts, connect with trainers, and stay motivated',
              textAlign: TextAlign.center,
              style: getTextStyles(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.secondaryFontColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
