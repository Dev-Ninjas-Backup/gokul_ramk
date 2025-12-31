import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/models/enums/user_role.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

import '../controller/event_controller.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key, this.userRole = UserRole.trainer});

  final UserRole userRole;

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late EventsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(EventsController());
    // Ensure events are loaded when screen is first opened
    if (controller.eventModels.isEmpty && !controller.isLoadingEvents.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.fetchEvents();
      });
    }
  }

  String _formatDate(DateTime dateTime) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return '${days[dateTime.weekday % 7]}, ${months[dateTime.month - 1]} ${dateTime.day}';
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final period = dateTime.hour < 12 ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}$period';
  }

  Widget _buildImageWithLoading(String imageUrl) {
    return Container(
      height: 200,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                // Image is fully loaded
                return child;
              }
              // Image is still loading
              return Container(
                color: Colors.grey[100],
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue.shade600,
                    ),
                    strokeWidth: 3.0,
                    backgroundColor: Colors.blue.shade100,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 200,
                color: Colors.grey[300],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported,
                        size: 48,
                        color: Colors.grey[500],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Image not available',
                        style: getTextStyle(
                          fontSize: 12,
                          color: Colors.grey[600] ?? Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Show loading indicator if fetching events
      if (controller.isLoadingEvents.value) {
        return Center(child: CircularProgressIndicator());
      }

      // Show empty state if no events
      if (controller.eventModels.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.event_note, size: 64, color: Colors.grey[400]),
              SizedBox(height: 16),
              Text(
                "No events available",
                style: getTextStyle(
                  fontSize: 16,
                  color: Colors.grey[600] ?? Colors.grey,
                ),
              ),
            ],
          ),
        );
      }

      return Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            itemCount: controller.eventModels.length,
            itemBuilder: (context, index) {
              final event = controller.eventModels[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: controller.eventModels.length - 1 == index ? 70 : 0,
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
                            child: event.coverImage != null
                                ? _buildImageWithLoading(event.coverImage!)
                                : Container(
                                    height: 200,
                                    color: Colors.grey[300],
                                    child: Icon(Icons.image),
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
                                  event.format
                                      .toString()
                                      .split('.')
                                      .last
                                      .toLowerCase(),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.title,
                              style: getTextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${_formatDate(event.startDate)} - ${_formatTime(event.startDate)}',
                              style: getTextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
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
                            event.location ?? 'Online Event',
                            style: getTextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, bottom: 8),
                        child: Text(
                          '${event.participantCount} ${event.participantCount == 1 ? 'participant' : 'participants'}',
                          style: getTextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: widget.userRole == UserRole.trainer
                            ? SizedBox.shrink()
                            : Obx(() {
                                final isJoining = controller.joiningEventIds
                                    .contains(event.id);
                                return ElevatedButton(
                                  onPressed: isJoining
                                      ? null
                                      : () {
                                          // Join event action
                                          controller.joinEvent(event.id);
                                        },
                                  child: isJoining
                                      ? SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  Colors.white,
                                                ),
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Text(
                                          "Join Event",
                                          style: getTextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                );
                              }),
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
              child: widget.userRole == UserRole.trainer
                  ? GestureDetector(
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
                    )
                  : SizedBox.shrink(),
            ),
          ),
        ],
      );
    });
  }
}
