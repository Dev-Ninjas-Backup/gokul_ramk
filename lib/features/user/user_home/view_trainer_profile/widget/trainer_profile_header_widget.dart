import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/user/user_home/view_trainer_profile/controller/view_trainer_profile_controller.dart';

class TrainerProfileHeaderWidget extends StatelessWidget {
  final String imageUrl, name, location;
  final bool fromMyTrainer;

  final ratingController = Get.put(ViewTrainerProfileController());

  TrainerProfileHeaderWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.fromMyTrainer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            spreadRadius: 5,
            blurRadius: 5,
            color: Colors.grey.shade100,
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(radius: 45, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(height: 12),
          Text(
            name,
            style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(location, style: getTextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 12),

          // ⭐ Rating System
          fromMyTrainer
              ? Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      int starIndex = index + 1;
                      return IconButton(
                        onPressed: () {
                          ratingController.rating.value = starIndex;
                        },
                        icon: Icon(
                          Icons.star,
                          size: 24,
                          color: ratingController.rating.value >= starIndex
                              ? Colors.orange
                              : Colors.grey.shade400,
                        ),
                      );
                    }),
                  );
                })
              : SizedBox.shrink(),
          fromMyTrainer
              ? Obx(
                  () => Text(
                    "Your Rating: ${ratingController.rating.value}/5",
                    style: getTextStyle(color: Colors.black87),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
