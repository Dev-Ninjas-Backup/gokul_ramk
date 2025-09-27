// screen/community_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';
import 'package:gokul_ramk/features/trainer/community/challenges/screen/challenges_screen.dart';
import 'package:gokul_ramk/features/trainer/community/events/screen/event_screen.dart';
import 'package:gokul_ramk/features/trainer/community/groups/screen/groups_screen.dart';
import 'package:gokul_ramk/features/trainer/community/posts/controller/trainer_community_controller.dart';
import 'package:gokul_ramk/features/trainer/community/posts/screen/post_screen.dart';

class TrainerCommunityScreen extends StatelessWidget {
  TrainerCommunityScreen({super.key});
  final controller = Get.put(CommunityController());
  @override
  Widget build(BuildContext context) {
    final tabs = ["Posts", "Groups", "Events", "Challenges"];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Community",
                    style: getTextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(IconPath.searchIcon),
                  ),
                ],
              ),
              // Tabs
              Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: 8,
                    children: List.generate(
                      tabs.length,
                      (index) => ChoiceChip(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        label: Text(
                          tabs[index],
                          style: getTextStyle(
                            color: controller.selectedTab.value == index
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        selected: controller.selectedTab.value == index,
                        onSelected: (_) => controller.changeTab(index),
                        selectedColor: Colors.black,
                        backgroundColor: Colors.white,
                        showCheckmark: false,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: controller.selectedTab.value == index
                                ? Colors.black
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Tab content
              Expanded(
                child: Obx(() {
                  switch (controller.selectedTab.value) {
                    case 1: // Groups
                      return GroupsTab();
                    case 2:
                      return EventsScreen();
                    case 3:
                      return ChallengesScreen();
                    default:
                      return PostScreen();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
