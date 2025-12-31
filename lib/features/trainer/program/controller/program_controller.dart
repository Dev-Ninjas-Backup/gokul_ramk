import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/controller/trainer_profile_controller.dart';
import '../model/categories_model.dart';
import '../model/excercise_model.dart';
import '../services/program_services.dart';
import 'my_programs_controller.dart';

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

  // Difficulty
  var selectedDifficulty = Rxn<String>();
  final difficultyOptions = ["BEGINNER", "INTERMEDIATE", "ADVANCED"];

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

  // Update mode
  var isUpdateMode = false.obs;
  var updateProgramId = Rxn<String>();

  final picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    // fetchExercises();
  }

  // Initialize with program data for update mode
  void initializeWithProgram(Map<String, dynamic> programData) {
    isUpdateMode.value = true;
    updateProgramId.value = programData['id'];
    nameC.text = programData['name'] ?? "";
    descriptionC.text = programData['description'] ?? "";
    priceC.text = programData['price']?.toString() ?? "";
    maxParticipantsC.text = programData['maxParticipants']?.toString() ?? "50";
    selectedDifficulty.value = programData['difficulty'];

    // Set URLs for existing files (no file object needed for update)
    thumbnailUrl.value = programData['thumbnailUrl'] ?? "";
    videoUrl.value = programData['videoUrl'] ?? "";
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
  // Future<void> fetchExercises() async {
  //   isLoading(true);
  //   try {
  //     final response = await service.fetchAllExercises();
  //     allExercises.assignAll(response);

  //     // Print readable list of exercise names
  //     if (kDebugMode) {
  //       print(
  //         "===============================================Exercises: ${allExercises.map((e) => e.name).toList()}",
  //       );
  //     }

  //     if (selectedExercise.value == null && allExercises.isNotEmpty) {
  //       selectExercise(allExercises.first);
  //     } else {
  //       debugPrint("No Exercises=================");
  //     }
  //   } catch (e) {
  //     debugPrint("Error fetching exercises: $e");
  //   } finally {
  //     isLoading(false);
  //   }
  // }

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
    // Validation
    if (nameC.text.isEmpty) {
      Get.snackbar('Validation', 'Program name is required');
      return;
    }
    if (descriptionC.text.isEmpty) {
      Get.snackbar('Validation', 'Description is required');
      return;
    }
    if (!isUpdateMode.value && thumbnailFile.value == null) {
      Get.snackbar('Validation', 'Thumbnail image is required');
      return;
    }
    if (!isUpdateMode.value && introVideoFile.value == null) {
      Get.snackbar('Validation', 'Video is required');
      return;
    }
    if (selectedDifficulty.value == null) {
      Get.snackbar('Validation', 'Please select difficulty level');
      return;
    }
    if (priceC.text.isEmpty) {
      Get.snackbar('Validation', 'Price is required');
      return;
    }

    isLoading(true);
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      // Upload files if new files are selected
      if (thumbnailFile.value != null) {
        final thumb = await service.uploadFile(thumbnailFile.value!);
        if (thumb == null) {
          Get.back();
          isLoading(false);
          Get.snackbar('Error', 'Thumbnail upload failed');
          return;
        }
        thumbnailUrl.value = thumb;
      }

      if (introVideoFile.value != null) {
        final vid = await service.uploadFile(introVideoFile.value!);
        if (vid == null) {
          Get.back();
          isLoading(false);
          Get.snackbar('Error', 'Video upload failed');
          return;
        }
        videoUrl.value = vid;
      }

      // Prepare body with new schema
      final body = {
        "name": nameC.text.trim(),
        "description": descriptionC.text.trim(),
        "difficulty": selectedDifficulty.value,
        "thumbnailUrl": thumbnailUrl.value,
        "videoUrl": videoUrl.value,
        "price": int.tryParse(priceC.text) ?? 0,
        "currency": "USD",
        "isActive": true,
        "maxParticipants": int.tryParse(maxParticipantsC.text) ?? 50,
      };

      bool success;
      if (isUpdateMode.value) {
        debugPrint(
          'PATCH /programs/[1m[31m[4m${updateProgramId.value}[0m with body:',
        );
        debugPrint(body.toString());
        success = await service.updateProgram(updateProgramId.value!, body);
      } else {
        success = await service.createProgram(body);
      }

      if (success) {
        clearFormFields();
        isUpdateMode.value = false;
        updateProgramId.value = null;
        Get.back(); // close loading dialog
        isLoading(false);

        // Small delay to let snackbar fully render before navigating
        await Future.delayed(const Duration(milliseconds: 500));

        // Refresh programs list if MyProgramsController is registered
        if (Get.isRegistered<MyProgramsController>()) {
          if (kDebugMode) print("🔄 Calling refreshPrograms after update...");
          final programsController = Get.find<MyProgramsController>();
          await programsController.refreshPrograms();
          if (kDebugMode) print("✅ Programs refreshed after update");
        } else {
          if (kDebugMode) print("⚠️ MyProgramsController not registered");
        }

        Get.back(); // navigate back
        return;
      }
      // If not successful, close dialog and let snackbar show (service shows error snackbar)
      Get.back();
    } catch (e) {
      if (kDebugMode) print("❌ Error submitting program: $e");
      Get.back(); // close loading dialog
      isLoading(false);
      Get.snackbar('Error', 'Error: ${e.toString()}');
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
