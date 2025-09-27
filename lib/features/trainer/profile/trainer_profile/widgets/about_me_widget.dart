import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/controller/trainer_profile_controller.dart';

class AboutMeWidget extends StatelessWidget {
  const AboutMeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrainerProfileController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Wrap(
            spacing: 36,
            children: controller.tags
                .map(
                  (tag) => Chip(
                    label: Text(
                      tag,
                      style: getTextStyle(fontWeight: FontWeight.w600),
                    ),
                    backgroundColor: Color(0xFFE8F4F8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        SizedBox(height: 16),

        Text(
          "About Me",
          style: getTextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryFontColor,
          ),
        ),
        SizedBox(height: 8),

        Obx(
          () => Text(
            controller.description.value,
            style: getTextStyle(
              fontSize: 15,
              color: AppColors.secondaryFontColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 16),

        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Color(0xFFEFF9F2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Obx(
            () => Row(
              children: [
                Column(
                  children: [
                    Icon(Icons.star, color: Colors.amber),
                    SizedBox(width: 6),
                    Text(
                      controller.rating.value.toString(),
                      style: getTextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.fontColor,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Average Rating",
                      style: getTextStyle(color: AppColors.primaryFontColor),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _infoItem(Icons.verified, "Certified Trainer"),
                        SizedBox(width: 2),

                        _infoItem(
                          Icons.schedule,
                          controller.yearsExperience.value,
                        ),
                        SizedBox(width: 2),

                        _infoItem(Icons.group, controller.clientsCount.value),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primaryFontColor),

        Text(
          text,
          style: getTextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryFontColor,
          ),
        ),
      ],
    );
  }
}
