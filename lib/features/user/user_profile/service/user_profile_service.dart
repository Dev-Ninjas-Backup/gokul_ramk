// user_profile_service.dart
// Simple service to GET and PATCH user profile
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';

class UserProfileService {
  static Future<NetworkResponse> fetchProfile() async {
    try {
      final client = Get.find<NetworkClient>();
      final res = await client.getRequest(url: Urls.userProfile);
      return res;
    } catch (e) {
      print('fetchProfile error: $e');
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
        statusCode: -1,
      );
    }
  }

  static Future<NetworkResponse> updateProfile(
    Map<String, dynamic> body,
  ) async {
    try {
      final client = Get.find<NetworkClient>();
      final res = await client.patchRequest(
        // Use the user profile update endpoint for partial profile updates
        url: Urls.updateUserProfile,
        body: body,
      );
      return res;
    } catch (e) {
      print('updateProfile error: $e');
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
        statusCode: -1,
      );
    }
  }

  /// Upload a single profile image file and return the full URL on success.
  /// Returns null on failure and shows a snackbar with the error.
  static Future<String?> uploadProfileImage(File file) async {
    try {
      final client = Get.find<NetworkClient>();
      final res = await client.uploadFile(url: Urls.uploadFile, file: file);
      if (res.isSuccess && res.responseData != null) {
        // API returns file object with url
        final fileObj = res.responseData!['file'];
        if (fileObj != null && fileObj['url'] != null) {
          return fileObj['url'] as String;
        }
      }
      Get.snackbar('Upload Failed', res.errorMessage ?? 'Try again');
      return null;
    } catch (e) {
      print('uploadProfileImage error: $e');
      Get.snackbar('Upload Error', e.toString());
      return null;
    }
  }
}
