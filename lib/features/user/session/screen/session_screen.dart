import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';
import 'package:gokul_ramk/features/user/session/controller/session_controller.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/screen/nutrition_tab.dart';
import 'package:gokul_ramk/features/user/session/sessions_tab/screen/sessions_tab.dart';
import 'package:gokul_ramk/features/user/session/trainers_tab/screen/trainer_tab.dart';
import 'package:gokul_ramk/features/user/session/widget/tab_button.dart';

class SessionsScreen extends StatelessWidget {
  SessionsScreen({super.key});
  final SessionController controller = Get.put(SessionController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SessionAppBar(),
                const SizedBox(height: 20),
                Obx(
                  () => Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: controller.categories
                              .map(
                                (cat) => TabButton(
                                  label: cat,
                                  isSelected:
                                      controller.selectedCategory.value == cat,
                                  onTap: () =>
                                      controller.selectedCategory.value = cat,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      getWidget(controller),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget getWidget(SessionController controller) {
  if (controller.selectedCategory.value == 'Sessions') {
    return SessionsTab();
  } else if (controller.selectedCategory.value == 'Trainers') {
    return TrainerTab();
  } else {
    return NutritionTab();
  }
}

class SessionAppBar extends StatelessWidget {
  const SessionAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Discover',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Image.asset(IconPath.searchIcon),
            ),
            SizedBox(width: 16),
            GestureDetector(
              onTap: () {},
              child: Image.asset(IconPath.menuIcon),
            ),
          ],
        ),
      ],
    );
  }
}
