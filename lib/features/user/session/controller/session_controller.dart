// ignore_for_file: avoid_print


import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/model/comunity_food_model.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/model/meal_model.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/model/meal_plan_model.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/model/nutition_model.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/model/nutrition_goal_food_model.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/repository/meal_plan_repository.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/repository/meal_repository.dart';

import 'package:gokul_ramk/features/user/session/service/discover_service.dart';
import 'package:gokul_ramk/features/user/session/trainers_tab/model/top_trainer_model.dart';
import 'package:gokul_ramk/features/user/session/trainers_tab/model/trainer_tab_model.dart';

class SessionController extends GetxController {
  final DiscoverService service = DiscoverService(
    client: NetworkClient(
      onUnAuthorize: () {
        if (kDebugMode) {
          print("unauthorized");
        }
      },
    ),
  );

  var selectedCategory = "Sessions".obs;

  final categories = ["Sessions", "Trainers", "Nutrition"];

  // Meal repository
  late final MealRepository mealRepository;

  // Observable list for fetched meals
  var meals = <MealModel>[].obs;
  var isLoadingMeals = false.obs;
  var mealError = ''.obs;

  // Meal Plan repository
  late final MealPlanRepository mealPlanRepository;

  // Observable list for fetched meal plans
  var mealPlans = <MealPlanModel>[].obs;
  var isLoadingMealPlans = false.obs;
  var mealPlanError = ''.obs;

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

  var topTrainers = <TopTrainer>[].obs;
  var isLoading = false.obs;

  void fetchTrainerMethod() async {
    isLoading(true);
    try {
      final trainerList = await service.fetchTopTrainer();
      topTrainers.assignAll(trainerList);

      print("================hhhhh ${trainerList.length}");
      print("================hhhhhh ${trainerList[0].fullname}");
      print("================hhhhh ${topTrainers[1].images}");
    } catch (e) {
      debugPrint("Error fetching trziners: $e");
    } finally {
      isLoading(false);
    }
  }

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

  @override
  void onInit() {
    super.onInit();
    mealRepository = MealRepository();
    mealPlanRepository = MealPlanRepository();
    fetchMeals();
    fetchMealPlans();
  }

  Future<void> fetchMeals({int limit = 10, int page = 1}) async {
    try {
      isLoadingMeals.value = true;
      mealError.value = '';
      meals.value = await mealRepository.fetchMeals(limit: limit, page: page);
    } catch (e) {
      mealError.value = e.toString();
      print('Error fetching meals: $e');
    } finally {
      isLoadingMeals.value = false;
    }
  }

  Future<void> fetchMealPlans({int limit = 10, int page = 1}) async {
    try {
      isLoadingMealPlans.value = true;
      mealPlanError.value = '';
      mealPlans.value = await mealPlanRepository.fetchMealPlans(
        limit: limit,
        page: page,
      );
    } catch (e) {
      mealPlanError.value = e.toString();
      print('Error fetching meal plans: $e');
    } finally {
      isLoadingMealPlans.value = false;
    }
    fetchTrainerMethod();

    super.onInit();
  }
}
