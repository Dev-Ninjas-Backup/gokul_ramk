import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/controller/tell_about_youselt_controller.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/widget/goal_item.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/widget/tell_us_page_heading.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class TellUsAboutYourGoalsScreen extends StatelessWidget {
  TellUsAboutYourGoalsScreen({super.key});

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
              TellUsPageHeading(title: 'Tell Us About Your Goals'),

              const SizedBox(height: 16),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.goals.length,
                    itemBuilder: (context, index) {
                      final goal = controller.goals[index];
                      return GoalItem(
                        title: goal.title,
                        emoji: goal.emoji,
                        isSelected: goal.isSelected,
                        onTap: () => controller.toggleGoal(index),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 26),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoute.gettellUsAboutYourTrainingScreen());
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
