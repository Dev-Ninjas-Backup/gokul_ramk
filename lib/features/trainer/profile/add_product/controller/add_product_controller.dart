import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/trainer/profile/add_product/post_request_service/add_product_request_service.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController {
  var categories = ["Nutrition", "Fitness", "Supplements", "Accessories"].obs;
  var selectedCategory = "Nutrition".obs;

  var selectedDelivery = "Both Shipping & Pickup".obs;

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final descriptionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  var selectedImages = <File>[].obs;
  var index = 0.obs;
  var selectedImagePath = ''.obs;

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        selectedImages.add(File(image.path));
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  void setImageInitial() {
    if (selectedImages.isEmpty) return;
    final imgIndex = selectedImages.length - 1;
    final selectedImgPath = selectedImages[imgIndex].path;
    selectedImagePath.value = selectedImgPath;
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  //call api

  Future<void> validation() async {
    if (selectedImages.isEmpty) {
      return EasyLoading.showError('Please select image');
    }
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        stockController.text.isEmpty) {
      return EasyLoading.showError('Fill required field');
    }
  }

  Future<void> postCreateProduct() async {
    await validation();
    // ignore: unused_local_variable
    final response = await AddProductRequestService.createProduct(
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      price: double.tryParse(priceController.text.trim()) ?? 0.0,
      categoryId: selectedCategory.value,
      stock: int.tryParse(stockController.text.trim()) ?? 0,
      thumbnailImages: selectedImages,
      ingredients: ingredientToJson(),
      keyBenefits: benefitToList(),
    );
  }

  //control ingredients

  // Each ingredient = {label: value}
  var ingredients = <Map<String, String>>[].obs;

  // Add a new empty ingredient row
  void addIngredient() {
    ingredients.add({"label": "", "value": ""});
  }

  // Remove an ingredient
  void removeIngredient(int index) {
    ingredients.removeAt(index);
  }

  // Update label or value
  void updateIngredient(int index, String key, String newValue) {
    ingredients[index][key] = newValue;
    ingredients.refresh();
  }

  // Convert to JSON Map
  Map<String, dynamic> ingredientToJson() {
    if (ingredients.isEmpty) return {};
    final Map<String, dynamic> result = {};
    for (var item in ingredients) {
      if (item["label"]!.isNotEmpty && item["value"]!.isNotEmpty) {
        result[item["label"]!] = item["value"];
      }
    }
    return result;
  }

  //control keyBenefit

  var keyBenefits = <String>[].obs;

  void addBenefit() {
    keyBenefits.add("");
  }

  void removeBenefit(int index) {
    keyBenefits.removeAt(index);
  }

  void updateBenefit(int index, String value) {
    keyBenefits[index] = value;
    keyBenefits.refresh();
  }

  // Convert to List<String> for API

  List<String> benefitToList() {
    if (keyBenefits.isEmpty) return [];
    return keyBenefits.where((benefit) => benefit.trim().isNotEmpty).toList();
  }
}
