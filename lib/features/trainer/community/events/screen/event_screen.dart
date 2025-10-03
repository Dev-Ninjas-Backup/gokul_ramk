import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

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

      return Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            itemCount: controller.events.length,
            itemBuilder: (context, index) {
              final event = controller.events[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: controller.events.length - 1 == index ? 70 : 0,
                ),
                child: Card(
                  color: Colors.green.shade50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.asset(
                              Imagepath.yogaGroup,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.green.shade50,
                                ),
                                child: Text(
                                  event['isOnline'] ? 'online' : 'on-site',
                                  style: getTextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Align(
                          alignment: AlignmentGeometry.centerLeft,
                          child: Text(
                            event["isOnline"] ? "" : event['location'],
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.createEvent);
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue.withValues(alpha: 0.6),
                  ),
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
