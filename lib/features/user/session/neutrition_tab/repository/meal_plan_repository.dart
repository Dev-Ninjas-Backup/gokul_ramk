import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/model/meal_plan_model.dart';

class MealPlanRepository {
  final NetworkClient networkClient = Get.find<NetworkClient>();

  Future<List<MealPlanModel>> fetchMealPlans({
    int limit = 10,
    int page = 1,
  }) async {
    try {
      final url = '${Urls.getMealPlan}?limit=$limit&page=$page';
      final response = await networkClient.getRequest(url: url);

      if (response.isSuccess && response.responseData != null) {
        // Handle paginated response
        List<dynamic> plansData = [];

        // Check if response has 'data' key (pagination)
        if (response.responseData is Map) {
          final Map<String, dynamic> responseMap =
              response.responseData as Map<String, dynamic>;
          if (responseMap.containsKey('data')) {
            plansData = responseMap['data'] ?? [];
          }
        }
        // Check if response is a direct list
        else if (response.responseData is List) {
          plansData = response.responseData as List<dynamic>;
        }

        List<MealPlanModel> plans = plansData
            .map((plan) => MealPlanModel.fromJson(plan))
            .toList();
        return plans;
      } else {
        throw Exception(response.errorMessage ?? 'Failed to fetch meal plans');
      }
    } catch (e) {
      throw Exception('Error fetching meal plans: $e');
    }
  }

  Future<MealPlanModel> fetchMealPlanById(String id) async {
    try {
      final url = '${Urls.getMealPlan}/$id';
      final response = await networkClient.getRequest(url: url);

      if (response.isSuccess && response.responseData != null) {
        return MealPlanModel.fromJson(
          response.responseData as Map<String, dynamic>,
        );
      } else {
        throw Exception(response.errorMessage ?? 'Failed to fetch meal plan');
      }
    } catch (e) {
      throw Exception('Error fetching meal plan: $e');
    }
  }
}
