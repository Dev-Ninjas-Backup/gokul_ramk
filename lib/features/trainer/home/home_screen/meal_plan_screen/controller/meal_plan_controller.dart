// create_meal_plan_controller.dart
// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/meal_plan_screen/model/get_meal_model.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/meal_plan_screen/service/meal_plan_service.dart';

class CreateMealPlanController extends GetxController {
  final MealPlanService service = MealPlanService(
    NetworkClient(onUnAuthorize: () => EasyLoading.showInfo("Unauthorized")),
  );

  // text inputs
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  final goalCtrl = TextEditingController();
  final durationCtrl = TextEditingController();
  final intensityCtrl = TextEditingController();
  final proteinCtrl = TextEditingController();

  // weekly / daily
  final weeklyInput = TextEditingController();
  final dailyInput = TextEditingController();
  var weeklyItems = <String>[].obs;
  var dailyItems = <String>[].obs;

  // image picker
  final ImagePicker picker = ImagePicker();
  var pickedImagePath = "".obs;

  Future<void> pickImage() async {
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) pickedImagePath.value = file.path;
  }

  // meal selection
  var meals = <GetMeal>[].obs;
  var selectedMealId = RxnString();

  // loading
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMeals();
  }

  /// Fetch all meals
  Future<void> fetchMeals() async {
    isLoading(true);
    try {
      final list = await MealPlanService.fetchMeals();
      meals.assignAll(list);

      if (meals.isNotEmpty) {
        selectedMealId.value = meals.first.id;
      }
    } catch (e) {
      print("Fetch meal error: $e");
    } finally {
      isLoading(false);
    }
  }

  /// Create meal plan
  Future<void> createPlan() async {
    try {
      isLoading(true);

      final body = {
        "title": titleCtrl.text.trim(),
        "description": descCtrl.text.trim(),
        "goal": goalCtrl.text.trim(),
        "duration": durationCtrl.text.trim(),
        "intensityLevel": intensityCtrl.text.trim(),
        "proteinExample": proteinCtrl.text.trim(),
        "weeklyBreakdown": weeklyItems,
        "dailyExamples": dailyItems,
        "meals": selectedMealId.value,
      };

      File? imageFile = pickedImagePath.value.isNotEmpty
          ? File(pickedImagePath.value)
          : null;

      final res = await service.createPlanWithImage(
        data: body,
        imageFile: imageFile,
      );

      if (res.isSuccess) {
        EasyLoading.showInfo("Success Meal Plan Created");
        clearAll();
      } else {
        Get.snackbar("Error", res.errorMessage ?? "Failed");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// Clear all fields
  void clearAll() {
    titleCtrl.clear();
    descCtrl.clear();
    goalCtrl.clear();
    durationCtrl.clear();
    intensityCtrl.clear();
    proteinCtrl.clear();
    weeklyInput.clear();
    dailyInput.clear();
    weeklyItems.clear();
    dailyItems.clear();
    pickedImagePath.value = "";
    selectedMealId.value = null;
  }
}
