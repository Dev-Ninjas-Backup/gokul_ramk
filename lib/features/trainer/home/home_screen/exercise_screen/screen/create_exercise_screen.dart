import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import '../controller/create_exercise_controller.dart';

class CreateExerciseScreen extends StatelessWidget {
  final controller = Get.put(CreateExerciseController());

  CreateExerciseScreen({super.key});

  Widget input(String label, TextEditingController ctrl, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget workoutsDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Workout",
          style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Obx(() {
          if (controller.workouts.isEmpty) {
            return const Text("No workouts found");
          }

          return DropdownButtonFormField<String>(
            value: controller.selectedWorkoutId.value,
            items: controller.workouts
                .map((w) => DropdownMenuItem(value: w.id, child: Text(w.name)))
                .toList(),
            onChanged: (v) => controller.selectedWorkoutId.value = v,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }),
        const SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Exercise'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            input("Name", controller.nameCtrl),
            input("Description", controller.descCtrl, maxLines: 3),
            input("Sets", controller.setsCtrl),
            input("Reps", controller.repsCtrl),
            input("Time (sec)", controller.timeCtrl),
            input("Rest (sec)", controller.restCtrl),

            workoutsDropdown(),

            Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: controller.createExercise,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Create Exercise'),
                    ),
            ),

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
