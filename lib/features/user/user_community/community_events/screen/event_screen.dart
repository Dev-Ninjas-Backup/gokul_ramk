import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/user/user_community/community_events/controller/event_controller.dart';

class UserEventsScreen extends StatelessWidget {
  UserEventsScreen({super.key});

  final controller = Get.put(UserEventsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.events.isEmpty) {
        return Center(child: Text("No events available"));
      }
      return ListView.builder(
        itemCount: controller.events.length,
        itemBuilder: (context, index) {
          final event = controller.events[index];
          return Card(
            color: Colors.green.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentGeometry.center,
                    child: Text(
                      event["title"] ?? "",
                      style: getTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  Align(
                    alignment: AlignmentGeometry.center,
                    child: Text(
                      event["date"] ?? "",
                      style: getTextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle host event action
                      },

                      child: Text(
                        "Join Event",
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
          );
        },
      );
    });
  }
}
