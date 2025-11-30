import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/meal_detail/model/meal_detail_model.dart';

class MealDetailRepository {
  final NetworkClient networkClient = Get.find<NetworkClient>();

  Future<MealDetailModel> fetchMealDetail(String mealId) async {
    try {
      final url = '${Urls.getMeal}/$mealId';
      final response = await networkClient.getRequest(url: url);

      if (response.isSuccess && response.responseData != null) {
        // Handle response with 'data' key
        dynamic mealData = response.responseData;

        if (mealData is Map<String, dynamic> && mealData.containsKey('data')) {
          mealData = mealData['data'];
        }

        return MealDetailModel.fromJson(mealData as Map<String, dynamic>);
      } else {
        throw Exception(
          response.errorMessage ?? 'Failed to fetch meal details',
        );
      }
    } catch (e) {
      throw Exception('Error fetching meal details: $e');
    }
  }

  Future<List<MealDetailModel>> fetchSimilarMeals({
    int limit = 10,
    int page = 1,
  }) async {
    try {
      final url = '${Urls.getMeal}?limit=$limit&page=$page';
      final response = await networkClient.getRequest(url: url);

      if (response.isSuccess && response.responseData != null) {
        List<dynamic> mealsData = [];

        if (response.responseData is Map) {
          final Map<String, dynamic> responseMap =
              response.responseData as Map<String, dynamic>;
          if (responseMap.containsKey('data')) {
            mealsData = responseMap['data'] ?? [];
          }
        } else if (response.responseData is List) {
          mealsData = response.responseData as List<dynamic>;
        }

        List<MealDetailModel> meals = mealsData
            .map((meal) => MealDetailModel.fromJson(meal))
            .toList();
        return meals;
      } else {
        throw Exception(response.errorMessage ?? 'Failed to fetch meals');
      }
    } catch (e) {
      throw Exception('Error fetching meals: $e');
    }
  }

  Future<bool> createMealPlan({
    required String title,
    required String description,
    required String goal,
    required String duration,
    required String intensityLevel,
    required String proteinExample,
    required List<String> weeklyBreakdown,
    required List<String> dailyExamples,
    required List<String> mealIds,
    required String image,
  }) async {
    try {
      final body = {
        'title': title,
        'description': description,
        'goal': goal,
        'duration': duration,
        'intensityLevel': intensityLevel,
        'proteinExample': proteinExample,
        'weeklyBreakdown': weeklyBreakdown,
        'dailyExamples': dailyExamples,
        'meals': mealIds,
        'image': image,
      };

      final response = await networkClient.postRequest(
        url: Urls.createMealPlan,
        body: body,
      );

      if (response.isSuccess) {
        return true;
      } else {
        throw Exception(response.errorMessage ?? 'Failed to create meal plan');
      }
    } catch (e) {
      throw Exception('Error creating meal plan: $e');
    }
  }
}
