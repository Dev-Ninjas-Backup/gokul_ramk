// meal_plan_service.dart
// ignore_for_file: avoid_print

import 'dart:io';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/meal_plan_screen/model/get_meal_model.dart';

class MealPlanService {
  final NetworkClient client;

  MealPlanService(this.client);

  /// Upload image → returns relative image URL
  Future<String?> uploadImage(File imageFile) async {
    try {
      final res = await client.uploadFile(
        url: Urls.uploadFile,
        file: imageFile,
        fieldName: "file",
      );

      print("UPLOAD ==================== RESPONSE: ${res.responseData}");

      if (!res.isSuccess) return null;

      // CASE 1: { "url": "path" }
      if (res.responseData?['url'] != null) {
        return res.responseData!['url'];
      }

      // CASE 2: { "data": { "url": "path" } }
      if (res.responseData?['file']?['url'] != null) {
        return res.responseData!['file']['url'];
      }

      return null;
    } catch (e) {
      print("Image Upload Error: $e");
      return null;
    }
  }

  /// Fetch meal list
  static Future<List<GetMeal>> fetchMeals() async {
    try {
      final client = Get.find<NetworkClient>();
      final res = await client.getRequest(url: Urls.getMeal);

      if (res.isSuccess && res.responseData?['data'] != null) {
        final data = res.responseData!['data'] as List;
        return data.map((e) => GetMeal.fromJson(e)).toList();
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load meals");
    }
    return [];
  }

  /// Send create meal plan request
  Future<NetworkResponse> createMealPlan({
    required Map<String, dynamic> data,
    required String imageUrl,
  }) async {
    data["image"] = imageUrl; // backend needs "image"

    return await client.postRequest(url: Urls.createMealPlan, body: data);
  }

  /// Upload Image → Create Plan → Return response
  Future<NetworkResponse> createPlanWithImage({
    required Map<String, dynamic> data,
    File? imageFile,
  }) async {
    String finalImageUrl = "";

    if (imageFile != null) {
      final uploadedUrl = await uploadImage(imageFile);

      if (uploadedUrl == null) {
        return NetworkResponse(
          isSuccess: false,
          errorMessage: "Image upload failed===============",
          statusCode: -1,
        );
      }

      // Fix absolute/relative URL
      if (uploadedUrl.startsWith("http")) {
        finalImageUrl = uploadedUrl;
      } else {
        finalImageUrl = Urls.baseUrl + uploadedUrl;
      }
    }

    return await createMealPlan(data: data, imageUrl: finalImageUrl);
  }

  /// Edit existing meal plan (PATCH). Uses same body shape as create.
  Future<NetworkResponse> editMealPlan({
    required String id,
    required Map<String, dynamic> data,
    required String imageUrl,
  }) async {
    data["image"] = imageUrl;
    final url = '${Urls.editMealPlan}/$id';
    return await client.patchRequest(url: url, body: data);
  }

  /// Upload Image → Edit Plan → Return response
  Future<NetworkResponse> editPlanWithImage({
    required String id,
    required Map<String, dynamic> data,
    File? imageFile,
  }) async {
    String finalImageUrl = "";

    if (imageFile != null) {
      final uploadedUrl = await uploadImage(imageFile);

      if (uploadedUrl == null) {
        return NetworkResponse(
          isSuccess: false,
          errorMessage: "Image upload failed===============",
          statusCode: -1,
        );
      }

      if (uploadedUrl.startsWith("http")) {
        finalImageUrl = uploadedUrl;
      } else {
        finalImageUrl = Urls.baseUrl + uploadedUrl;
      }
    }

    return await editMealPlan(id: id, data: data, imageUrl: finalImageUrl);
  }
}
