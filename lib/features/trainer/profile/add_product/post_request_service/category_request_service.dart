import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;

class CategoryRequestService {
  static final SharedPreferencesHelperController sharedPreference = Get.put(
    SharedPreferencesHelperController(),
  );

  static Future<List<dynamic>> fetchProductCategories() async {
    try {
      var url = Uri.parse(Urls.productCategories);
      String? token = await sharedPreference.getAccessToken();

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );

      if (kDebugMode) {
        print('=== 📋 FETCH CATEGORIES DEBUG INFO ===');
        print('🔹 URL: $url');
        print('🔹 Status Code: ${response.statusCode}');
        print('🔹 Response Body: ${response.body}');
        print('=====================================\n');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['success'] == true && responseData['data'] != null) {
          final data = responseData['data'];

          // Handle nested 'data' field in response
          if (data is Map && data['data'] is List) {
            List<dynamic> categories = data['data'];
            if (kDebugMode) {
              print(
                '✅ Categories fetched successfully: ${categories.length} items',
              );
            }
            return categories;
          } else if (data is List) {
            if (kDebugMode) {
              print('✅ Categories fetched successfully: ${data.length} items');
            }
            return data;
          }
        }
        return [];
      } else {
        if (kDebugMode) {
          print(
            '❌ Failed to fetch categories (${response.statusCode}): ${response.body}',
          );
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error fetching categories: $e');
      }
      return [];
    }
  }
}
