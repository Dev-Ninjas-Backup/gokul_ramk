import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/controller/trainer_profile_controller.dart';
import '../model/categories_model.dart';
import '../model/excercise_model.dart';
import '../services/program_services.dart';

class ProgramController extends GetxController {
  final ProgramService service = ProgramService();

  // Text Controllers
  final nameC = TextEditingController();
  final descriptionC = TextEditingController();
  final durationC = TextEditingController();
  final sessionsPerWeekC = TextEditingController();
  final priceC = TextEditingController();
  final maxParticipantsC = TextEditingController();

  // Workout Day Fields
  final exerciseIdC = TextEditingController();
  final setsC = TextEditingController();
  final repsC = TextEditingController();
  final workoutDurationC = TextEditingController();

  // Files
  var thumbnailFile = Rxn<File>();
  var introVideoFile = Rxn<File>();

  // URLs after upload
  var thumbnailUrl = "".obs;
  var videoUrl = "".obs;

  // Loading State
  var isLoading = false.obs;

  // Selected Day
  var selectedDay = 0.obs;

  // Categories
  var categories = <CategoryModel>[].obs;
  var selectedCategoryId = Rxn<String>();

  // Exercises
  var allExercises = <Exercise>[].obs;
  var selectedExercise = Rxn<Exercise>();

  final picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchExercises();
  }

  // =================== Fetch Categories ===================
  Future<void> fetchCategories() async {
    isLoading(true);
    try {
      final list = await ProgramService.fetchCategories();
      categories.assignAll(list);
      if (categories.isNotEmpty) selectedCategoryId.value = categories.first.id;

      if (kDebugMode) {
        print(
          "===============================================CateGories: ${categories.map((e) => e.name).toList()}",
        );
      }
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    } finally {
      isLoading(false);
    }
  }

  // =================== Fetch Exercises ===================
  Future<void> fetchExercises() async {
    isLoading(true);
    try {
      final response = await service.fetchAllExercises();
      allExercises.assignAll(response);

      // Print readable list of exercise names
      if (kDebugMode) {
        print(
          "===============================================Exercises: ${allExercises.map((e) => e.name).toList()}",
        );
      }

      if (selectedExercise.value == null && allExercises.isNotEmpty) {
        selectExercise(allExercises.first);
      } else {
        debugPrint("No Exercises=================");
      }
    } catch (e) {
      debugPrint("Error fetching exercises: $e");
    } finally {
      isLoading(false);
    }
  }

  void selectExercise(Exercise? exercise) {
    selectedExercise.value = exercise;
    exerciseIdC.text = exercise?.id ?? "";
  }

  String get selectedExerciseName =>
      selectedExercise.value?.name ?? "Select exercise";

  // =================== Pick Files ===================
  Future<void> pickThumbnail() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked != null) thumbnailFile.value = File(picked.path);
  }

  Future<void> pickIntroVideo() async {
    final picked = await picker.pickVideo(source: ImageSource.gallery);
    if (picked != null) introVideoFile.value = File(picked.path);
  }

  void removeThumbnail() => thumbnailFile.value = null;
  void removeIntroVideo() => introVideoFile.value = null;

  void changeDay(int day) => selectedDay.value = day;

  // =================== Clear Form Fields ===================
  void clearFormFields() {
    nameC.clear();
    descriptionC.clear();
    durationC.clear();
    sessionsPerWeekC.clear();
    priceC.clear();
    maxParticipantsC.clear();
    exerciseIdC.clear();
    setsC.clear();
    repsC.clear();
    workoutDurationC.clear();

    thumbnailFile.value = null;
    introVideoFile.value = null;
    thumbnailUrl.value = "";
    videoUrl.value = "";

    selectedDay.value = 0;
    if (categories.isNotEmpty) {
      selectedCategoryId.value = categories.first.id;
    }
    if (allExercises.isNotEmpty) {
      selectExercise(allExercises.first);
    }

    if (kDebugMode) print("✨ Form fields cleared");
  }

  Future<void> submitProgram() async {
    if (thumbnailFile.value == null) return debugPrint("Add thumbnail image");
    if (introVideoFile.value == null) return debugPrint("Add intro video");

    isLoading(true);
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: true,
    );

    try {
      // Upload files
      final thumb = await service.uploadFile(thumbnailFile.value!);
      final vid = await service.uploadFile(introVideoFile.value!);
      if (thumb == null || vid == null) return;

      thumbnailUrl.value = thumb;
      videoUrl.value = vid;

      // Prepare body
      final body = {
        "name": nameC.text.trim(),
        "description": descriptionC.text.trim(),
        "categoryId": selectedCategoryId.value,
        "duration": int.tryParse(durationC.text) ?? 4,
        "sessionsPerWeek": int.tryParse(sessionsPerWeekC.text) ?? 3,
        "thumbnailUrl": thumbnailUrl.value,
        "videoUrl": videoUrl.value,
        "price": double.tryParse(priceC.text) ?? 0.0,
        "maxParticipants": int.tryParse(maxParticipantsC.text) ?? 100,
        "workoutDays": [
          {
            "dayNumber": selectedDay.value + 1,
            "sets": int.tryParse(setsC.text) ?? 3,
            "reps": int.tryParse(repsC.text) ?? 12,
            "duration": int.tryParse(workoutDurationC.text) ?? 30,
            "exerciseId": exerciseIdC.text,
            "description": "Day ${selectedDay.value + 1} workout",
          },
        ],
      };

      final success = await service.createProgram(body);
      if (success) {
        Get.back(); // close loading dialog

        // Show success dialog
        Get.defaultDialog(
          title: "Success!",
          middleText: "Your program has been created successfully!",
          textConfirm: "Continue",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back(); // close success dialog

            // Refresh the program list in TrainerProfileController
            try {
              TrainerProfileController trainerProfileController;

              if (Get.isRegistered<TrainerProfileController>()) {
                trainerProfileController = Get.find<TrainerProfileController>();
              } else {
                trainerProfileController = Get.put(TrainerProfileController());
              }

              trainerProfileController.fetchPrograms();
              if (kDebugMode) print("✅ Programs list refreshed after creation");
            } catch (e) {
              if (kDebugMode) print("❌ Error refreshing programs: $e");
            }

            // Clear form fields
            clearFormFields();

            // Navigate back to previous screen
            Get.back();
          },
          barrierDismissible: false,
        );
        return; // Exit here to prevent finally block from closing the success dialog
      }
    } catch (e) {
      if (kDebugMode) print("❌ Error creating program: $e");
      Get.back(); // close loading dialog on error
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    // Dispose controllers
    for (var c in [
      nameC,
      descriptionC,
      durationC,
      sessionsPerWeekC,
      priceC,
      maxParticipantsC,
      exerciseIdC,
      setsC,
      repsC,
      workoutDurationC,
    ]) {
      c.dispose();
    }
    super.onClose();
  }
}
