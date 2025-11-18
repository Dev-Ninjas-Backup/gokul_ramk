import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/program/model/excercise_model.dart';
import '../model/categories_model.dart';

class ProgramService {
  final NetworkClient _client = Get.find<NetworkClient>();
  static const String _base = "https://wellfitsync.com";

  // Upload file and return full URL
  Future<String?> uploadFile(File file) async {
    final response = await _client.uploadFile(url: "$_base/upload", file: file);

    if (response.isSuccess) {
      final String relative = response.responseData!['file']['url'];
      return _base + relative;
    } else {
      Get.snackbar(
        "Upload Failed",
        response.errorMessage ?? "Try again",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    }
  }

  // Fetch categories
  // program_services.dart
  static Future<List<CategoryModel>> fetchCategories() async {
    try {
      final client = Get.find<NetworkClient>();
      final res = await client.getRequest(
        url: "https://wellfitsync.com/categories?type=PROGRAM",
      );

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

  //fetch excercises

  Future<ExerciseResponse> fetchAllExercises() async {
    try {
      final res = await _client.getRequest(
        url: "https://wellfitsync.com/workout-exercises",
      );

      if (res.isSuccess && res.responseData != null) {
        return ExerciseResponse.fromJson(res.responseData!);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load exercises");
      rethrow;
    }

    return ExerciseResponse(data: []);
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
