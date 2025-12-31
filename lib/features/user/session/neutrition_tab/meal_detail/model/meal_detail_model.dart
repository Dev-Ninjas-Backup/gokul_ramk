class MealDetailModel {
  final String id;
  final String title;
  final String description;
  final String image;
  final int calories;
  final int protein;
  final int carbs;
  final int fats;
  final List<String> vitamins;
  final List<String> ingredients;
  final List<String> preparation;
  final String createdAt;
  final String updatedAt;

  MealDetailModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.vitamins,
    required this.ingredients,
    required this.preparation,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MealDetailModel.fromJson(Map<String, dynamic> json) {
    return MealDetailModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      calories: json['calories'] ?? 0,
      protein: json['protein'] ?? 0,
      carbs: json['carbs'] ?? 0,
      fats: json['fat'] ?? 0,
      vitamins: List<String>.from(json['vitamins'] ?? []),
      ingredients: List<String>.from(json['ingredients'] ?? []),
      preparation: List<String>.from(json['preparation'] ?? []),
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fats': fats,
      'vitamins': vitamins,
      'ingredients': ingredients,
      'preparation': preparation,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
