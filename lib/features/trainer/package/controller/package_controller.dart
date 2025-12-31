import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/workout/model/program_model.dart';
import '../model/package_model.dart';

class PackageController extends GetxController {
  final NetworkClient _networkClient = Get.find<NetworkClient>();

  final RxList<Program> programList = <Program>[].obs;
  final RxList<String> selectedProgramIds = <String>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isCreating = false.obs;
  final RxString errorMessage = ''.obs;

  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController priceController;
  late final TextEditingController durationController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    durationController = TextEditingController();
    fetchPrograms();
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    durationController.dispose();
    super.onClose();
  }

  Future<void> fetchPrograms() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _networkClient.getRequest(
        url: 'https://wellfitsync.com/programs/my-programs',
      );

      if (response.isSuccess) {
        final dynamic data = response.responseData;

        // API returns a list directly
        List<dynamic> programsData = [];
        if (data is List<dynamic>) {
          programsData = data;
        } else if (data is Map<String, dynamic>) {
          if (data['data'] is List<dynamic>) {
            programsData = data['data'] as List<dynamic>;
          }
        }

        final programs = programsData
            .map((p) => Program.fromJson(p as Map<String, dynamic>))
            .toList();

        programList.assignAll(programs);
      } else {
        errorMessage.value =
            response.errorMessage ?? 'Failed to fetch programs';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  void toggleProgramSelection(String programId) {
    if (selectedProgramIds.contains(programId)) {
      selectedProgramIds.remove(programId);
    } else {
      selectedProgramIds.add(programId);
    }
  }

  void clearSelection() {
    selectedProgramIds.clear();
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    durationController.clear();
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
      if (priceController.text.isEmpty) {
        Get.snackbar('Validation', 'Price is required');
        return false;
      }
      if (durationController.text.isEmpty) {
        Get.snackbar('Validation', 'Duration is required');
        return false;
      }
      if (selectedProgramIds.isEmpty) {
        Get.snackbar('Validation', 'Please select at least one program');
        return false;
      }

      isCreating.value = true;
      EasyLoading.show(status: 'Creating package...');

      final requestBody = {
        'name': nameController.text,
        'description': descriptionController.text,
        'price': double.parse(priceController.text),
        'duration': int.parse(durationController.text),
        'isActive': true,
        'programIds': selectedProgramIds.toList(),
      };

      final response = await _networkClient.postRequest(
        url: 'https://wellfitsync.com/package',
        body: requestBody,
      );

      EasyLoading.dismiss();

      if (response.isSuccess) {
        final responseData = response.responseData;
        Map<String, dynamic> packageJson;

        if (responseData is Map<String, dynamic>) {
          if (responseData['data'] is Map<String, dynamic>) {
            packageJson = responseData['data'] as Map<String, dynamic>;
          } else {
            packageJson = responseData;
          }
        } else {
          packageJson = {};
        }

        final packageData = Package.fromJson(packageJson);
        Get.snackbar('Success', 'Package created successfully!');
        Get.back(result: packageData);
        clearSelection();
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
