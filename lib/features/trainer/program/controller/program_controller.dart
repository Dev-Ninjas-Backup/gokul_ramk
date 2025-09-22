// controller/program_controller.dart
import 'package:get/get.dart';
import '../model/program_model.dart';

class ProgramController extends GetxController {
  var currentProgram = Rxn<WorkoutProgram>();
  var selectedDay = 0.obs;

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
