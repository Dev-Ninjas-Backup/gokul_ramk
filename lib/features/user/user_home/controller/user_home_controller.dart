// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/user/user_home/model/feature_workout_model.dart';
import 'package:gokul_ramk/features/user/user_home/model/trainer_model.dart';
import 'package:gokul_ramk/features/user/user_home/model/user_home_model.dart';
import 'package:gokul_ramk/features/user/user_home/model/workout_model.dart';
import 'package:gokul_ramk/features/user/user_home/service/user_home_service.dart';

class UserHomeController extends GetxController {
  RxBool joinedHitProgram = false.obs;
  var progress = 0.65.obs;

  final CategoryService service = CategoryService(
    client: NetworkClient(
      onUnAuthorize: () {
        if (kDebugMode) {
          print("unauthorized");
        }
      },
    ),
  );

  var categories = <CategoryModelWorkOut>[].obs;
  RxString selectedCategory = ''.obs;

  var isLoading = false.obs;

  void fetchCategoriesMethod() async {
    isLoading(true);
    try {
      final categoriesList = await service.fetchCategories();
      categories.assignAll(categoriesList);
      if (categories.isNotEmpty) {
        selectedCategory.value = categories[0].id;
        fetchWorkoutListMethod();
      }
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    } finally {
      isLoading(false);
    }
  }

  var trainers = <FeatureTrainerModel>[].obs;

  void fetchTrainerMethod() async {
    isLoading(true);
    try {
      final trainerList = await service.fetchTrainer();
      trainers.assignAll(trainerList);

      print("================1 ${trainerList.length}");
            print("================1 ${trainerList[0].bio}");
                        print("================2 ${trainers[1].bio}");


    } catch (e) {
      debugPrint("Error fetching trziners: $e");
    } finally {
      isLoading(false);
    }
  }

  var workoutList = <WorkOutModel>[].obs;
  void fetchWorkoutListMethod() async {
    if (selectedCategory.value.isEmpty) return;

    isLoading(true);
    try {
      final list = await service.fetchWorkouts(selectedCategory.value);

      workoutList.assignAll(list);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  var selectedFeaturedWorkout = "ONLINE".obs;

  final filters = ["ONLINE", "IN_PERSON", "ONSITE", "HYBRID"];
  var featureWorkoutList = <Workout>[].obs;
  void fetchFeatureWorkoutMethod() async {
    isLoading(true);
    try {
      final list = await service.fetchFeatureWorkout(
        selectedFeaturedWorkout.value,
      );
      featureWorkoutList.assignAll(list);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    fetchCategoriesMethod();
    fetchWorkoutListMethod();
    fetchFeatureWorkoutMethod();
    fetchTrainerMethod();
    super.onInit();
  }

  final List<Map<String, dynamic>> highlightList = [
    {
      "title": "Full Body Burn 🔥",
      "subtitle": "20 min | Intermediate",
      "buttonText": "Start Now",
      "image":
          "https://images.pexels.com/photos/1552242/pexels-photo-1552242.jpeg",
    },
    {
      "title": "Try this: Quinoa Salad 🥗",
      "subtitle": "For post-workout recovery",
      "buttonText": "Order Now",
      "image":
          "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg",
    },
  ];

  final stats = {
    "Steps": "5,320 / 8,000",
    "Workout Time": "32 min",
    "Calories Burned": "420 kcal",
  };

  final RxInt currentSliderIndex = 0.obs;

  void updateSliderIndex(int index) {
    currentSliderIndex.value = index;
  }

  final List<String> imageUrls = [
    'https://www.mlchc.org/sites/default/files/styles/max_650x650/public/2022-03/nutrition_image2.jpg',
    'https://www.weljii.com/wp-content/uploads/2024/06/apr-1.jpg',
  ];

  RxString duration = "4 weeks".obs;
  RxString type = "Fat Burn".obs;
  RxString description =
      "This 30-day program combines HIIT, strength training, and nutrition guidance to help you burn fat and boost stamina."
          .obs;

  RxList workoutSchedule = [
    "Day 1: Full Body HIIT - 20 min | Burn calories",
    "Day 3: Upper Body Strength - Push & pull focus",
    "Day 5: Core & Flexibility - Improve balance",
  ].obs;
}
