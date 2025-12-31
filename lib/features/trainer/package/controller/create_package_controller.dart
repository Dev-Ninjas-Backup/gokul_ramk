import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/session_screen/model/session_model.dart';

class CreatePackageController extends GetxController {
  final NetworkClient _networkClient = Get.find<NetworkClient>();

  final RxList<SessionModel> sessionList = <SessionModel>[].obs;
  final RxList<String> selectedSessionIds = <String>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isCreating = false.obs;
  final RxString errorMessage = ''.obs;

  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController discountController;
  late final TextEditingController expiresInDateController;

  final RxBool isActive = true.obs;
  final RxBool isPublic = true.obs;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    discountController = TextEditingController(text: '0');
    expiresInDateController = TextEditingController();
    fetchSessions();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    discountController.dispose();
    expiresInDateController.dispose();
    super.onClose();
  }

  Future<void> fetchSessions() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _networkClient.getRequest(
        url: 'https://wellfitsync.com/session',
      );

      if (response.isSuccess) {
        final dynamic data = response.responseData;

        List<dynamic> sessionsData = [];

        // Handle nested response structure: data.data.data
        if (data is Map<String, dynamic>) {
          final innerData = data['data'];

          if (innerData is Map<String, dynamic>) {
            // Access the data array from the nested structure
            final sessionsList = innerData['data'];
            if (sessionsList is List<dynamic>) {
              sessionsData = sessionsList;
            }
          } else if (innerData is List<dynamic>) {
            sessionsData = innerData;
          }
        } else if (data is List<dynamic>) {
          sessionsData = data;
        }

        final sessions = sessionsData
            .map((s) => SessionModel.fromJson(s as Map<String, dynamic>))
            .toList();

        sessionList.assignAll(sessions);
      } else {
        errorMessage.value =
            response.errorMessage ?? 'Failed to fetch sessions';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  void toggleSessionSelection(String sessionId) {
    if (selectedSessionIds.contains(sessionId)) {
      selectedSessionIds.remove(sessionId);
    } else {
      selectedSessionIds.add(sessionId);
    }
  }

  void clearSelection() {
    selectedSessionIds.clear();
    nameController.clear();
    descriptionController.clear();
    discountController.text = '0';
    expiresInDateController.clear();
    isActive.value = true;
    isPublic.value = true;
  }

  Future<bool> createPackage() async {
    try {
      // Validation
      if (nameController.text.isEmpty) {
        Get.snackbar('Validation', 'Package name is required');
        return false;
      }
      if (descriptionController.text.isEmpty) {
        Get.snackbar('Validation', 'Description is required');
        return false;
      }
      if (expiresInDateController.text.isEmpty) {
        Get.snackbar('Validation', 'Expiry date is required');
        return false;
      }
      if (selectedSessionIds.isEmpty) {
        Get.snackbar('Validation', 'Please select at least one session');
        return false;
      }

      isCreating.value = true;
      EasyLoading.show(status: 'Creating package...');

      final requestBody = {
        'name': nameController.text,
        'description': descriptionController.text,
        'expiresInDate': expiresInDateController.text,
        'isActive': isActive.value,
        'isPublic': isPublic.value,
        'discount': int.tryParse(discountController.text) ?? 0,
        'sessions': selectedSessionIds.toList(),
      };

      final response = await _networkClient.postRequest(
        url: 'https://wellfitsync.com/package',
        body: requestBody,
      );

      EasyLoading.dismiss();

      if (response.isSuccess) {
        Get.snackbar('Success', 'Package created successfully!');
        clearSelection();
        Get.back();
        return true;
      } else {
        Get.snackbar(
          'Error',
          response.errorMessage ?? 'Failed to create package',
        );
        return false;
      }
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar('Error', 'Error: ${e.toString()}');
      return false;
    } finally {
      isCreating.value = false;
    }
  }
}
