import 'package:get/get.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/plan_detail/model/nutrition_plan_model.dart';

class NutritionPlanController extends GetxController {
  final plan = NutritionPlanModel(
    title: "Lean Muscle Gain – 4 Weeks",
    duration: "4 Weeks",
    difficulty: "Intermediate",
    description:
        "A structured nutrition plan designed to maximize muscle growth while keeping fat gain minimal. Perfect balance of protein, carbs, and recovery meals.",
    weeklyBreakdown: [
      "Week 1 - Foundation: higher protein meals, focus on calorie surplus.",
      "Week 2 - Strength fueling: carb cycling added.",
      "Week 3 - Progressive overload support: calorie bump + nutrient timing.",
      "Week 4 - Peak growth: recovery optimization with balanced macros.",
    ],
    dailyMeals: [
      "Breakfast: Protein Pancakes with Peanut Butter & Berries",
      "Lunch: Grilled Chicken Wrap + Brown Rice",
      "Snack: Greek Yogurt + Mixed Nuts",
      "Dinner: Salmon & Quinoa Bowl with Steamed Veggies",
      "Post-Workout: Whey Protein Shake + Banana",
    ],
  ).obs;
}
