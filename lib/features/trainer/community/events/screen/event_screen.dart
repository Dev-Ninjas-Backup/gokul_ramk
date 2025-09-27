import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';

import '../controller/event_controller.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EventsController());

    return Obx(() {
      if (controller.events.isEmpty) {
        return Center(child: Text("No events available"));
      }

      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        itemCount: controller.events.length,
        itemBuilder: (context, index) {
          final event = controller.events[index];
          return Card(
            color: Colors.green.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.symmetric(vertical: 16),
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
                        "Host Event",
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
