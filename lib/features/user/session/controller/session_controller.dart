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
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/user/session/trainers_tab/model/top_trainer_model.dart';

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

  // Removed static/demo lists. These will be populated from repositories or services.
  List<ComunityFoodModel> communityFoodList = <ComunityFoodModel>[];
  List<NutritionGoalFoodModel> neutritionGoalCollection =
      <NutritionGoalFoodModel>[];
  List<TopMealNutritionModel> topMealNutrition = <TopMealNutritionModel>[];

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

  // List strengthTrainers = <TrainerTabModel>[
  //   TrainerTabModel(
  //     name: "Alex Carter",
  //     role: "Strength & Conditioning",
  //     image:
  //         "https://venketfitness.com/assets/VEN06242-min-2048x1365-CZSgI9qf.jpg",
  //     specialty: "Strength & Conditioning",
  //     rating: 4.9,
  //     reviews: 320,
  //   ),
  //   TrainerTabModel(
  //     name: "Ava Thompson",
  //     role: "Strength & Conditioning",
  //     image:
  //         "https://venketfitness.com/assets/VEN06242-min-2048x1365-CZSgI9qf.jpg",
  //     specialty: "Strength & Conditioning",
  //     rating: 4.8,
  //     reviews: 210,
  //   ),
  // ].obs;

  // Reactive list populated from sessions API. Each item maps to the fields used by SessionsWidget.
  var workoutList = <Map<String, dynamic>>[].obs;

  /// Fetch sessions from the server and map into `workoutList` entries.
  Future<void> fetchSessions({int page = 1, int limit = 20}) async {
    try {
      isLoading(true);
      final url = '${Urls.createSession}?page=$page&limit=$limit';
      final response = await service.client.getRequest(url: url);
      if (response.isSuccess && response.responseData != null) {
        final dataObj = response.responseData!['data'];
        List items = [];
        if (dataObj is Map && dataObj['data'] is List) {
          items = dataObj['data'];
        } else if (dataObj is List) {
          items = dataObj;
        }

        final mapped = items.map<Map<String, dynamic>>((s) {
          final trainer = s['trainer'] as Map<String, dynamic>?;
          final imageUrl =
              (trainer != null &&
                  trainer['images'] != null &&
                  trainer['images'].toString().isNotEmpty)
              ? trainer['images'].toString()
              : Imagepath.trainer;
          return {
            'title': s['title'] ?? '',
            'subtitle': s['description'] ?? '',
            'image': imageUrl,
            'id': s['id']?.toString() ?? '',
            'isBookmarked': false,
            'isOnlineSession':
                (s['sessionType']?.toString().toLowerCase() == 'online'),
            'raw': s,
          };
        }).toList();

        workoutList.assignAll(mapped);
      }
    } catch (e) {
      if (kDebugMode) print('fetchSessions error: $e');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    mealRepository = MealRepository();
    mealPlanRepository = MealPlanRepository();
    fetchMeals();
    fetchMealPlans();
    // fetch sessions to populate the sessions tab
    fetchSessions();
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
