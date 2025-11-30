import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/model/meal_model.dart';

class MealRepository {
  final NetworkClient networkClient = Get.find<NetworkClient>();

  Future<List<MealModel>> fetchMeals({int limit = 10, int page = 1}) async {
    try {
      final url = '${Urls.getMeal}?limit=$limit&page=$page';
      final response = await networkClient.getRequest(url: url);

      if (response.isSuccess && response.responseData != null) {
        // Handle paginated response
        List<dynamic> mealsData = [];

        // Check if response has 'data' key (pagination)
        if (response.responseData is Map) {
          final Map<String, dynamic> responseMap =
              response.responseData as Map<String, dynamic>;
          if (responseMap.containsKey('data')) {
            mealsData = responseMap['data'] ?? [];
          }
        }
        // Check if response is a direct list
        else if (response.responseData is List) {
          mealsData = response.responseData as List<dynamic>;
        }

        List<MealModel> meals = mealsData
            .map((meal) => MealModel.fromJson(meal))
            .toList();
        return meals;
      } else {
        throw Exception(response.errorMessage ?? 'Failed to fetch meals');
      }
    } catch (e) {
      throw Exception('Error fetching meals: $e');
    }
  }

  Future<MealModel> fetchMealById(String id) async {
    try {
      final url = '${Urls.getMeal}/$id';
      final response = await networkClient.getRequest(url: url);

      if (response.isSuccess && response.responseData != null) {
        return MealModel.fromJson(
          response.responseData as Map<String, dynamic>,
        );
      } else {
        throw Exception(response.errorMessage ?? 'Failed to fetch meal');
      }
    } catch (e) {
      throw Exception('Error fetching meal: $e');
    }
  }
}
