// screen/community_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/trainer/community/challenges/screen/challenges_screen.dart';
import 'package:gokul_ramk/features/trainer/community/events/screen/event_screen.dart';

import '../../../../../core/utils/constants/icon_path.dart';
import '../../groups/screen/groups_screen.dart';
import '../controller/posts_controller.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CommunityController());

    final tabs = ["Posts", "Groups", "Events", "Challenges"];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Community",
          style: getTextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Image.asset(IconPath.searchIcon)),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Tabs
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: List.generate(
                tabs.length,
                (index) => ChoiceChip(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
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
                  return Center(child: Text("Coming soon..."));
              }
            }),
          ),
        ],
      ),
    );
  }
}
