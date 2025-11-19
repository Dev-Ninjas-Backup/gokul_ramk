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
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 5,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                controller.trainerProfileData.value?.images ?? "",
              ),
            ),
          ),
          SizedBox(height: 12),
          Obx(
            () => Text(
              controller.trainerProfileData.value?.fullname ?? "",
              style: getTextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryFontColor,
              ),
            ),
          ),

          Obx(
            () => Text(
              controller.trainerProfileData.value?.email ?? "",
              style: getTextStyle(
                fontSize: 16,
                color: AppColors.secondaryFontColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Obx(
            () => Text(
              controller.trainerProfileData.value?.phone ?? "",
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
