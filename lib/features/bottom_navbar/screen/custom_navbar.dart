import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/bottom_navbar/controller/navbar_controller.dart';

import '../../trainer/home/home_screen/screen/home_screen.dart';
import '../../../core/utils/constants/icon_path.dart';

class NavBarScreen extends StatelessWidget {
  const NavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavBarController controller = Get.put(NavBarController());

    final List<Widget> pages = [
      const HomeScreen(),
      const Center(child: Text("Programs Page")),
      const Center(child: Text("Calendar Page")),
      const Center(child: Text("Group Page")),
      const Center(child: Text("Profile Page")),
    ];

    final List<String> icons = [
      IconPath.homeIcon,
      IconPath.programIcon,
      IconPath.calendarIcon,
      IconPath.groupIcon,
      IconPath.peopleIcon,
    ];

    final List<String> labels = [
      "Home",
      "Programs",
      "Calender",
      "Group",
      "Profile",
    ];

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey[100],
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(icons.length, (index) {
              bool isSelected = controller.currentIndex.value == index;
              return GestureDetector(
                onTap: () => controller.changeIndex(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      icons[index], // 👈 FIXED
                      width: 28,
                      height: 28,
                      color: isSelected ? Colors.blue : Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      labels[index],
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? Colors.blue : Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
