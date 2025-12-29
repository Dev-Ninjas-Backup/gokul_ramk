import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import '../controller/edit_exercise_controller.dart';

class EditExerciseScreen extends StatelessWidget {
  final String exerciseId;
  final controller = Get.put(EditExerciseController());

  EditExerciseScreen({super.key, required this.exerciseId});

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
          'Select Workout',
          style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Obx(() {
          if (controller.workouts.isEmpty)
            return const Text('No workouts found');
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
    // Initialize controller with id
    controller.init(exerciseId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Exercise'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.isLoading.value)
            return const Center(child: CircularProgressIndicator());

          return Column(
            children: [
              input('Name', controller.nameCtrl),
              input('Description', controller.descCtrl, maxLines: 3),
              input('Sets', controller.setsCtrl),
              input('Reps', controller.repsCtrl),
              input('Time (sec)', controller.timeCtrl),
              input('Rest (sec)', controller.restCtrl),

              workoutsDropdown(),

              ElevatedButton(
                onPressed: controller.updateExercise,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Update Exercise'),
              ),

              const SizedBox(height: 35),
            ],
          );
        }),
      ),
    );
  }
}
