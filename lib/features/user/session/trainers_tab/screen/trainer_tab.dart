import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/user/session/controller/session_controller.dart';
import 'package:gokul_ramk/features/user/session/trainers_tab/widget/trainer_profile_card.dart';
import '../widget/top_trainer_item.dart';

class TrainerTab extends StatelessWidget {
  TrainerTab({super.key});
  final SessionController controller = Get.put(SessionController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Top Trainers Section
        Text(
          "Top Trainers",
          style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 130,
          child: Obx(
            () => ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.topTrainers.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                return TopTrainerItem(controller: controller, index: index);
              },
            ),
          ),
        ),

        const SizedBox(height: 14),

        /// Strength & Conditioning Trainers Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Strength & Conditioning Trainers",
              style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "See all",
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              controller.strengthTrainers.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SizedBox(
                  width: 280,
                  child: TrainerProfileCard(
                    trainer: controller.strengthTrainers[index],
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        /// Strength & Conditioning Trainers Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Yoga Trainers",
              style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "See all",
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              controller.strengthTrainers.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SizedBox(
                  width: 280,
                  child: TrainerProfileCard(
                    trainer: controller.strengthTrainers[index],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
