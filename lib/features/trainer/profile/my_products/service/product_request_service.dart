import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;

class ProductRequestService {
  static final SharedPreferencesHelperController sharedPreference = Get.put(
    SharedPreferencesHelperController(),
  );

  static Future<Map<String, dynamic>> fetchProducts({
    String? search,
    String status = 'Active',
    int page = 1,
    int limit = 10,
  }) async {
    try {
      String? token = await sharedPreference.getAccessToken();

      // Build query parameters
      Map<String, String> queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        'status': status,
      };

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      // Build URL with query parameters
      var url = Uri.parse(
        Urls.getProducts,
      ).replace(queryParameters: queryParams);

      if (kDebugMode) {
        print('=== 📋 FETCH PRODUCTS DEBUG INFO ===');
        print('🔹 URL: $url');
      }

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );

      if (kDebugMode) {
        print('🔹 Status Code: ${response.statusCode}');
        print('🔹 Response Body: ${response.body}');
        print('=====================================\n');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['success'] == true) {
          if (kDebugMode) {
            print('✅ Products fetched successfully');
          }
          return responseData['data'] ?? {};
        }
        return {};
      } else {
        if (kDebugMode) {
          print(
            '❌ Failed to fetch products (${response.statusCode}): ${response.body}',
          );
        }
        return {};
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error fetching products: $e');
      }
      return {};
    }
  }
}
