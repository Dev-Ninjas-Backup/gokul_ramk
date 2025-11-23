import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
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
}
