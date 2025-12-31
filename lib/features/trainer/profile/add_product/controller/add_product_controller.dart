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
import 'package:url_launcher/url_launcher.dart';

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
        showDialog(
          context: Get.context!,
          builder: (context) => AlertDialog(
            title: const Text('Success!'),
            content: const Text(
              'Your product has been submitted for review. '
              'A commission fee applies per sale.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        EasyLoading.dismiss();

        // Extract error message from nested response structure
        String errorMessage =
            responseData['message'] ?? 'Failed to create product';
        String? onboardingUrl;

        // Check for nested error response (Stripe verification case)
        if (responseData['data'] is Map<String, dynamic>) {
          final data = responseData['data'] as Map<String, dynamic>;
          if (data['response'] is Map<String, dynamic>) {
            final nestedResponse = data['response'] as Map<String, dynamic>;
            errorMessage = nestedResponse['message'] ?? errorMessage;
            onboardingUrl = nestedResponse['onboardingUrl'] as String?;
          }
        }

        // Show error dialog with better formatting
        showDialog(
          context: Get.context!,
          builder: (context) => AlertDialog(
            title: const Text('Error Creating Product'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  if (onboardingUrl != null) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'You need to complete Stripe verification:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        try {
                          final Uri stripeUrl = Uri.parse(onboardingUrl!);
                          await launchUrl(
                            stripeUrl,
                            mode: LaunchMode.externalApplication,
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error opening URL: $e')),
                          );
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Complete Stripe Onboarding',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Error: $e', style: const TextStyle(fontSize: 14)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
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
