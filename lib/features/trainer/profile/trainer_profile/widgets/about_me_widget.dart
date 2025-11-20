import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/controller/trainer_profile_controller.dart';

class AboutMeWidget extends StatelessWidget {
  const AboutMeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrainerProfileController>();

    return Obx(() {
      final trainer = controller.trainerProfileData.value;

      if (trainer == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (trainer.specializations.isNotEmpty == true)
            Wrap(
              spacing: 8,
              children: trainer.specializations
                  .map(
                    (tag) => Chip(
                      label: Text(
                        tag,
                        style: getTextStyle(fontWeight: FontWeight.w600),
                      ),
                      backgroundColor: const Color(0xFFE8F4F8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                  .toList(),
            ),

          const SizedBox(height: 16),

          Text(
            "About Me",
            style: getTextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 54, 3, 3),
            ),
          ),
          const SizedBox(height: 8),

          Text(
            trainer.bio.isNotEmpty == true ? trainer.bio : 'No bio yet',
            style: getTextStyle(
              fontSize: 15,
              color: AppColors.secondaryFontColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF9F2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "⭐  4.89",
                      style: getTextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    const Text("Average Rating"),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    InfoItem(icon: Icons.verified, text: "Certified Trainer"),
                    InfoItem(icon: Icons.timer, text: "5+ Years Experience"),
                    InfoItem(icon: Icons.group, text: "200+ Clients"),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoItem({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.green, size: 18),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }
}