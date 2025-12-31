import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/workout/model/program_model.dart';
import 'package:gokul_ramk/features/user/user_home/model/feature_workout_model.dart';
import 'package:gokul_ramk/features/user/user_home/model/program_model.dart';
import 'package:gokul_ramk/features/user/user_home/model/trainer_model.dart';
import 'package:gokul_ramk/features/user/user_home/model/user_home_model.dart';
import 'package:gokul_ramk/features/user/user_home/model/workout_model.dart';

class CategoryService {
  final NetworkClient client;

  CategoryService({required this.client});

  Future<List<CategoryModelWorkOut>> fetchCategories() async {
    const String url = "${Urls.categories}?type=WORKOUT";

    final response = await client.getRequest(url: url);

    if (response.isSuccess &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      final List data = response.responseData!['data']['data'];

      return data.map((json) => CategoryModelWorkOut.fromJson(json)).toList();
    } else {
      throw response.errorMessage ?? "Failed to load categories";
    }
  }

  Future<List<WorkOutModel>> fetchWorkouts(String categorirsID) async {
    final String url = "${Urls.workOuts}?categoryId=$categorirsID";

    // final String url = "https://wellfitsync.com/workouts?categoryId=58a55959-7f30-438c-9d89-f1b4b997d1b5";

    final response = await client.getRequest(url: url);

    if (response.isSuccess &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      try {
        final List data = response.responseData!['data']['data'];

        return data.map((json) => WorkOutModel.fromJson(json)).toList();
      } catch (e) {
        throw "Failed to parse workouts data: $e";
      }
    } else {
      throw response.errorMessage ?? "Failed to load workouts";
    }
  }

  Future<List<Workout>> fetchFeatureWorkout(String workoutType) async {
    final String url = "${Urls.featureWorkout}?workoutType=$workoutType";
    final response = await client.getRequest(url: url);
    if (response.isSuccess &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      try {
        final List data = response.responseData!['data']['data'];
        return data.map((json) => Workout.fromJson(json)).toList();
      } catch (e) {
        throw "Failed to parse feature workout data: $e";
      }
    } else {
      throw response.errorMessage ?? "Failed to load feature workouts";
    }
  }

  Future<List<FeatureTrainerModel>> fetchTrainer() async {
    const String url = Urls.getTrainer;

    final response = await client.getRequest(url: url);

    if (response.isSuccess &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      final List data = response.responseData!['data']['data'];

      return data.map((json) => FeatureTrainerModel.fromJson(json)).toList();
    } else {
      throw response.errorMessage ?? "Failed to load categories";
    }
  }

Future<FeatureTrainerModel> fetchTrainerDetails(String trainerID) async {
  final String url = "${Urls.baseUrl}/user/$trainerID";

  final response = await client.getRequest(url: url);

  if (response.isSuccess &&
      (response.statusCode == 200 || response.statusCode == 201)) {
      
    final Map<String, dynamic> data = response.responseData!['data'];

    return FeatureTrainerModel.fromJson(data);
  } else {
    throw response.errorMessage ?? "Failed to fetch trainer details";
  }
}
// Future<TopTrainer> fetchTopTrainerDetails(String trainerID) async {
//   final String url = "${Urls.baseUrl}/user/$trainerID";

//   final response = await client.getRequest(url: url);

//   if (response.isSuccess &&
//       (response.statusCode == 200 || response.statusCode == 201)) {
      
//     final Map<String, dynamic> data = response.responseData!['data'];

//     return TopTrainer.fromJson(data);
//   } else {
//     throw response.errorMessage ?? "Failed to fetch trainer details";
//   }
// }





Future<List<Program1>> fetchProgram() async {
  const String url = "${Urls.baseUrl}/programs?limit=5";

  final response = await client.getRequest(url: url);

  if (response.isSuccess &&
      (response.statusCode == 200 || response.statusCode == 201)) {

    final raw = response.responseData;

    final List list =
        raw?['data']?['data'] is List ? raw!['data']['data'] : [];

    return list
        .map((e) => Program1.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  return [];
}





Future<List<Program1>> fetchAllProgram() async {
  const String url = "${Urls.baseUrl}/programs";

  final response = await client.getRequest(url: url);

  if (response.isSuccess &&
      (response.statusCode == 200 || response.statusCode == 201)) {

    final raw = response.responseData;

    final List list =
        raw?['data']?['data'] is List ? raw!['data']['data'] : [];

    return list
        .map((e) => Program1.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  return [];
}


}
