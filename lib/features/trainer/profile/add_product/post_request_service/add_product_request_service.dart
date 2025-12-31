import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;

class AddProductRequestService {
  static final SharedPreferencesHelperController sharedPreference = Get.put(
    SharedPreferencesHelperController(),
  );

  static Future<String> createProduct({
    required String name,
    required String description,
    required double price,
    required String categoryId,
    required int stock,
    required List<dynamic> thumbnailImages, // String URLs only (pre-uploaded)
    double? rating,
    Map<String, dynamic>? ingredients,
    List<String>? keyBenefits,
  }) async {
    try {
      var url = Uri.parse(Urls.createNewProductUrl);
      String? token = await sharedPreference.getAccessToken();

      // Build request body with proper array handling
      final Map<String, dynamic> bodyData = {
        'name': name,
        'description': description,
        'price': price,
        'categoryId': categoryId,
        'stock': stock,
        'status': 'Active',
      };

      if (rating != null) {
        bodyData['rating'] = rating;
      }

      if (ingredients != null && ingredients.isNotEmpty) {
        bodyData['ingredients'] = ingredients;
      }

      // Convert thumbnail images to array of strings
      List<String> thumbnailUrls = [];
      if (thumbnailImages.isNotEmpty) {
        for (var i = 0; i < thumbnailImages.length && i < 5; i++) {
          final item = thumbnailImages[i];
          if (item is String) {
            thumbnailUrls.add(item);
          }
        }
      }

      if (thumbnailUrls.isNotEmpty) {
        bodyData['thumbnail'] = thumbnailUrls;
      }

      if (keyBenefits != null && keyBenefits.isNotEmpty) {
        bodyData['key_benefits'] = keyBenefits;
      }

      // ✅ PRINT REQUEST DETAILS
      if (kDebugMode) {
        print("=== 🧾 REQUEST DEBUG INFO ===");
        print("🔹 URL: $url");
        print("\n🔹 Headers:");
        print("  Authorization: ${token != null ? 'Bearer ***' : 'None'}");
        print("  Content-Type: application/json");
        print("\n🔹 Body:");
        print("  ${jsonEncode(bodyData)}");
        print("===========================\n");
      }

      // Send JSON request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
        body: jsonEncode(bodyData),
      );

      // Handle response
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print('✅ Product created successfully: ${response.body}');
        }
        return response.body;
      } else {
        if (kDebugMode) {
          print(
            '❌ Failed to create product (${response.statusCode}): ${response.body}',
          );
        }
        return response.body;
      }
    } catch (e) {
      debugPrint('error is $e');
      return 'error $e';
    }
  }
}
