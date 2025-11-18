import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/trainer/program/widgets/excercises_picker.dart';
import '../controller/program_controller.dart';
import '../widgets/text_field.dart';

class WorkoutPlanScreen extends StatelessWidget {
  final ProgramController controller = Get.find<ProgramController>();

  WorkoutPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "New Program",
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "Cancel",
              style: getTextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Workout Plan",
              style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Day Selector
            Obx(
              () => Row(
                children: List.generate(
                  7,

                  (i) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: GestureDetector(
                        onTap: () => controller.changeDay(i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: controller.selectedDay.value == i
                                ? Colors.green[50]
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Day ${i + 1}",
                            textAlign: TextAlign.center,
                            style: getTextStyle(
                              fontWeight: FontWeight.bold,
                              color: controller.selectedDay.value == i
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            exercisePicker(controller),

            _field("Sets", controller.setsC),
            _field("Reps", controller.repsC),
            _field("Duration (minutes)", controller.workoutDurationC),

            const SizedBox(height: 30),
            Text(
              "Attach a short intro video",
              style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(
              () => GestureDetector(
                onTap: controller.pickIntroVideo,
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: controller.introVideoFile.value == null
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.video_call,
                                size: 40,
                                color: Colors.grey,
                              ),
                              Text("Tap to add intro video"),
                            ],
                          ),
                        )
                      : Stack(
                          children: [
                            Center(
                              child: Icon(
                                Icons.video_file,
                                size: 50,
                                color: Colors.green,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: controller.removeIntroVideo,
                                child: const CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.black54,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),

            const SizedBox(height: 40),
            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.submitProgram,
                  child: controller.isLoading.value
                      ? const Text("Creating Program...")
                      : Text(
                          "Create Program",
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController c, {IconData? suffixIcon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          label,
          style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        buildTextField(label, controller: c, suffixIcon: suffixIcon),
      ],
    );
  }
}
