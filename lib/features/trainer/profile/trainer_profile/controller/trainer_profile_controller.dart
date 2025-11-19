// trainer_profile_controller.dart
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/model/product_model.dart';
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
  var products = <Product>[
    Product(
      name: "Whey Protein - Chocolate 1kg",
      price: 45,
      unitsSold: 0,
      earnings: 0,
      image: Imagepath.proteinBottle,
      status: "Pending Review",
    ),
    Product(
      name: "Premium Grip Training Gloves",
      price: 25,
      unitsSold: 32,
      earnings: 640,
      image: Imagepath.gloves,
      status: "Approved (Live in Store)",
    ),
  ].obs;

  var totalRevenue = 5700.0.obs;
  var totalProductsSold = 120.obs;

  var balance = 15590.0.obs;


//for api
Rx<Trainer?> trainerProfileData = Rx<Trainer?>(null);

@override
void onInit() {
  super.onInit();
  fetchTrainerProfile();
}

void fetchTrainerProfile() async {
  try {
    var data = await trainerService.getProfile();
    trainerProfileData.value = data; 
  } catch (e) {
    if (kDebugMode) {
      print("Error fetching trainer profile: $e");
    }
  }
}


}
