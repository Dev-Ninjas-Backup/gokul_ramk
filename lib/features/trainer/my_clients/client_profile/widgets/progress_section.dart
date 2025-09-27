import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/my_clients/client_profile/controller/progress_filter_controller.dart';

class ProgressSection extends StatelessWidget {
  final ProgressFilterController controller = Get.put(
    ProgressFilterController(),
  );

  ProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          final data = controller.currentData;
          return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .15),

                  offset: Offset(2, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data['goalPercent']}% to today’s goal 🎯",
                      style: getTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryFontColor,
                      ),
                    ),

                    Text(
                      "Keep it up!",
                      style: getTextStyle(
                        color: AppColors.secondaryFontColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 70,
                      width: 70,
                      child: CircularProgressIndicator(
                        value: data['circlePercent'],
                        strokeWidth: 8,
                        backgroundColor: Colors.green.shade100,
                        valueColor: AlwaysStoppedAnimation(Colors.green),
                      ),
                    ),
                    Text(
                      "${(data['circlePercent'] * 100).toInt()}%",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
        SizedBox(height: 20),
        Obx(() {
          final data = controller.currentData;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: _buildStatCard(
                  data['program covered'],
                  "Program Covered",
                ),
              ),
              Expanded(
                child: _buildStatCard(data['workoutTime'], "Workout Time"),
              ),
              Expanded(
                child: _buildStatCard(data['calories'], "Calorie Target"),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      height: 110,
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 5,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: getTextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),

          Text(
            label,
            textAlign: TextAlign.center,
            style: getTextStyle(
              color: AppColors.secondaryFontColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
