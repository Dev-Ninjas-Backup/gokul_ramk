// models/meal_plan_model.dart

class MealPlanModel {
  final String id;
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
    required this.id,
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

  factory MealPlanModel.fromJson(Map<String, dynamic> json) {
    return MealPlanModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      goal: json['goal'] ?? '',
      duration: json['duration']?.toString() ?? '',
      intensityLevel: json['intensityLevel'] ?? '',
      proteinExample: json['proteinExample'] ?? '',
      weeklyBreakdown:
          (json['weeklyBreakdown'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      dailyExamples:
          (json['dailyExamples'] as List?)?.map((e) => e.toString()).toList() ??
          [],
      meals:
          (json['meals'] as List?)
              ?.map((e) => e['id']?.toString() ?? '')
              .toList() ??
          [],
      imageUrl: json['image'] ?? json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "goal": goal,
      "duration": duration,
      "intensityLevel": intensityLevel,
      "proteinExample": proteinExample,
      "weeklyBreakdown": weeklyBreakdown,
      "dailyExamples": dailyExamples,
      "meals": meals,
      "image": imageUrl,
    };
  }
}
