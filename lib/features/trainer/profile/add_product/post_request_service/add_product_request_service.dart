import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;

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
    required List<File> thumbnailImages, // up to 5 images
    double? rating,
    Map<String, dynamic>? ingredients,
    List<String>? keyBenefits,
  }) async {
    try {
      var url = Uri.parse(Urls.createNewProductUrl);
      String? token = await sharedPreference.getAccessToken();

      var request = http.MultipartRequest('POST', url);

      // Add text & numeric fields
      request.fields['name'] = name;
      request.fields['description'] = description;
      request.fields['price'] = price.toString();
      request.fields['categoryId'] = categoryId;
      request.fields['stock'] = stock.toString();
      request.fields['status'] = 'Active';

      if (rating != null) {
        request.fields['rating'] = rating.toString();
      }

      // Add object field as JSON string
      if (ingredients != null && ingredients.isNotEmpty) {
        request.fields['ingredients'] = jsonEncode(ingredients);
      }
      // Send key_benefits - add each item as a separate field entry
      if (keyBenefits != null && keyBenefits.isNotEmpty) {
        // In multipart form, adding multiple values with same key creates an array
        for (int i = 0; i < keyBenefits.length; i++) {
          request.fields['key_benefits[$i]'] = keyBenefits[i];
        }
      }

      // Add image files (up to 5)
      for (var i = 0; i < thumbnailImages.length && i < 5; i++) {
        String ext = path.extension(thumbnailImages[i].path).toLowerCase();
        String mimeSubtype;

        if (ext == '.png') {
          mimeSubtype = 'png';
        } else if (ext == '.jpg' || ext == '.jpeg') {
          mimeSubtype = 'jpeg';
        } else {
          mimeSubtype = 'octet-stream';
        }

        var imageFile = await http.MultipartFile.fromPath(
          'thumbnail', // field name as per API docs
          thumbnailImages[i].path,
          contentType: MediaType('image', mimeSubtype),
        );
        request.files.add(imageFile);
      }

      // Add authorization header if needed
      request.headers['Authorization'] = token ?? '';

      // ✅ PRINT REQUEST DETAILS
      if (kDebugMode) {
        print("=== 🧾 REQUEST DEBUG INFO ===");
        print("🔹 URL: ${request.url}");
        print("\n🔹 Headers:");
        request.headers.forEach((k, v) => debugPrint("  $k: $v"));

        print("\n🔹 Fields:");
        request.fields.forEach((k, v) => debugPrint("  $k: $v"));

        print("\n🔹 Files:");
        for (var file in request.files) {
          print("  Field: ${file.field}");
          print("  FileName: ${file.filename}");
          print("  Length: ${file.length}");
        }
        print("===========================\n");
      }

      // Send request
      var response = await request.send();

      // Handle response
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseBody = await response.stream.bytesToString();
        if (kDebugMode) {
          print('✅ Product created successfully: $responseBody');
        }
        return responseBody;
      } else {
        var errorBody = await response.stream.bytesToString();
        if (kDebugMode) {
          print(
            '❌ Failed to create product (${response.statusCode}): $errorBody',
          );
        }
        return errorBody;
      }
    } catch (e) {
      debugPrint('error is $e');
      return 'error $e';
    }
  }
}
