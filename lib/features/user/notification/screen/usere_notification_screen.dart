// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/user/notification/controller/user_notification_controller.dart';
import 'package:gokul_ramk/features/user/notification/model/user_notification_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatelessWidget {
  final NotificationController controller = Get.find<NotificationController>();

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Category selector
          Obx(() {
            final selected = controller.selectedCategory.value;

            return SizedBox(
              height: 50, // height of your category bar
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: List.generate(controller.categories.length, (
                    index,
                  ) {
                    final cat = controller.categories[index];
                    final isSelected = selected == cat;

                    return GestureDetector(
                      onTap: () => controller.changeCategory(cat),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 8,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          cat.capitalize!,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            );
          }),

          // Notification List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return _shimmerList();
              }

              final list = controller.notifications;
              if (list.isEmpty) {
                return const Center(child: Text("No notifications found"));
              }

              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final item = list[index];
                  return _notificationTile(item);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _notificationTile(UserNotificationModel item) {
    return GestureDetector(
      onTap: () {
        if (!(item.isRead ?? false)) controller.markAsRead(item.id!);
      },
      child: Obx(() {
        final isExpanded = controller.expandedMap[item.id] ?? false;
        return Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: item.isRead == true
                ? Colors.white
                : Colors.blue.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: item.isRead == true ? Colors.grey.shade300 : Colors.blue,
              width: item.isRead == true ? 1 : 1.5,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.isRead == false)
                Container(
                  height: 10,
                  width: 10,
                  margin: const EdgeInsets.only(right: 8, top: 4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: item.isRead == false
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.message ?? "",
                      maxLines: isExpanded ? null : 1,
                      //  overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: item.isRead == false
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.createdAt != null
                              ? timeago.format(item.createdAt!)
                              : "",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => controller.toggleExpanded(item.id!),
                          child: Text(
                            isExpanded ? "See Less" : "See More",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       item.createdAt != null
                    //           ? timeago.format(DateTime.parse(item.createdAt as String))
                    //           : "",
                    //       style: const TextStyle(fontSize: 12, color: Colors.grey),
                    //     ),
                    //     GestureDetector(
                    //       onTap: () => controller.toggleExpanded(item.id!),
                    //       child: Text(
                    //         isExpanded ? "See less" : "See more",
                    //         style: const TextStyle(
                    //             fontSize: 12,
                    //             color: Colors.blue,
                    //             fontWeight: FontWeight.w500),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              if (item.imageUrl != null && item.imageUrl!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item.imageUrl!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image, size: 35),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _shimmerList() {
    return ListView.builder(
      itemCount: 6,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      },
    );
  }
}
