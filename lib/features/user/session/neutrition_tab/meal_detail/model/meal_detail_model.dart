class MealDetailModel {
  final String title;
  final String image;
  final List<String> tags;
  final int calories;
  final int protein;
  final int carbs;
  final int fats;
  final String vitamins;
  final List<String> ingredients;
  final List<String> steps;

  MealDetailModel({
    required this.title,
    required this.image,
    required this.tags,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.vitamins,
    required this.ingredients,
    required this.steps,
  });
}