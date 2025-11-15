// controller/program_controller.dart
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../model/program_model.dart';

class ProgramController extends GetxController {
  var currentProgram = Rxn<WorkoutProgram>();
  var selectedDay = 0.obs;

  final ImagePicker _picker = ImagePicker();
  var selectedImage = Rxn<File>();

  Future<void> thumbnailPickFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  // Clear the selected image
  void clearImage() {
    selectedImage.value = null;
  }

  void createProgram({
    required String name,
    required String duration,
    required String category,
    required String description,
    String? thumbnail,
  }) {
    currentProgram.value = WorkoutProgram(
      name: name,
      duration: duration,
      category: category,
      description: description,
      thumbnail: thumbnail,
      sessions: [],
    );
  }

  void addSession(WorkoutSession session) {
    if (currentProgram.value != null) {
      final updatedSessions = [...currentProgram.value!.sessions, session];
      currentProgram.value = currentProgram.value!.copyWith(
        sessions: updatedSessions,
      );
    }
  }

  void changeDay(int day) {
    selectedDay.value = day;
  }
}
