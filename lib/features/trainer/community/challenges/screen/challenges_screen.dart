import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/models/enums/user_role.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

import '../controller/challenges_controller.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key, this.userRole = UserRole.trainer});

  final UserRole userRole;

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  late ChallengesController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ChallengesController());
    // Ensure challenges are loaded when screen is first opened
    if (controller.challengeModels.isEmpty &&
        !controller.isLoadingChallenges.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.fetchChallenges();
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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Show loading indicator if fetching challenges
      if (controller.isLoadingChallenges.value) {
        return Center(child: CircularProgressIndicator());
      }

      // Show empty state if no challenges
      if (controller.challengeModels.isEmpty) {
        return Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.flag, size: 64, color: Colors.grey[400]),
                  SizedBox(height: 16),
                  Text(
                    "No challenges available",
                    style: getTextStyle(
                      fontSize: 16,
                      color: Colors.grey[600] ?? Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoute.createChallenge);
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
      }

      return Stack(
        children: [
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            itemCount: controller.challengeModels.length,
            itemBuilder: (context, index) {
              final challenge = controller.challengeModels[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: controller.challengeModels.length - 1 == index
                      ? 70
                      : 0,
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
                            child: challenge.coverImage != null
                                ? Image.network(
                                    challenge.coverImage!,
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: double.infinity,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 200,
                                        color: Colors.grey[300],
                                        child: Icon(Icons.image_not_supported),
                                      );
                                    },
                                  )
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
                                  challenge.format
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
                              challenge.title,
                              style: getTextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${_formatDate(challenge.startDate)} - ${_formatTime(challenge.startDate)}',
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
                            challenge.location ?? 'Online Challenge',
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
                        child: Row(
                          children: [
                            Text(
                              '${challenge.participantCount} ${challenge.participantCount == 1 ? 'participant' : 'participants'}',
                              style: getTextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            if (challenge.targetValue != null) ...[
                              SizedBox(width: 16),
                              Text(
                                'Target: ${challenge.targetValue} ${challenge.targetUnit ?? 'units'}',
                                style: getTextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle action based on role
                            if (widget.userRole == UserRole.trainer) {
                              // Handle host challenge action
                            } else {
                              // Handle join challenge action
                            }
                          },
                          child: Text(
                            widget.userRole == UserRole.trainer
                                ? "Host Challenge"
                                : "Join Challenge",
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
              child: widget.userRole == UserRole.trainer
                  ? GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoute.createChallenge);
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
