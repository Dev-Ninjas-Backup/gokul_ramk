import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/user/user_home/controller/user_home_controller.dart';
import 'package:gokul_ramk/features/user/user_home/widget/program_detail_workout_card.dart';

class ProgramDetailsScreen extends StatelessWidget {
  final UserHomeController controller = Get.put(UserHomeController());

  ProgramDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBarTitle(title: 'HIIT Program'),
              const SizedBox(height: 12),

              // Program Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  Imagepath.trainer,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 12),

              // Duration & Type
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Text("Duration: ${controller.duration.value}")),
                  Obx(() => Text("Type: ${controller.type.value}")),
                ],
              ),

              const SizedBox(height: 16),

              // Description
              Text(
                "Description-",
                style: getTextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 6),
              Obx(
                () => Text(
                  controller.description.value,
                  style: getTextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),

              const SizedBox(height: 20),

              Obx(() {
                if (controller.joinedHitProgram.value == false) {
                  return ElevatedButton(
                    onPressed: () {
                      controller.joinedHitProgram.value = true;
                    },
                    child: Text('Join Now'),
                  );
                }

                return Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.withValues(alpha: 0.1),
                          foregroundColor: Colors.red,
                        ),
                        child: Text('Cancel Program'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},

                        child: Text('Reschedule'),
                      ),
                    ),
                  ],
                );
              }),

              // Buttons Row
              const SizedBox(height: 20),

              // Workout Schedule
              Text(
                "Workout Schedule-",
                style: getTextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),

              Obx(
                () => Column(
                  children: controller.workoutSchedule
                      .map((item) => ProgramDetailWorkoutCard(text: item))
                      .toList(),
                ),
              ),

              const SizedBox(height: 16),

              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('View more'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
