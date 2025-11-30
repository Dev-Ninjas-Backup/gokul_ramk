// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/plan_detail/model/nutrition_plan_model.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/plan_detail/repository/nutrition_plan_repository.dart';

class NutritionPlanController extends GetxController {
  late final NutritionPlanRepository repository;

  var plan = Rx<NutritionPlanModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    repository = NutritionPlanRepository();
    final planId = Get.arguments;
    if (planId != null) {
      fetchPlanDetail(planId);
    }
  }

  Future<void> fetchPlanDetail(String planId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final planData = await repository.fetchPlanDetail(planId);
      plan.value = planData;
    } catch (e) {
      errorMessage.value = e.toString();
      print('Error fetching plan detail: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
