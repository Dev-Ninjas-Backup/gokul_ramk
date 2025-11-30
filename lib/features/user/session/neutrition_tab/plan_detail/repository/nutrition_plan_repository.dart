import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/plan_detail/model/nutrition_plan_model.dart';

class NutritionPlanRepository {
  final NetworkClient networkClient = Get.find<NetworkClient>();

  Future<NutritionPlanModel> fetchPlanDetail(String planId) async {
    try {
      final url = '${Urls.getMealPlan}/$planId';
      final response = await networkClient.getRequest(url: url);

      if (response.isSuccess && response.responseData != null) {
        // Handle response with 'data' key
        dynamic planData = response.responseData;

        if (planData is Map<String, dynamic> && planData.containsKey('data')) {
          planData = planData['data'];
        }

        return NutritionPlanModel.fromJson(planData as Map<String, dynamic>);
      } else {
        throw Exception(
          response.errorMessage ?? 'Failed to fetch plan details',
        );
      }
    } catch (e) {
      throw Exception('Error fetching plan details: $e');
    }
  }
}
