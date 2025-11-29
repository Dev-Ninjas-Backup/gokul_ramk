import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';
import 'package:gokul_ramk/features/user/user_profile/controller/user_profile_controller.dart';
import 'package:gokul_ramk/features/user/user_profile/widget/settings_tile.dart';
import 'package:gokul_ramk/features/user/user_profile/widget/user_profile_header.dart';
import 'package:gokul_ramk/features/user/user_profile/widget/user_profile_stat_card.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});

  final UserProfileController controller = Get.put(UserProfileController());
  final SharedPreferencesHelperController sharedPreferencesHelper = Get.put(
    SharedPreferencesHelperController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Profile",
                  style: getTextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Profile Header
              Obx(
                () => UserProfileHeader(
                  name: controller.userName.value,
                  onEdit: () {
                    // Handle edit profile
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Stats
              Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      UserProfileStatCard(
                        title: "Active Days",
                        value: "${controller.activeDays.value} Days",
                      ),
                      UserProfileStatCard(
                        title: "Challenges Complete",
                        value: "${controller.challengesComplete.value}",
                      ),
                      UserProfileStatCard(
                        title: "Calories Burned",
                        value: "${controller.caloriesBurned.value}",
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // General Section
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "General",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    SettingsTile(
                      icon: Icon(Icons.person_outline, color: Colors.grey),
                      title: "Personal Details",
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    SettingsTile(
                      icon: Icon(
                        Icons.fitness_center_outlined,
                        color: Colors.grey,
                      ),
                      title: "Fitness Info",
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    SettingsTile(
                      icon: Icon(Icons.notifications_none, color: Colors.grey),
                      title: "Notification",
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    SettingsTile(
                      icon: Icon(
                        Icons.medical_information_outlined,
                        color: Colors.grey,
                      ),
                      title: "Medical Info",
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    SettingsTile(
                      icon: ImageIcon(
                        AssetImage(IconPath.languageIcon),
                        color: Colors.grey,
                      ),
                      title: "Language",
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Help & Support",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    SettingsTile(
                      icon: Image.asset(IconPath.contactUsIcon),
                      title: "Contact Us",
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    SettingsTile(
                      icon: Icon(Icons.description_sharp, color: Colors.grey),
                      title: "Terms & Conditions",
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    SettingsTile(
                      icon: Icon(
                        Icons.privacy_tip_outlined,
                        color: Colors.grey,
                      ),
                      title: "Privacy & Security",
                      onTap: () {},
                    ),
                    const Divider(height: 1),
                    SettingsTile(
                      icon: Icon(
                        Icons.help_outline_outlined,
                        color: Colors.grey,
                      ),
                      title: "Help & Support",
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              SizedBox(
                width: 180,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF4D4F),
                  ),
                  onPressed: () {
                    sharedPreferencesHelper.clearAllData();
                    Get.offAllNamed(AppRoute.loginScreen);
                  },
                  child: Text('Logout'),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
