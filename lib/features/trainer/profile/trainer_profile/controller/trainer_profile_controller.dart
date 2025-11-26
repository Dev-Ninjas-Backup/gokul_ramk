// trainer_profile_controller.dart
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';
import 'package:gokul_ramk/features/trainer/profile/my_products/model/product_model.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/model/trainer_model.dart';

import '../service/trainer_profile_service.dart';

class Program {
  final String title;
  final String description;
  final String icon;

  Program({required this.title, required this.description, required this.icon});
}

class TrainerProfileController extends GetxController {
  TrainerService trainerService = TrainerService();
  // Basic Info

  // Programs Offered
  var programs = <Program>[
    Program(
      title: "Weight Loss Program",
      description: "Comprehensive fat burning and nutrition plan",
      icon: IconPath.weightLoss,
    ),
    Program(
      title: "Muscle Gain",
      description: "Strength building and muscle development",
      icon: IconPath.musclGain,
    ),
    Program(
      title: "Cardio Routine",
      description: "High-intensity cardiovascular training",
      icon: IconPath.cardio,
    ),
    Program(
      title: "Yoga Sessions",
      description: "Flexibility and mindfulness practice",
      icon: IconPath.yoga,
    ),
  ].obs;

  // ✅ Products
  var products = <Product>[].obs;

  var totalRevenue = 5700.0.obs;
  var totalProductsSold = 120.obs;

  var balance = 15590.0.obs;

  //for api
  var trainerProfileData = Rxn<Trainer>();

  @override
  void onInit() {
    super.onInit();
    fetchTrainerProfile();
    fetchRecentProducts();
  }

  var isLoading = false.obs;

  void fetchTrainerProfile() async {
    try {
      isLoading.value = true;
      var data = await trainerService.getProfile();
      trainerProfileData.value = data;
    } catch (e) {
      if (kDebugMode) print("Error fetching trainer profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void fetchRecentProducts() async {
    try {
      final recentProducts = await trainerService.getRecentProducts(limit: 2);
      products.value = recentProducts;
    } catch (e) {
      if (kDebugMode) print("Error fetching products: $e");
    }
  }
}
