// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:gokul_ramk/features/user/session/controller/session_controller.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/meal_detail/model/meal_detail_model.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/meal_detail/repository/meal_detail_repository.dart';

class MealDetailController extends GetxController {
  late final MealDetailRepository repository;
  late final SessionController sessionController;

  var meal = Rx<MealDetailModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var similarMeals = <MealDetailModel>[].obs;
  var isLoadingSimilarMeals = false.obs;

  var isCreatingMealPlan = false.obs;
  var createMealPlanMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    repository = MealDetailRepository();
    sessionController = Get.find<SessionController>();
    final mealId = Get.arguments;
    if (mealId != null) {
      fetchMealDetail(mealId);
      fetchSimilarMeals();
    }
  }

  Future<void> fetchMealDetail(String mealId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final mealData = await repository.fetchMealDetail(mealId);
      meal.value = mealData;
    } catch (e) {
      errorMessage.value = e.toString();
      print('Error fetching meal detail: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchSimilarMeals() async {
    try {
      isLoadingSimilarMeals.value = true;
      final meals = await repository.fetchSimilarMeals(limit: 6);
      // Filter out the current meal if it exists in the list
      if (meal.value != null) {
        similarMeals.value = meals
            .where((m) => m.id != meal.value!.id)
            .take(4)
            .toList();
      } else {
        similarMeals.value = meals.take(4).toList();
      }
    } catch (e) {
      print('Error fetching similar meals: $e');
    } finally {
      isLoadingSimilarMeals.value = false;
    }
  }

  Future<void> createMealPlan() async {
    try {
      if (meal.value == null) {
        createMealPlanMessage.value = 'No meal selected';
        return;
      }

      isCreatingMealPlan.value = true;
      createMealPlanMessage.value = '';

      final success = await repository.createMealPlan(
        title: '${meal.value!.title} Plan',
        description: meal.value!.description,
        goal: 'Nutritious Meal Plan',
        duration: '1 Week',
        intensityLevel: 'Balanced',
        proteinExample: meal.value!.title,
        weeklyBreakdown: [
          'Day 1 - Start your journey with ${meal.value!.title}',
          'Day 2 - Continue building healthy habits',
          'Day 3 - Mid-week nutrition boost',
          'Day 4 - Peak nutrition week',
          'Day 5 - Recovery and balance',
          'Day 6 - Consistency pays off',
          'Day 7 - Complete your plan',
        ],
        dailyExamples: [
          'Breakfast: ${meal.value!.title}',
          'Lunch: Protein-rich meal',
          'Snack: Healthy alternative',
          'Dinner: Balanced nutrition',
        ],
        mealIds: [meal.value!.id],
        image: meal.value!.image,
      );

      if (success) {
        createMealPlanMessage.value = 'Meal plan created successfully!';

        // Refresh meal plans in nutrition tab
        await sessionController.fetchMealPlans();

        Get.snackbar(
          'Success',
          'Meal plan added to your account',
          duration: Duration(seconds: 2),
        );
      }
    } catch (e) {
      createMealPlanMessage.value = 'Error: ${e.toString()}';
      Get.snackbar(
        'Error',
        'Failed to create meal plan',
        duration: Duration(seconds: 2),
      );
      print('Error creating meal plan: $e');
    } finally {
      isCreatingMealPlan.value = false;
    }
  }
}
