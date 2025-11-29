// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/profile/add_product/model/category_model.dart';
import 'package:gokul_ramk/features/trainer/profile/add_product/post_request_service/add_product_request_service.dart';
import 'package:gokul_ramk/features/trainer/profile/add_product/post_request_service/category_request_service.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController {
  var categories = <ProductCategory>[].obs;
  var selectedCategory = Rx<ProductCategory?>(null);
  var isLoadingCategories = true.obs;

  var selectedDelivery = "Both Shipping & Pickup".obs;

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final descriptionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  var selectedImages = <File>[].obs;
  var uploadedImageUrls = <String>[].obs;
  var index = 0.obs;
  var selectedImagePath = ''.obs;
  var isUploadingImages = false.obs;

  late NetworkClient networkClient;

  @override
  void onInit() {
    super.onInit();
    networkClient = Get.find<NetworkClient>();
    fetchCategories();
  }

  @override
  void onClose() {
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> fetchCategories() async {
    try {
      isLoadingCategories.value = true;
      final categoryList =
          await CategoryRequestService.fetchProductCategories();

      if (categoryList.isNotEmpty) {
        categories.value = categoryList
            .map(
              (item) => ProductCategory.fromJson(item as Map<String, dynamic>),
            )
            .toList();

        // Set first category as default
        if (categories.isNotEmpty) {
          selectedCategory.value = categories[0];
        }
      }
    } catch (e) {
      EasyLoading.showError('Failed to load categories: $e');
    } finally {
      isLoadingCategories.value = false;
    }
  }

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
    if (selectedCategory.value == null) {
      return EasyLoading.showError('Please select a category');
    }
  }

  // Upload multiple images and get URLs
  Future<bool> _uploadProductImages() async {
    if (selectedImages.isEmpty) {
      EasyLoading.showError('No images to upload');
      return false;
    }

    try {
      isUploadingImages.value = true;
      EasyLoading.show(status: 'Uploading images...');

      final response = await networkClient.uploadMultipleFiles(
        url: Urls.uploadMultiple,
        files: selectedImages,
        fieldName: 'files',
      );

      if (!response.isSuccess || response.responseData == null) {
        EasyLoading.showError('Failed to upload images');
        return false;
      }

      final responseData = response.responseData;
      if (responseData is! Map<String, dynamic>) {
        EasyLoading.showError('Invalid upload response format');
        return false;
      }

      // Extract URLs from response: { "files": [ { "url": "..." }, ... ] }
      final filesList = responseData['files'];
      if (filesList is! List) {
        EasyLoading.showError('No files in upload response');
        return false;
      }

      uploadedImageUrls.clear();
      for (final fileData in filesList) {
        if (fileData is Map<String, dynamic> && fileData.containsKey('url')) {
          final urlPath = fileData['url'] as String;
          // Check if URL is already complete (starts with http)
          final fullUrl = urlPath.startsWith('http')
              ? urlPath
              : '${Urls.baseUrl}$urlPath';
          uploadedImageUrls.add(fullUrl);
        }
      }

      if (uploadedImageUrls.isEmpty) {
        EasyLoading.showError('No valid image URLs received');
        return false;
      }

      print('✅ Successfully uploaded ${uploadedImageUrls.length} images');
      return true;
    } catch (e) {
      print('Error uploading images: $e');
      EasyLoading.showError('Error uploading images: $e');
      return false;
    } finally {
      isUploadingImages.value = false;
    }
  }

  Future<void> postCreateProduct() async {
    await validation();
    try {
      // Step 1: Upload images and get URLs
      final imagesUploaded = await _uploadProductImages();
      if (!imagesUploaded) {
        return; // Error message already shown by _uploadProductImages
      }

      // Step 2: Create product with uploaded image URLs
      EasyLoading.show(status: 'Creating product...');
      final response = await AddProductRequestService.createProduct(
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        price: double.tryParse(priceController.text.trim()) ?? 0.0,
        categoryId: selectedCategory.value?.id ?? '',
        stock: int.tryParse(stockController.text.trim()) ?? 0,
        thumbnailImages: uploadedImageUrls
            .toList(), // Pass uploaded URLs as list
        ingredients: ingredientToJson(),
        keyBenefits: benefitToList(),
      );

      // Parse response
      final responseData = jsonDecode(response);

      if (responseData['success'] == true) {
        EasyLoading.dismiss();

        // Clear all fields
        clearAllFields();

        // Show success dialog
        Get.dialog(
          AlertDialog(
            title: const Text('Success!'),
            content: const Text(
              'Your product has been submitted for review. '
              'A commission fee applies per sale.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // Close dialog
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        EasyLoading.showError(
          responseData['message'] ?? 'Failed to create product',
        );
      }
    } catch (e) {
      EasyLoading.showError('Error: $e');
    }
  }

  /// Clear all input fields and selections
  void clearAllFields() {
    nameController.clear();
    priceController.clear();
    stockController.clear();
    descriptionController.clear();
    selectedImages.clear();
    uploadedImageUrls.clear();
    ingredients.clear();
    keyBenefits.clear();
    if (categories.isNotEmpty) {
      selectedCategory.value = categories[0];
    }
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
