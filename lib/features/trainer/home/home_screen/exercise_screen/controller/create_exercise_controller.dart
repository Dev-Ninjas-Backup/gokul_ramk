import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/exercise_screen/model/get_workout_model.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/exercise_screen/service/exercise_service.dart';

class CreateExerciseController extends GetxController {
  final ExerciseService service = ExerciseService(
    NetworkClient(onUnAuthorize: () => EasyLoading.showInfo("Unauthorized")),
  );

  // inputs
  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final setsCtrl = TextEditingController();
  final repsCtrl = TextEditingController();
  final timeCtrl = TextEditingController();
  final restCtrl = TextEditingController();

  // workouts
  var workouts = <GetWorkout>[].obs;
  var selectedWorkoutId = RxnString();

  // loading
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWorkouts();
  }

  Future<void> fetchWorkouts() async {
    isLoading(true);
    try {
      final list = await ExerciseService.fetchWorkouts();
      workouts.assignAll(list);
      if (workouts.isNotEmpty) selectedWorkoutId.value = workouts.first.id;
    } catch (e) {
      print("Fetch workouts error: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> createExercise() async {
    try {
      isLoading(true);

      final workout = workouts.firstWhere(
        (w) => w.id == selectedWorkoutId.value,
        orElse: () => GetWorkout(id: '', name: '', exercises: []),
      );

      // determine order automatically to avoid duplicate order conflicts
      final int order = workout.exercises.length + 1;

      final body = {
        "name": nameCtrl.text.trim(),
        "description": descCtrl.text.trim(),
        "sets": int.tryParse(setsCtrl.text.trim()) ?? 0,
        "reps": repsCtrl.text.trim(),
        "time": int.tryParse(timeCtrl.text.trim()) ?? 0,
        "rest": int.tryParse(restCtrl.text.trim()) ?? 0,
        "order": order,
        "workoutId": selectedWorkoutId.value,
      };

      final res = await service.createExercise(data: body);

      if (res.isSuccess) {
        EasyLoading.showInfo("Exercise created successfully");
        clearAll();
      } else {
        Get.snackbar("Error", res.errorMessage ?? "Failed to create exercise");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading(false);
    }
  }

  void clearAll() {
    nameCtrl.clear();
    descCtrl.clear();
    setsCtrl.clear();
    repsCtrl.clear();
    timeCtrl.clear();
    restCtrl.clear();
    selectedWorkoutId.value = workouts.isNotEmpty ? workouts.first.id : null;
  }
}
