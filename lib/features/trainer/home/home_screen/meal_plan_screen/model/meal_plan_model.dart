// models/meal_plan_model.dart
class MealPlanModel {
  final String title;
  final String description;
  final String goal;
  final String duration; // e.g., "4 Weeks"
  final String intensityLevel;
  final String proteinExample;
  final List<String> weeklyBreakdown;
  final List<String> dailyExamples;
  final List<String> meals;
  final String? imageUrl;

  MealPlanModel({
    required this.title,
    required this.description,
    required this.goal,
    required this.duration,
    required this.intensityLevel,
    required this.proteinExample,
    required this.weeklyBreakdown,
    required this.dailyExamples,
    required this.meals,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "goal": goal,
      "duration": duration,
      "intensityLevel": intensityLevel,
      "proteinExample": proteinExample,
      "weeklyBreakdown": weeklyBreakdown,
      "dailyExamples": dailyExamples,
      "meals": meals,
    };
  }
}