import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/home/home_screen/screen/dashboard.dart';
import '../../utils/constants/icon_path.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    final List<Widget> pages = [
      const DashboardPage(),
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
