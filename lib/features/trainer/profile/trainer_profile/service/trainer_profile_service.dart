import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/profile/my_products/model/product_model.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/model/trainer_model.dart';
import 'package:http/http.dart' as http;

class TrainerService {
  // ignore: avoid_print
  final NetworkClient client = Get.put(
    NetworkClient(
      onUnAuthorize: () {
        if (kDebugMode) {
          print("Unauthorized access - TrainerService");
        }
      },
    ),
  );

  final SharedPreferencesHelperController sharedPreference = Get.put(
    SharedPreferencesHelperController(),
  );

  Future<Trainer?> getProfile() async {
    final response = await client.getRequest(url: Urls.trainerProfile);

    if (response.isSuccess &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      return Trainer.fromJson(response.responseData!['data']);
    }
    return null;
  }

  Future<List<Product>> getRecentProducts({int limit = 2}) async {
    try {
      String? token = await sharedPreference.getAccessToken();

      Map<String, String> queryParams = {'limit': limit.toString()};

      var url = Uri.parse(
        Urls.getProducts,
      ).replace(queryParameters: queryParams);

      if (kDebugMode) {
        print('=== 📋 FETCH RECENT PRODUCTS DEBUG INFO ===');
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
        print('==========================================\n');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData['success'] == true) {
          final data = responseData['data'];
          List<dynamic> productsList = [];

          // Handle different response structures
          if (data is List) {
            productsList = data;
          } else if (data is Map && data['data'] is List) {
            productsList = data['data'];
          }

          final products = productsList
              .map((item) {
                try {
                  return Product.fromJson(item as Map<String, dynamic>);
                } catch (e) {
                  if (kDebugMode) print('Error parsing product: $e');
                  return null;
                }
              })
              .whereType<Product>()
              .toList();

          if (kDebugMode) {
            print('✅ Recent products fetched successfully: ${products.length}');
          }

          return products;
        }
      }
      return [];
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error fetching recent products: $e');
      }
      return [];
    }
  }
}
