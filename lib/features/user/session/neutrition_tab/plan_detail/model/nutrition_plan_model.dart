class NutritionPlanModel {
  final String title;
  final String duration;
  final String difficulty;
  final String description;
  final List<String> weeklyBreakdown;
  final List<String> dailyMeals;

  NutritionPlanModel({
    required this.title,
    required this.duration,
    required this.difficulty,
    required this.description,
    required this.weeklyBreakdown,
    required this.dailyMeals,
  });
}
