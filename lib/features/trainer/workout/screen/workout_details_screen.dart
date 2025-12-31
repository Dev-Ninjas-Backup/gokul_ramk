import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import '../model/workout_model.dart';
import 'create_workout_screen.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  final Workout workout;

  const WorkoutDetailsScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Workout Details",
          style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Get.to(
                () => CreateWorkoutScreen(
                  workoutToUpdate: workout,
                  isUpdateMode: true,
                ),
                transition: Transition.rightToLeft,
              );
            },
            tooltip: "Edit Workout",
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: _showDeleteConfirmation,
            tooltip: "Delete Workout",
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image
            if (workout.coverImage != null)
              Image.network(
                workout.coverImage!,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 250,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 80),
                  );
                },
              ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    workout.name ?? "Unknown",
                    style: getTextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Info Cards
                  Row(
                    children: [
                      _buildInfoCard(
                        icon: Icons.speed,
                        label: "Difficulty",
                        value: workout.difficulty ?? "N/A",
                        color: _getDifficultyColor(workout.difficulty),
                      ),
                      const SizedBox(width: 12),
                      _buildInfoCard(
                        icon: Icons.timer_outlined,
                        label: "Duration",
                        value: "${workout.duration ?? 0} min",
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 12),
                      _buildInfoCard(
                        icon: Icons.fitness_center,
                        label: "Exercises",
                        value: "${workout.exercises?.length ?? 0}",
                        color: Colors.purple,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Description
                  Text(
                    "Description",
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    workout.description ?? "No description available",
                    style: getTextStyle(
                      fontSize: 14,
                      color: Colors.grey[700] ?? Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Exercises Section
                  if (workout.exercises != null &&
                      workout.exercises!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Exercises",
                          style: getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: workout.exercises!.length,
                          itemBuilder: (context, index) {
                            final exercise = workout.exercises![index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Exercise Number and Name
                                    Row(
                                      children: [
                                        Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${index + 1}",
                                              style: getTextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            exercise.name ?? "Unknown",
                                            style: getTextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    // Exercise Description
                                    if (exercise.description != null &&
                                        exercise.description!.isNotEmpty)
                                      Text(
                                        exercise.description!,
                                        style: getTextStyle(
                                          fontSize: 12,
                                          color:
                                              Colors.grey[600] ?? Colors.grey,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                  const SizedBox(height: 24),

                  // Metadata
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMetadataRow(
                          "Created",
                          _formatDate(workout.createdAt),
                        ),
                        const SizedBox(height: 8),
                        _buildMetadataRow(
                          "Last Updated",
                          _formatDate(workout.updatedAt),
                        ),
                        if (workout.usageCount != null) ...[
                          const SizedBox(height: 8),
                          _buildMetadataRow(
                            "Usage Count",
                            workout.usageCount.toString(),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: getTextStyle(
                fontSize: 10,
                color: Colors.grey[600] ?? Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetadataRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getTextStyle(
            fontSize: 12,
            color: Colors.grey[600] ?? Colors.grey,
          ),
        ),
        Text(
          value,
          style: getTextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Color _getDifficultyColor(String? difficulty) {
    switch (difficulty?.toUpperCase()) {
      case 'BEGINNER':
        return Colors.green;
      case 'INTERMEDIATE':
        return Colors.orange;
      case 'ADVANCED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return "${date.day}/${date.month}/${date.year}";
  }

  void _showDeleteConfirmation() {
    Get.defaultDialog(
      title: "Delete Workout",
      middleText:
          "Are you sure you want to delete this workout? This action cannot be undone.",
      textConfirm: "Delete",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: _deleteWorkout,
    );
  }

  Future<void> _deleteWorkout() async {
    Get.back(); // Close dialog
    Get.defaultDialog(
      title: "Deleting...",
      content: const CircularProgressIndicator(),
      barrierDismissible: false,
    );

    try {
      final SharedPreferencesHelperController sharedPreference = Get.put(
        SharedPreferencesHelperController(),
      );
      String? token = await sharedPreference.getAccessToken();

      final response = await GetConnect().delete(
        Urls.deleteWorkout(workout.id ?? ''),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );

      Get.back(); // Close loading dialog

      if (response.statusCode == 200 || response.statusCode == 204) {
        Get.snackbar("Success", "Workout deleted successfully");
        Get.back(); // Go back to list
      } else {
        Get.snackbar(
          "Error",
          "Failed to delete workout: ${response.statusText}",
        );
      }
    } catch (e) {
      Get.back(); // Close loading dialog
      Get.snackbar("Error", "An error occurred: $e");
    }
  }
}

class SharedPreferencesHelperController extends GetxController {
  Future<String?> getAccessToken() async {
    // This will be implemented in actual code
    return null;
  }
}
