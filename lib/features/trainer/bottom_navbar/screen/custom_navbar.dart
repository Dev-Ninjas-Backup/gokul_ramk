import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/trainer/bookings/my_bookings/screen/my_bookings_screen.dart';
import 'package:gokul_ramk/features/trainer/bottom_navbar/controller/navbar_controller.dart';
import 'package:gokul_ramk/features/trainer/community/posts/screen/posts.dart';
import 'package:gokul_ramk/features/trainer/my_clients/my_clients_screen/screen/my_clients_screen.dart';
import 'package:gokul_ramk/features/trainer/profile/add_product/screen/add_product_screen.dart';

import '../../home/home_screen/screen/home_screen.dart';
import '../../../../core/utils/constants/icon_path.dart';

class NavBarScreen extends StatelessWidget {
  const NavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NavBarController controller = Get.put(NavBarController());

    final List<Widget> pages = [
      const HomeScreen(),
      const MyClientsScreen(),
      const MyBookingsScreen(),
      const CommunityScreen(),
      AddProductScreen(),
    ];

    final List<String> icons = [
      IconPath.homeIcon,
      IconPath.programIcon,
      IconPath.calendarIcon,
      IconPath.groupIcon,
      IconPath.peopleIcon,
    ];

    final List<String> labels = ["", "", "", "", ""];

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey[100],
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white),
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
