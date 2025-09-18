import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/controller/tell_about_youselt_controller.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/widget/tell_us_page_heading.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/widget/training_days_item.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class TellUsAboutTrainingScreen extends StatelessWidget {
  TellUsAboutTrainingScreen({super.key});

  final TellAboutYouseltController controller = Get.put(
    TellAboutYouseltController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TellUsPageHeading(title: 'Your Training Days'),

              const SizedBox(height: 16),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.traingDays.length,
                    itemBuilder: (context, index) {
                      final traingDay = controller.traingDays[index];
                      return TrainingDaysItem(
                        title: traingDay.title,
                        isSelected: traingDay.isSelected,
                        onTap: () => controller.toggleTrainingDays(index),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 26),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoute.consentAgreementScreen);
                },
                child: Text('Continue'),
              ),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
