import 'package:get/get.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/meal_detail/model/meal_detail_model.dart';

class MealDetailController extends GetxController {
  var meal = MealDetailModel(
    title: "Grilled Salmon Bowl",
    image: "https://www.alaskaseafood.org/wp-content/uploads/Char-Grilled-Salmon-Satay-Peanut-Tamarind-Rice-Bowl-5-Web-JPG-940x550.jpg",
    tags: ["High Protein", "Low Carb", "Omega-3 Rich"],
    calories: 520,
    protein: 38,
    carbs: 28,
    fats: 22,
    vitamins: "Vit A, Vit C, Omega-3",
    ingredients: [
      "150g Grilled Salmon 🐟",
      "1 cup Cooked Quinoa 🎊",
      "½ Avocado 🥑",
      "Steamed Broccoli 🥦",
      "Olive Oil (1 tbsp) 🫒",
      "Lemon Juice 🍋",
      "Salt & Pepper 🧂",
    ],
    steps: [
      "Grill salmon with olive oil, salt, and pepper.",
      "Cook quinoa and let it cool slightly.",
      "Slice avocado and prepare steamed broccoli.",
      "Assemble quinoa base, add salmon and veggies.",
      "Drizzle lemon juice before serving.",
    ],
  ).obs;

  var similarMeals = [
    {
      "title": "Chicken Power Bowl",
      "image": "https://www.alaskaseafood.org/wp-content/uploads/Char-Grilled-Salmon-Satay-Peanut-Tamarind-Rice-Bowl-5-Web-JPG-940x550.jpg",
      "desc": "Grilled chicken, sweet potato, spinach, tahini dressing.",
    },
    {
      "title": "Vegan Lentil Bowl",
      "image": "https://www.alaskaseafood.org/wp-content/uploads/Char-Grilled-Salmon-Satay-Peanut-Tamarind-Rice-Bowl-5-Web-JPG-940x550.jpg",
      "desc": "Lentils, roasted chickpeas, quinoa, tahini-lemon sauce.",
    },
  ].obs;
}
