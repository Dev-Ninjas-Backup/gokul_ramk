class MealCreateRequest {
  String title;
  String description;
  String image;
  int calories;
  int protein;
  int carbs;
  int fat;
  List<String> vitamins;
  List<String> ingredients;
  List<String> preparation;

  MealCreateRequest({
    required this.title,
    required this.description,
    required this.image,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.vitamins,
    required this.ingredients,
    required this.preparation,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "image": image,
      "calories": calories,
      "protein": protein,
      "carbs": carbs,
      "fat": fat,
      "vitamins": vitamins,
      "ingredients": ingredients,
      "preparation": preparation,
    };
  }
}
