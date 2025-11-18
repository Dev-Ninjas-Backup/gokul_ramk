
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
// import 'package:gokul_ramk/features/trainer/program/model/categories_model.dart';
// import 'package:http/http.dart' as http;

// class ProgramService {
//   final String baseUrl = "https://wellfitsync.com";
//   final SharedPreferencesHelperController pref = Get.put(
//     SharedPreferencesHelperController(),
//   );

//   /// Fetch categories
//   static Future<List<CategoryModel>> fetchCategories() async {
//     final url = Uri.parse("https://wellfitsync.com/categories?type=PROGRAM");

//     final pref = Get.put(SharedPreferencesHelperController());
//     final token = await pref.getAccessToken() ?? '';
//     Map<String, String> commonHeaders = {
//       'Content-Type': 'application/json',
//       'authorization': token,
//     };

//     final res = await http.get(url, headers: commonHeaders);

//     if (res.statusCode == 200 || res.statusCode == 201) {
//       final list = jsonDecode(res.body)["data"] as List;

//       print("=====================================$list");
//       return list.map((e) => CategoryModel.fromJson(e)).toList();
//     }
//     return [];
//   }

//   /// Create Program
//   Future<bool> createProgram(Map<String, dynamic> body) async {
//     final url = Uri.parse("$baseUrl/programs");

//     final String? token = await pref.getAccessToken();
//     if (token == null) {
//       if (kDebugMode) print("No token found");
//       return false;
//     }

//     final response = await http.post(
//       url,
//       headers: {"Content-Type": "application/json", "Authorization": token},
//       body: jsonEncode(body),
//     );

//     if (kDebugMode) print("Program Response => ${response.body}");

//     return response.statusCode == 200 || response.statusCode == 201;
//   }
// }



// features/trainer/program/services/program_services.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import '../model/categories_model.dart';

class ProgramService {
  final NetworkClient _client = Get.find<NetworkClient>();
  static const String _base = "https://wellfitsync.com";

  // Upload file and return full URL
  Future<String?> uploadFile(File file) async {
    final response = await _client.uploadFile(
      url: "$_base/upload",
      file: file,
    );

    if (response.isSuccess) {
      final String relative = response.responseData!['file']['url'];
      return _base + relative;
    } else {
      Get.snackbar("Upload Failed", response.errorMessage ?? "Try again",
          backgroundColor: Colors.red, colorText: Colors.white);
      return null;
    }
  }

  // Fetch categories
// program_services.dart
static Future<List<CategoryModel>> fetchCategories() async {
  try {
    final client = Get.find<NetworkClient>();
    final res = await client.getRequest(url: "https://wellfitsync.com/categories?type=PROGRAM");

    if (res.isSuccess && res.responseData != null) {
      // ←←← THIS IS THE ONLY CHANGE ←←←
      final List<dynamic> data = res.responseData!['data'] as List<dynamic>;
      return data.map((json) => CategoryModel.fromJson(json)).toList();
    }
  } catch (e) {
    Get.snackbar("Error", "Failed to load categories");
  }
  return [];
}
  // Create program
  Future<bool> createProgram(Map<String, dynamic> body) async {
    final res = await _client.postRequest(
      url: "https://wellfitsync.com/programs",
      body: body,
    );
    return res.isSuccess;
  }
}