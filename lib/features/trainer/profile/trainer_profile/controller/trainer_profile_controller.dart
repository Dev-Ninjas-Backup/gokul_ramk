// trainer_profile_controller.dart
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/trainer/profile/my_products/model/product_model.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/model/trainer_model.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/model/program_model.dart';

import '../service/trainer_profile_service.dart';

class TrainerProfileController extends GetxController {
  TrainerService trainerService = TrainerService();
  // Basic Info

  // Programs Offered - Using API response
  var programs = <ProgramModel>[].obs;

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
    fetchPrograms();
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

  void fetchPrograms() async {
    try {
      final myPrograms = await trainerService.getMyPrograms();
      programs.value = myPrograms;
      if (kDebugMode) print("Programs fetched: ${programs.length}");
    } catch (e) {
      if (kDebugMode) print("Error fetching programs: $e");
    }
  }
}
