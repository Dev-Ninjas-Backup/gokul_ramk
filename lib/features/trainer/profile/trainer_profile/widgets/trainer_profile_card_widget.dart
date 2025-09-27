import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/controller/trainer_profile_controller.dart';

class TrainerProfileCardWidget extends StatelessWidget {
  const TrainerProfileCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrainerProfileController());

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(controller.image.value),
            ),
          ),
          SizedBox(height: 12),
          Obx(
            () => Text(
              controller.name.value,
              style: getTextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryFontColor,
              ),
            ),
          ),

          Obx(
            () => Text(
              controller.email.value,
              style: getTextStyle(
                fontSize: 16,
                color: AppColors.secondaryFontColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Obx(
            () => Text(
              controller.phone.value,
              style: getTextStyle(
                fontSize: 16,
                color: AppColors.secondaryFontColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
