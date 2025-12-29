// exercise_service.dart
// Service to fetch workouts and create exercises
// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import '../model/get_workout_model.dart';

class ExerciseService {
  final NetworkClient client;

  ExerciseService(this.client);

  /// Fetch workouts
  static Future<List<GetWorkout>> fetchWorkouts() async {
    try {
      final client = Get.find<NetworkClient>();
      final res = await client.getRequest(url: Urls.getWorkout);

      if (res.isSuccess && res.responseData != null) {
        final data = res.responseData!['data'];
        if (data != null) {
          // response might be: { data: { workouts: [ ... ] } }
          final workoutsList = data['workouts'] as List? ?? data as List?;
          if (workoutsList != null) {
            return workoutsList.map((e) => GetWorkout.fromJson(e)).toList();
          }
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load workouts");
      print("Fetch workouts error: $e");
    }

    return [];
  }

  /// Create exercise
  Future<NetworkResponse> createExercise({
    required Map<String, dynamic> data,
  }) async {
    return await client.postRequest(url: Urls.exercise, body: data);
  }

  /// Fetch paginated exercises (default page=1, limit=10)
  static Future<List> fetchExercises({int page = 1, int limit = 10}) async {
    try {
      final client = Get.find<NetworkClient>();
      final url = '${Urls.exercise}?page=$page&limit=$limit';
      final res = await client.getRequest(url: url);

      if (res.isSuccess && res.responseData != null) {
        // res.responseData['data'] expected to be a List
        final data = res.responseData!['data'];
        if (data is List) return data;
        // Some endpoints may wrap differently
        return res.responseData!['data'] as List? ?? [];
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load exercises');
      print('Fetch exercises error: $e');
    }

    return [];
  }

  /// Get single exercise by id
  Future<NetworkResponse> getExerciseById(String id) async {
    final url = '${Urls.exercise}/$id';
    return await client.getRequest(url: url);
  }

  /// Update exercise by id
  Future<NetworkResponse> updateExercise({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    final url = '${Urls.exercise}/$id';
    return await client.putRequest(url: url, body: data);
  }

  /// Delete exercise by id
  static Future<NetworkResponse> deleteExerciseById(String id) async {
    try {
      final client = Get.find<NetworkClient>();
      final url = '${Urls.exercise}/$id';
      return await client.deleteRequest(url);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete exercise');
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
        statusCode: -1,
      );
    }
  }
}
