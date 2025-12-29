import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/exercise_screen/controller/exercise_list_controller.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/exercise_screen/model/exercise_model.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/exercise_screen/model/get_workout_model.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/exercise_screen/service/exercise_service.dart';

class EditExerciseController extends GetxController {
  final ExerciseService service = ExerciseService(
    NetworkClient(onUnAuthorize: () => EasyLoading.showInfo('Unauthorized')),
  );

  final nameCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final setsCtrl = TextEditingController();
  final repsCtrl = TextEditingController();
  final timeCtrl = TextEditingController();
  final restCtrl = TextEditingController();

  var workouts = <GetWorkout>[].obs;
  var selectedWorkoutId = RxnString();
  int existingOrder = 1;
  String? exerciseId;

  var isLoading = false.obs;

  @override
  void onClose() {
    nameCtrl.dispose();
    descCtrl.dispose();
    setsCtrl.dispose();
    repsCtrl.dispose();
    timeCtrl.dispose();
    restCtrl.dispose();
    super.onClose();
  }

  Future<void> init(String id) async {
    exerciseId = id;
    isLoading(true);
    try {
      // fetch workouts
      final wlist = await ExerciseService.fetchWorkouts();
      workouts.assignAll(wlist);

      // fetch exercise
      final res = await service.getExerciseById(id);
      if (res.isSuccess && res.responseData != null) {
        final data =
            res.responseData!['data'] as Map<String, dynamic>? ??
            res.responseData! as Map<String, dynamic>?;
        if (data != null) {
          final ex = Exercise.fromJson(data);
          nameCtrl.text = ex.name;
          descCtrl.text = ex.description;
          setsCtrl.text = ex.sets.toString();
          repsCtrl.text = ex.reps;
          timeCtrl.text = ex.time.toString();
          restCtrl.text = ex.rest.toString();
          existingOrder = ex.order;
          selectedWorkoutId.value = ex.workoutId;
        }
      } else {
        Get.snackbar('Error', 'Failed to load exercise');
      }
    } catch (e) {
      print('Init edit exercise error: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateExercise() async {
    if (exerciseId == null) return;
    isLoading(true);
    try {
      final body = {
        'name': nameCtrl.text.trim(),
        'description': descCtrl.text.trim(),
        'sets': int.tryParse(setsCtrl.text.trim()) ?? 0,
        'reps': repsCtrl.text.trim(),
        'time': int.tryParse(timeCtrl.text.trim()) ?? 0,
        'rest': int.tryParse(restCtrl.text.trim()) ?? 0,
        'order': existingOrder,
        'workoutId': selectedWorkoutId.value,
      };

      final res = await service.updateExercise(id: exerciseId!, data: body);
      if (res.isSuccess) {
        EasyLoading.showInfo('Exercise updated successfully');
        // Try to refresh the exercises list if controller exists (screen opened from list)
        try {
          ExerciseListController exCtrl = Get.find<ExerciseListController>();
          await exCtrl.fetchExercises(page: exCtrl.page.value);
        } catch (e) {
          // list controller not found in this context - ignore
        }
        Get.back();
      } else {
        Get.snackbar('Error', res.errorMessage ?? 'Failed to update');
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
