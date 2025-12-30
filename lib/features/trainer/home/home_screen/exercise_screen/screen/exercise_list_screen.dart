import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import '../controller/exercise_list_controller.dart';
import '../model/exercise_model.dart';
import '../service/exercise_service.dart';
import 'edit_exercise_screen.dart';

class ExerciseListScreen extends StatelessWidget {
  final controller = Get.put(ExerciseListController());

  ExerciseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Exercises'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.exercises.isEmpty) {
          return const Center(child: Text('No exercises found'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.exercises.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final Exercise ex = controller.exercises[index];
            return _buildExerciseCard(ex);
          },
        );
      }),
    );
  }

  /// Custom Card using Row and Column to prevent overflow
  Widget _buildExerciseCard(Exercise ex) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Text Content - Wrapped in Expanded to prevent horizontal overflow
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  ex.name,
                  style: getTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ex.description,
                  style: getTextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis, // Adds "..." if text is too long
                ),
              ],
            ),
          ),

          const SizedBox(width: 12), // Gap between text and buttons
          // 2. Action Buttons Column
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIconButton(
                icon: Icons.edit_outlined,
                color: Colors.blue,
                onTap: () =>
                    Get.to(() => EditExerciseScreen(exerciseId: ex.id)),
              ),
              const SizedBox(height: 8),
              _buildIconButton(
                icon: Icons.delete_outline,
                color: Colors.red,
                onTap: () => _confirmDelete(ex),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Reusable Icon Button to keep code clean
  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  /// Delete logic extracted for readability
  void _confirmDelete(Exercise ex) {
    Get.defaultDialog(
      title: 'Delete Exercise',
      middleText: 'Are you sure you want to delete "${ex.name}"?',
      textCancel: 'Cancel',
      textConfirm: 'Delete',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () async {
        Get.back(); // close dialog
        final res = await ExerciseService.deleteExerciseById(ex.id);
        if (res.isSuccess) {
          Get.snackbar('Success', 'Exercise deleted successfully');
          controller.fetchExercises(page: controller.page.value);
        } else {
          Get.snackbar(
            'Error',
            res.errorMessage ?? 'Delete failed',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      },
    );
  }
}
