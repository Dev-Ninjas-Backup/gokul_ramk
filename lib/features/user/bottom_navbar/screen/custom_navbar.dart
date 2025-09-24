import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';
import 'package:gokul_ramk/features/user/bottom_navbar/controller/navbar_controller.dart';
import 'package:gokul_ramk/features/user/session/screen/session_screen.dart';
import 'package:gokul_ramk/features/user/shop/screen/shop_screen.dart';
import 'package:gokul_ramk/features/user/user_home/screen/user_home_screen.dart';
import 'package:gokul_ramk/features/user/user_profile/screen/user_profile_screen.dart';


class UserNavBarScreen extends StatelessWidget {
   UserNavBarScreen({super.key});
  final UserNavBarController controller = Get.put(UserNavBarController());
  @override
  Widget build(BuildContext context) {
    

    final List<Widget> pages = [
      UserHomeScreen(),
      SessionsScreen(),
      ShopScreen(),
      const Center(child: Text("Post Page")),
      UserProfileScreen(),
    ];

    final List<String> icons = [
      IconPath.userHome,
      IconPath.userSession,
      IconPath.useCart,
      IconPath.userPost,
      IconPath.userProfile,
    ];

    final List<String> labels = [
      "",
      "",
      "",
      "",
      "",
    ];

    return Obx(
      () => Scaffold(
        backgroundColor: Colors.grey[100],
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,                    
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
                      icons[index],
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
