import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/user/user_community/community_posts/controller/user_community_controller.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class UserGroupsTab extends StatelessWidget {
  UserGroupsTab({super.key});
  final controller = Get.find<UserCommunityController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.all(6),
        itemCount: controller.groups.length + 1,
        itemBuilder: (context, index) {
          //build create group container
          if (index == controller.groups.length) {
            return Container(
              width: 50,
              height: 150,
              margin: EdgeInsets.only(top: 16),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentGeometry.center,
                    child: Text(
                      "Create a Group",
                      style: getTextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.getUserCreateGroupScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "Create New",
                        style: getTextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          final group = controller.groups[index];
          //build join group container
          return Card(
            color: Colors.lightGreen[50],
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(group.imagePath, fit: BoxFit.cover),
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              group.title,
                              style: getTextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 60,
                            height: 24,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundImage: NetworkImage(
                                      'https://randomuser.me/api/portraits/women/1.jpg',
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 16,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundImage: NetworkImage(
                                      'https://randomuser.me/api/portraits/women/2.jpg',
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 32,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundImage: NetworkImage(
                                      'https://randomuser.me/api/portraits/women/3.jpg',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            group.members,
                            style: getTextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => controller.toggleJoin(index),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: group.isJoined
                                ? Colors.grey
                                : Colors.green,
                          ),
                          child: Text(
                            group.isJoined ? "Joined" : "Join Group",
                            style: getTextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
