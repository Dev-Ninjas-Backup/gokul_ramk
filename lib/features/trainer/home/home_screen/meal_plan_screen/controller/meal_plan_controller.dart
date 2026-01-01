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
import 'package:gokul_ramk/features/trainer/home/home_screen/meal_plan_screen/model/meal_plan_model.dart';

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

  // edit mode
  var isEditing = false.obs;
  String? editPlanId;
  String? existingImageUrl;

  /// Populate controller fields from an existing plan (for edit)
  void populateFromPlan(MealPlanModel plan) {
    // set identifiers immediately
    editPlanId = plan.id;
    existingImageUrl = plan.imageUrl;

    // Defer visible state updates to after the current frame to avoid
    // changing observable state while the widget tree is being built.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isEditing.value = true;
      titleCtrl.text = plan.title;
      descCtrl.text = plan.description;
      goalCtrl.text = plan.goal;
      durationCtrl.text = plan.duration;
      intensityCtrl.text = plan.intensityLevel;
      proteinCtrl.text = plan.proteinExample;
      weeklyItems.assignAll(plan.weeklyBreakdown);
      dailyItems.assignAll(plan.dailyExamples);
      // plan.meals contains meal ids; pick first if available
      if (plan.meals.isNotEmpty) selectedMealId.value = plan.meals.first;
      // clear any picked image since we're editing an existing plan
      pickedImagePath.value = '';
    });
  }

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

      NetworkResponse res;

      if (editPlanId != null) {
        // Edit existing plan
        if (imageFile != null) {
          res = await service.editPlanWithImage(
            id: editPlanId!,
            data: body,
            imageFile: imageFile,
          );
        } else {
          // send patch without uploading a new image; backend expects "image" key maybe empty
          res = await service.editMealPlan(
            id: editPlanId!,
            data: body,
            imageUrl: existingImageUrl ?? '',
          );
        }
      } else {
        // Create new plan
        res = await service.createPlanWithImage(
          data: body,
          imageFile: imageFile,
        );
      }

      if (res.isSuccess) {
        EasyLoading.showInfo(
          editPlanId != null
              ? "Success Meal Plan Updated"
              : "Success Meal Plan Created",
        );
        clearAll();
        // after edit/creation, go back to list
        Get.back();
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
    // reset edit state
    editPlanId = null;
    isEditing.value = false;
    existingImageUrl = null;
  }
}
