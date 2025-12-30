import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/controller/trainer_profile_controller.dart';

class TrainerProfileCardWidget extends StatelessWidget {
  const TrainerProfileCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrainerProfileController>();

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
          Stack(
            children: [
              Obx(() {
                final controllerImage =
                    controller.trainerProfileData.value?.images;
                final args = Get.arguments;
                final fallbackImage = (args is List && args.length > 1)
                    ? (args[1] as String? ?? '')
                    : '';
                final imageUrl = fallbackImage.isNotEmpty
                    ? fallbackImage
                    : (controllerImage ?? "");

                return CircleAvatar(
                  radius: 50,
                  backgroundImage: imageUrl.isNotEmpty
                      ? NetworkImage(imageUrl)
                      : const NetworkImage(
                          "https://www.pngitem.com/pimgs/m/663-6635378_user-avatar-login-account-profile-people-simple-head.png",
                        ),
                );
              }),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: controller.updateProfileImage,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Obx(() {
            final nameFromController =
                controller.trainerProfileData.value?.fullname;
            // fallback: sometimes we navigate with updated args — try to read Get.arguments
            final args = Get.arguments;
            final fallbackName = (args is List && args.isNotEmpty)
                ? (args[0] as String? ?? '')
                : '';
            final displayName = fallbackName.isNotEmpty
                ? fallbackName
                : (nameFromController ?? "");

            return Text(
              displayName,
              style: getTextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryFontColor,
              ),
            );
          }),

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
