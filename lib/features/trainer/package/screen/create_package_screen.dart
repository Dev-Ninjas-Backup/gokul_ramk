import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import '../controller/create_package_controller.dart';
import '../model/workout_model.dart';
import 'workout_list_screen.dart';

class CreatePackageScreen extends StatelessWidget {
  final Workout? workoutToUpdate;
  final bool isUpdateMode;

  const CreatePackageScreen({
    super.key,
    this.workoutToUpdate,
    this.isUpdateMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      CreatePackageController(),
      tag: isUpdateMode ? 'update_${workoutToUpdate?.id}' : 'create',
    );

    // Set update mode data if provided
    if (isUpdateMode && workoutToUpdate != null) {
      controller.isUpdateMode.value = true;
      controller.workoutToUpdate.value = workoutToUpdate;
      // Prefill fields
      Future.delayed(Duration.zero, () {
        controller.populateUpdateFields(workoutToUpdate!);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.isUpdateMode.value
              ? "Update Workout"
              : controller.templateFound.value
              ? "Create Workout"
              : "Request Workout Template",
          style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          if (!controller.isUpdateMode.value)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Center(
                child: TextButton.icon(
                  onPressed: () {
                    Get.to(
                      () => const WorkoutListScreen(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  icon: const Icon(Icons.list),
                  label: const Text("Workouts"),
                ),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Field
                Text("Name", style: getTextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                TextField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    hintText: "Enter workout name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Category Dropdown
                Text(
                  "Category",
                  style: getTextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                if (controller.templateFound.value == false &&
                    controller.isUpdateMode.value == false)
                  DropdownButtonFormField<String>(
                    initialValue: controller.selectedCategoryId.value,
                    items: controller.categoryList.map((category) {
                      return DropdownMenuItem(
                        value: category.id,
                        child: Text(category.name ?? "Unknown"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedCategoryId.value = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    hint: Text("Select Category"),
                  ),
                SizedBox(height: 16),

                // Difficulty Dropdown
                Text(
                  "Difficulty",
                  style: getTextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: controller.selectedDifficulty.value,
                  items: controller.difficultyOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      controller.selectedDifficulty.value = newValue;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Workout Type Dropdown - Only for template request mode
                if (controller.templateFound.value == false &&
                    controller.isUpdateMode.value == false) ...[
                  Text(
                    "Workout Type",
                    style: getTextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: controller.selectedWorkoutType.value,
                    items: controller.workoutTypeOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        controller.selectedWorkoutType.value = newValue;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],

                // Duration Field
                if (controller.selectedWorkoutType.value == 'ONLINE') ...[
                  Text(
                    "Duration (minutes)",
                    style: getTextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: controller.durationController,
                    readOnly: true,
                    onTap: () => controller.pickDuration(context),
                    decoration: InputDecoration(
                      hintText: "Select Duration",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: Icon(Icons.access_time, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 16),
                ],

                // Status Dropdown
                Text(
                  "Status",
                  style: getTextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                if (controller.templateFound.value == false &&
                    controller.isUpdateMode.value == false)
                  DropdownButtonFormField<String>(
                    initialValue: controller.selectedStatus.value,
                    items: controller.statusOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        controller.selectedStatus.value = newValue;
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                SizedBox(height: 16),

                // Cover Image Picker
                Text(
                  "Cover Image",
                  style: getTextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Stack(
                  children: [
                    GestureDetector(
                      onTap: controller.pickImage,
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                          image: controller.pickedImage.value != null
                              ? DecorationImage(
                                  image: FileImage(
                                    controller.pickedImage.value!,
                                  ),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: controller.pickedImage.value == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_a_photo, color: Colors.grey),
                                  Text("Tap to select image"),
                                ],
                              )
                            : null,
                      ),
                    ),
                    if (controller.pickedImage.value != null)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => controller.pickedImage.value = null,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 16),

                // Description Field
                Text(
                  "Description",
                  style: getTextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: controller.descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Enter description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 32),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.createPackage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            controller.isUpdateMode.value
                                ? "Update Workout"
                                : controller.templateFound.value
                                ? "Create Workout"
                                : "Request Template",
                            style: getTextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
