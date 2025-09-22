import 'package:get/get.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/model/comunity_food_model.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/model/nutition_model.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/model/nutrition_goal_food_model.dart';
import 'package:gokul_ramk/features/user/session/trainers_tab/model/trainer_tab_model.dart';

class SessionController extends GetxController {
  var selectedCategory = "Sessions".obs;

  final categories = ["Sessions", "Trainers", "Nutrition"];

  List communityFoodList = <ComunityFoodModel>[
    ComunityFoodModel(
      title: '🥤 7-Day Smoothie Challenge',
      buttonText: 'Join Challenge',
      image:
          'https://vjcooks.com/wp-content/uploads/2025/05/VJcooks_GrilledHoneySoySalmonBowls_2-1749x2048.jpg',
    ),
    ComunityFoodModel(
      title: '🍲 Meal Prep Mastery',
      buttonText: 'Share Your Meal',
      image:
          'https://www.feastingathome.com/wp-content/uploads/2017/06/Grilled-Salmon-Tzatziki-Bowl-109.jpg',
    ),
  ];
  List neutritionGoalCollection = <NutritionGoalFoodModel>[
    NutritionGoalFoodModel(
      title: '🔥 Slim & Fit',
      subTitle: 'Balanced, low-calorie meals designed to help you burn fat.',
      imageUrl:
          'https://www.alaskaseafood.org/wp-content/uploads/Char-Grilled-Salmon-Satay-Peanut-Tamarind-Rice-Bowl-5-Web-JPG-940x550.jpg',
      buttonText: 'Explore Plan',
    ),
    NutritionGoalFoodModel(
      title: '🔥 Slim & Fit',
      subTitle: 'Balanced, low-calorie meals designed to help you burn fat.',
      imageUrl:
          'https://www.alaskaseafood.org/wp-content/uploads/Char-Grilled-Salmon-Satay-Peanut-Tamarind-Rice-Bowl-5-Web-JPG-940x550.jpg',
      buttonText: 'Cook Fast',
    ),
    NutritionGoalFoodModel(
      title: '🔥 Slim & Fit',
      subTitle: 'Balanced, low-calorie meals designed to help you burn fat.',
      imageUrl:
          'https://www.alaskaseafood.org/wp-content/uploads/Char-Grilled-Salmon-Satay-Peanut-Tamarind-Rice-Bowl-5-Web-JPG-940x550.jpg',
      buttonText: 'Explore Plan',
    ),
    NutritionGoalFoodModel(
      title: '🔥 Slim & Fit',
      subTitle: 'Balanced, low-calorie meals designed to help you burn fat.',
      imageUrl:
          'https://www.alaskaseafood.org/wp-content/uploads/Char-Grilled-Salmon-Satay-Peanut-Tamarind-Rice-Bowl-5-Web-JPG-940x550.jpg',
      buttonText: 'Go Green',
    ),
  ];
  List topMealNutrition = <TopMealNutritionModel>[
    TopMealNutritionModel(
      name: 'Grilled Salmon Bowl',
      image:
          'https://thebigmansworld.com/wp-content/uploads/2024/01/salmon-bowl-1-800x533.jpg',
    ),
    TopMealNutritionModel(
      name: 'Quinoa & Avocado Salad',
      image:
          'https://thebigmansworld.com/wp-content/uploads/2024/01/salmon-bowl-1-800x533.jpg',
    ),
    TopMealNutritionModel(
      name: 'Chicken & Brown Rice Meal',
      image:
          'https://thebigmansworld.com/wp-content/uploads/2024/01/salmon-bowl-1-800x533.jpg',
    ),
    TopMealNutritionModel(
      name: 'Grilled Salmon Bowl',
      image:
          'https://thebigmansworld.com/wp-content/uploads/2024/01/salmon-bowl-1-800x533.jpg',
    ),
  ];

  List topTrainers = <TrainerTabModel>[
    TrainerTabModel(
      name: "Sophia",
      role: "Strength Coach",
      image: "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
      specialty: "Strength & Conditioning",
      rating: 4.8,
      reviews: 200,
    ),
    TrainerTabModel(
      name: "Liam",
      role: "Yoga Specialist",
      image: "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
      specialty: "Yoga",
      rating: 4.7,
      reviews: 180,
    ),
    TrainerTabModel(
      name: "Ava",
      role: "Nutrition & Recovery",
      image: "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
      specialty: "Nutrition",
      rating: 4.9,
      reviews: 150,
    ),
  ].obs;

  List strengthTrainers = <TrainerTabModel>[
    TrainerTabModel(
      name: "Alex Carter",
      role: "Strength & Conditioning",
      image:
          "https://venketfitness.com/assets/VEN06242-min-2048x1365-CZSgI9qf.jpg",
      specialty: "Strength & Conditioning",
      rating: 4.9,
      reviews: 320,
    ),
    TrainerTabModel(
      name: "Ava Thompson",
      role: "Strength & Conditioning",
      image:
          "https://venketfitness.com/assets/VEN06242-min-2048x1365-CZSgI9qf.jpg",
      specialty: "Strength & Conditioning",
      rating: 4.8,
      reviews: 210,
    ),
  ].obs;

  final List<Map<String, dynamic>> workoutList = [
    {
      "title": "Full Body Stretching",
      "subtitle": "10 minutes | Intermediate",
      "image":
          "https://images.pexels.com/photos/3823039/pexels-photo-3823039.jpeg",
      "isBookmarked": true,
      "isOnlineSession": true,
    },
    {
      "title": "Yoga",
      "subtitle": "15 minutes | Basic",
      "image":
          "https://images.pexels.com/photos/3823037/pexels-photo-3823037.jpeg",
      "isBookmarked": false,
      "isOnlineSession": true,
    },
    {
      "title": "Full Body Stretching",
      "subtitle": "10 minutes | Intermediate",
      "image":
          "https://images.pexels.com/photos/3823039/pexels-photo-3823039.jpeg",
      "isBookmarked": true,
      "isOnlineSession": false,
    },
    {
      "title": "Yoga",
      "subtitle": "15 minutes | Basic",
      "image":
          "https://images.pexels.com/photos/3823037/pexels-photo-3823037.jpeg",
      "isBookmarked": false,
      "isOnlineSession": true,
    },
    {
      "title": "Full Body Stretching",
      "subtitle": "10 minutes | Intermediate",
      "image":
          "https://images.pexels.com/photos/3823039/pexels-photo-3823039.jpeg",
      "isBookmarked": true,
      "isOnlineSession": false,
    },
    {
      "title": "Yoga",
      "subtitle": "15 minutes | Basic",
      "image":
          "https://images.pexels.com/photos/3823037/pexels-photo-3823037.jpeg",
      "isBookmarked": false,
      "isOnlineSession": true,
    },
  ];
}
