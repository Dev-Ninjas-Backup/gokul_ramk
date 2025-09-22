import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/my_clients/client_profile/controller/recent_activity_controller.dart';
import 'package:gokul_ramk/features/trainer/my_clients/client_profile/widgets/activity_card_widget.dart';

class RecentActivitySection extends StatelessWidget {
  final RecentActivityController controller = Get.put(
    RecentActivityController(),
  );

  RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Activity",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryFontColor,
              ),
            ),
            Obx(
              () => TextButton(
                onPressed: () {
                  controller.showAll.toggle();
                },
                child: Text(
                  controller.showAll.value ? "Show Less" : "Show All",
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryFontColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),

        Obx(() {
          final visibleActivities = controller.showAll.value
              ? controller.activities
              : controller.activities.take(2).toList();

          return Column(
            children: visibleActivities.map((activity) {
              return ActivityCard(
                icon: activity['icon'],
                title: activity['title'],
                subtitle: activity['subtitle'],
                value: activity['value'],
                background: Color(activity['color']),
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}
