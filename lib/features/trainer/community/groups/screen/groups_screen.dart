import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/trainer/community/groups/controller/groups_controller.dart';
import 'package:gokul_ramk/features/trainer/community/groups/screen/create_group.dart';

import '../../../../../core/common/styles/global_text_style.dart';

class GroupsTab extends StatefulWidget {
  const GroupsTab({super.key});

  @override
  State<GroupsTab> createState() => _GroupsTabState();
}

class _GroupsTabState extends State<GroupsTab> {
  void _showLeaveGroupDialog(
    BuildContext context,
    GroupsController controller,
    String groupId,
    int index,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red[100],
                ),
                child: Icon(
                  Icons.warning_outlined,
                  size: 40,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Leave Group?',
                style: getTextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Are you sure you want to leave this group?',
                textAlign: TextAlign.center,
                style: getTextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => Get.back(),
                      child: Text(
                        'Cancel',
                        style: getTextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        controller.leaveGroup(groupId, index);
                        Get.back();
                      },
                      child: Text(
                        'Leave',
                        style: getTextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GroupsController());

    return Obx(
      () => CustomScrollView(
        slivers: [
          // Create Group Banner
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.lightBlue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
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
                        Get.to(() => CreateGroupScreen());
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
            ),
          ),

          // Groups List
          if (controller.groups.isEmpty && !controller.isLoadingGroups.value)
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'No groups available',
                    style: getTextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final group = controller.groups[index];
                return Card(
                  color: Colors.lightGreen[50],
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Group Thumbnail with Leave Icon
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.network(
                              group.thumbnail,
                              height: 150.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 150.h,
                                  color: Colors.grey[300],
                                  child: Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          // Leave button overlay (only show if joined)
                          if (group.isJoined)
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Obx(
                                () => Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                    onPressed:
                                        controller.joiningGroupId.value ==
                                            group.id
                                        ? null
                                        : () => _showLeaveGroupDialog(
                                            context,
                                            controller,
                                            group.id,
                                            index,
                                          ),
                                    padding: EdgeInsets.all(6),
                                    constraints: BoxConstraints(),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      // Group Info
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
                                    group.name,
                                    style: getTextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                // Members avatars
                                if (group.members.isNotEmpty)
                                  SizedBox(
                                    width: 60.w,
                                    height: 24.h,
                                    child: Stack(
                                      children: [
                                        for (
                                          int i = 0;
                                          i <
                                              (group.members.length > 3
                                                  ? 3
                                                  : group.members.length);
                                          i++
                                        )
                                          Positioned(
                                            left: (i * 16).toDouble(),
                                            child: CircleAvatar(
                                              radius: 12.r,
                                              backgroundColor: Colors.grey[300],
                                              child: Text(
                                                group.members[i].fullname[0],
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                SizedBox(width: 8.w),
                                Text(
                                  '${group.memberCount} members',
                                  style: getTextStyle(
                                    color: Colors.grey,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              group.description,
                              style: getTextStyle(
                                color: Colors.grey,
                                fontSize: 12.sp,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 10),
                            // Show Join button only if not joined
                            if (!group.isJoined)
                              SizedBox(
                                width: double.infinity,
                                child: Obx(
                                  () => ElevatedButton(
                                    onPressed:
                                        controller.joiningGroupId.value ==
                                            group.id
                                        ? null
                                        : () => controller.joinGroup(
                                            group.id,
                                            index,
                                          ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    child:
                                        controller.joiningGroupId.value ==
                                            group.id
                                        ? SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    Colors.white,
                                                  ),
                                            ),
                                          )
                                        : Text(
                                            "Join Group",
                                            style: getTextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
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
              }, childCount: controller.groups.length),
            ),

          // Loading indicator at the bottom
          if (controller.isLoadingGroups.value)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }
}
