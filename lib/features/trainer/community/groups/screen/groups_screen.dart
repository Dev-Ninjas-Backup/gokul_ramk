import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/trainer/community/groups/screen/create_group.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../posts/controller/posts_controller.dart';

class GroupsTab extends StatelessWidget {
  const GroupsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CommunityController>();

    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: controller.groups.length + 1,
        itemBuilder: (context, index) {
          if (index == controller.groups.length) {
            return Container(
              width: 50,
              height: 150,
              margin: EdgeInsets.only(top: 16),
              padding: EdgeInsets.all(20),
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
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(CreateGroupScreen());
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
                                fontSize: 14.sp,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          SizedBox(
                            width: 60.w,
                            height: 24.h,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  child: CircleAvatar(
                                    radius: 12.r,
                                    backgroundImage: NetworkImage(
                                      'https://randomuser.me/api/portraits/women/1.jpg',
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 16.w,
                                  child: CircleAvatar(
                                    radius: 12.r,
                                    backgroundImage: NetworkImage(
                                      'https://randomuser.me/api/portraits/women/2.jpg',
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 32.w,
                                  child: CircleAvatar(
                                    radius: 12.r,
                                    backgroundImage: NetworkImage(
                                      'https://randomuser.me/api/portraits/women/3.jpg',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            group.members,
                            style: getTextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
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
