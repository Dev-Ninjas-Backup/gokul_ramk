class NutritionPlanModel {
  final String id;
  final String title;
  final String description;
  final String goal;
  final String duration;
  final String intensityLevel;
  final String proteinExample;
  final List<String> weeklyBreakdown;
  final List<String> dailyExamples;
  final String image;
  final String createdAt;
  final String updatedAt;
  final String createdById;

  NutritionPlanModel({
    required this.id,
    required this.title,
    required this.description,
    required this.goal,
    required this.duration,
    required this.intensityLevel,
    required this.proteinExample,
    required this.weeklyBreakdown,
    required this.dailyExamples,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.createdById,
  });

  factory NutritionPlanModel.fromJson(Map<String, dynamic> json) {
    return NutritionPlanModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      goal: json['goal'] ?? '',
      duration: json['duration'] ?? '',
      intensityLevel: json['intensityLevel'] ?? '',
      proteinExample: json['proteinExample'] ?? '',
      weeklyBreakdown: List<String>.from(json['weeklyBreakdown'] ?? []),
      dailyExamples: List<String>.from(json['dailyExamples'] ?? []),
      image: json['image'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      createdById: json['createdById'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'goal': goal,
      'duration': duration,
      'intensityLevel': intensityLevel,
      'proteinExample': proteinExample,
      'weeklyBreakdown': weeklyBreakdown,
      'dailyExamples': dailyExamples,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'createdById': createdById,
    };
  }
}
