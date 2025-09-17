import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/auth/splash/controller/splash_controller.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.55,
                width: size.width,
                child: Center(
                  child: Image.asset(
                    Imagepath.splash,
                    height: size.height * 0.45,
                    width: size.width,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
               SizedBox(height: 38),
          
              Padding(
                padding:  EdgeInsets.only(bottom: 40.0),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return _buildDot(
                        isActive: controller.currentIndex.value == index,
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return AnimatedContainer(
      duration:  Duration(milliseconds: 300),
      margin:  EdgeInsets.symmetric(horizontal: 5.0),
      height: isActive ? 12 : 10, 
      width: isActive ? 12 : 10,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : Colors.grey[400],
        shape: BoxShape.circle,
      ),
    );
  }
}
