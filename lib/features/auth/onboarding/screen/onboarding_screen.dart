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
          Stack(
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

              Positioned(
                top: 48,
                left: 28,
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Skip',
                    style: getTextStyles(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.secondaryButtonColor,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
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

          SizedBox(height: 8),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
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
