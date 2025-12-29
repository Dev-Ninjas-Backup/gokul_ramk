import 'package:get/get.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/exercise_screen/model/exercise_model.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/exercise_screen/service/exercise_service.dart';

class ExerciseListController extends GetxController {
  var exercises = <Exercise>[].obs;
  var isLoading = false.obs;
  var page = 1.obs;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    fetchExercises();
  }

  Future<void> fetchExercises({int page = 1}) async {
    isLoading(true);
    try {
      final list = await ExerciseService.fetchExercises(
        page: page,
        limit: limit,
      );
      exercises.assignAll(
        list
            .map((e) => Exercise.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );
      // update controller's page observable
      this.page.value = page;
    } catch (e) {
      print('Fetch exercises error: $e');
    } finally {
      isLoading(false);
    }
  }
}
