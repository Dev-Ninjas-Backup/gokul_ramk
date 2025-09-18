import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/auth/onboarding/controller/onboarding_controller.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () => Stack(
                children: [
                  Container(
                    height: 440,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          controller.headingImagePathList[controller
                              .pageNumber
                              .value],
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 68,
                    left: 22,
                    child: GestureDetector(
                      onTap: () {
                        Get.offAllNamed(AppRoute.getloginScreen());
                      },
                      child: Text(
                        'Skip',
                        style: getTextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: AppColors.secondaryButtonColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  controller.pageTitleList[controller.pageNumber.value],
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 32,
                    color: AppColors.primaryFontColor,
                  ),
                ),
              ),
            ),

            SizedBox(height: 8),

            Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  controller.pageSubTitleList[controller.pageNumber.value],
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.secondaryFontColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 26),

            Obx(
              () => Image.asset(
                controller.pageBarImagePathList[controller.pageNumber.value],
              ),
            ),
            SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(
                () => ElevatedButton(
                  onPressed: () {
                    if (controller.pageNumber.value < 2) {
                      controller.pageNumber.value++;
                    } else {
                      Get.offAllNamed(AppRoute.getloginScreen());
                    }
                  },
                  child: Text(
                    controller.buttonTextList[controller.pageNumber.value],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
