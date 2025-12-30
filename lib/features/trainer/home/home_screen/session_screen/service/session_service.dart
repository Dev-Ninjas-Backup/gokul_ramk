// session_service.dart
// Service to fetch packages, programs, categories and manage sessions
// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import '../model/package_model.dart';
import '../model/program_model.dart';
import '../model/category_model.dart';

class SessionService {
  final NetworkClient client;

  SessionService(this.client);

  static Future<List<PackageModel>> fetchPackages() async {
    try {
      final client = Get.find<NetworkClient>();
      final res = await client.getRequest(url: Urls.myPackage);

      if (res.isSuccess && res.responseData != null) {
        final data =
            res.responseData!['data'] as List? ??
            res.responseData!['data']?['data'] as List?;

        if (data != null) {
          return data.map((e) => PackageModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load packages');
      print('fetchPackages error: $e');
    }
    return [];
  }

  static Future<List<ProgramModel>> fetchPrograms() async {
    try {
      final client = Get.find<NetworkClient>();
      final res = await client.getRequest(url: Urls.myProgram);

      if (res.isSuccess && res.responseData != null) {
        final data =
            res.responseData!['data'] as List? ??
            res.responseData!['data']?['data'] as List?;

        if (data != null) {
          return data.map((e) => ProgramModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load programs');
      print('fetchPrograms error: $e');
    }
    return [];
  }

  static Future<List<CategoryModel>> fetchCategories() async {
    try {
      final client = Get.find<NetworkClient>();
      final res = await client.getRequest(url: Urls.getCategories);

      if (res.isSuccess && res.responseData != null) {
        final data =
            res.responseData!['data']?['data'] as List? ??
            res.responseData!['data'] as List?;

        if (data != null) {
          return data.map((e) => CategoryModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories');
      print('fetchCategories error: $e');
    }
    return [];
  }

  Future<NetworkResponse> createSession({
    required Map<String, dynamic> body,
  }) async {
    return await client.postRequest(url: Urls.createSession, body: body);
  }

  static Future<List> fetchSessions({int page = 1, int limit = 10}) async {
    try {
      final client = Get.find<NetworkClient>();
      final url = '${Urls.createSession}?page=$page&limit=$limit';
      final res = await client.getRequest(url: url);

      if (res.isSuccess && res.responseData != null) {
        final data =
            res.responseData!['data']?['data'] as List? ??
            res.responseData!['data'] as List?;

        if (data != null) return data;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load sessions');
      print('fetchSessions error: $e');
    }
    return [];
  }

  Future<NetworkResponse> getSessionById(String id) async {
    final url = '${Urls.createSession}/$id';
    return await client.getRequest(url: url);
  }

  Future<NetworkResponse> updateSession({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    final url = '${Urls.createSession}/$id';

    return await client.patchRequest(url: url, body: data);
  }

  static Future<NetworkResponse> deleteSessionById(String id) async {
    try {
      final client = Get.find<NetworkClient>();
      final url = '${Urls.createSession}/$id';
      return await client.deleteRequest(url);
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete session');
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
        statusCode: -1,
      );
    }
  }
}
