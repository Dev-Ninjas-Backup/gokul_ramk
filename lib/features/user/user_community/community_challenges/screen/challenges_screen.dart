import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/user/user_community/community_challenges/controller/challenges_controller.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class UserChallengesScreen extends StatelessWidget {
  UserChallengesScreen({super.key});

  final controller = Get.put(UserChallengesController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.events.isEmpty) {
        return Center(child: Text("No challenges available"));
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
                  SizedBox(
                    height: 6,
                    child: event['joined']
                        ? ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: [
                                  Colors.green.shade400,
                                  Colors.grey.withValues(alpha: 0.1),
                                ],
                              ).createShader(bounds);
                            },
                            child: LinearProgressIndicator(
                              borderRadius: BorderRadius.circular(20),
                              value: (event['progress'] as double) / 100,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),

                  SizedBox(height: 12),
                  event['joined']
                      ? Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(
                                AppRoute.getCompleteChallengeScreen(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.withValues(
                                alpha: 0.1,
                              ),
                            ),

                            child: Text(
                              "Already Joined",
                              style: getTextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.toNamed(
                                AppRoute.getCompleteChallengeScreen(),
                              );
                            },

                            child: Text(
                              "Join Challenge",
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
