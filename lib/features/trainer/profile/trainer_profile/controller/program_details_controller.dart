import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/model/program_model.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/service/trainer_profile_service.dart';

class ProgramDetailsController extends GetxController {
  final TrainerService trainerService = TrainerService();

  var programDetails = Rxn<ProgramModel>();
  var isLoading = false.obs;
  var error = Rxn<String>();

  Future<void> fetchProgramDetails(String programId) async {
    try {
      isLoading.value = true;
      error.value = null;

      final program = await trainerService.getProgramDetails(programId);

      if (program != null) {
        programDetails.value = program;
      } else {
        error.value = "Failed to load program details";
      }
    } catch (e) {
      if (kDebugMode) print("Error fetching program details: $e");
      error.value = "Error: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }
}
