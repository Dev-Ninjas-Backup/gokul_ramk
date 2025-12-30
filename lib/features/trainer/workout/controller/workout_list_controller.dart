// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import '../model/workout_model.dart';

class WorkoutListController extends GetxController {
  var isLoading = false.obs;
  var workoutList = <Workout>[].obs;
  var errorMessage = Rxn<String>();

  @override
  void onInit() {
    super.onInit();
    fetchWorkouts();
  }

  Future<void> fetchWorkouts() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final SharedPreferencesHelperController sharedPreference = Get.put(
        SharedPreferencesHelperController(),
      );
      String? token = await sharedPreference.getAccessToken();

      final response = await GetConnect().get(
        Urls.myWorkouts,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );

      print("Workouts API Response: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = response.body;

        print("Response data type: ${responseBody['data'].runtimeType}");
        print("Response data: ${responseBody['data']}");

        // Parse the data array directly
        if (responseBody['data'] is List) {
          final List<dynamic> workoutsData = responseBody['data'];
          print("Workouts data count: ${workoutsData.length}");

          final List<Workout> fetchedWorkouts = workoutsData.map((json) {
            print("Parsing workout: $json");
            return Workout.fromJson(json as Map<String, dynamic>);
          }).toList();

          workoutList.assignAll(fetchedWorkouts);
          print("Fetched ${workoutList.length} workouts successfully");
          print("Workouts: ${workoutList.map((w) => w.name).toList()}");
        } else {
          print("Data is not a list: ${responseBody['data'].runtimeType}");
          errorMessage.value = "Invalid response format";
        }
      } else {
        errorMessage.value = "Failed to fetch workouts: ${response.statusText}";
        print("Error: ${response.statusText}");
      }
    } catch (e, stackTrace) {
      errorMessage.value = "Error: $e";
      print("Error fetching workouts: $e");
      print("Stack trace: $stackTrace");
    } finally {
      isLoading.value = false;
    }
  }
}
