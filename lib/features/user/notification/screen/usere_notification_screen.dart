import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/features/user/notification/controller/user_notification_controller.dart';
import 'package:gokul_ramk/features/user/notification/widget/user_notification_tile.dart';

class UsereNotificationScreen extends StatelessWidget {
  final UserNotificationController controller = Get.put(
    UserNotificationController(),
  );

  UsereNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Obx(() {
            var grouped = groupByCategory(controller.notifications);
            return Column(
              children: [
                CustomAppBarTitle(title: 'Notifications'),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: grouped.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...entry.value
                              .map((n) => UserNotificationTile(notification: n))
                              // ignore: unnecessary_to_list_in_spreads
                              .toList(),
                          const SizedBox(height: 20),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Map<String, List<dynamic>> groupByCategory(List list) {
    final Map<String, List<dynamic>> grouped = {};
    for (var item in list) {
      grouped.putIfAbsent(item.category, () => []).add(item);
    }
    return grouped;
  }
}
