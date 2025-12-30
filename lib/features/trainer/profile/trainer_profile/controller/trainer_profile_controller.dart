// trainer_profile_controller.dart
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/profile/my_products/model/product_model.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/model/trainer_model.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/model/program_model.dart';
import 'package:image_picker/image_picker.dart';

import '../service/trainer_profile_service.dart';

class TrainerProfileController extends GetxController {
  TrainerService trainerService = TrainerService();
  // Basic Info

  // Programs Offered - Using API response
  var programs = <ProgramModel>[].obs;

  // ✅ Products
  var products = <Product>[].obs;

  var totalRevenue = 5700.0.obs;
  var totalProductsSold = 120.obs;

  var balance = 15590.0.obs;

  //for api
  var trainerProfileData = Rxn<Trainer>();

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchTrainerProfile();
    fetchRecentProducts();
    fetchPrograms();
  }

  var isLoading = false.obs;

  Future<void> fetchTrainerProfile() async {
    try {
      isLoading.value = true;
      var data = await trainerService.getProfile();
      trainerProfileData.value = data;
      // Ensure observers are notified even if same instance is assigned
      trainerProfileData.refresh();
      if (kDebugMode)
        print(
          '✅ Trainer profile fetched: ${trainerProfileData.value?.fullname}',
        );
    } catch (e) {
      if (kDebugMode) print("Error fetching trainer profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void fetchRecentProducts() async {
    try {
      final recentProducts = await trainerService.getRecentProducts(limit: 2);
      products.value = recentProducts;
    } catch (e) {
      if (kDebugMode) print("Error fetching products: $e");
    }
  }

  void fetchPrograms() async {
    try {
      final myPrograms = await trainerService.getMyPrograms();
      programs.value = myPrograms;
      if (kDebugMode) print("Programs fetched: ${programs.length}");
    } catch (e) {
      if (kDebugMode) print("Error fetching programs: $e");
    }
  }

  Future<void> updateProfileImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        EasyLoading.show(status: 'Updating...');
        final file = File(image.path);
        final networkClient = Get.find<NetworkClient>();

        // 1. Upload Image
        final uploadRes = await networkClient.uploadFile(
          url: "https://wellfitsync.com/upload",
          file: file,
        );

        if (uploadRes.isSuccess) {
          String imageUrl = "";
          final data = uploadRes.responseData;
          if (data is Map) {
            if (data['url'] != null) {
              imageUrl = data['url'];
            } else if (data['file'] is Map && data['file']['url'] != null) {
              imageUrl = data['file']['url'];
            }
          }

          if (imageUrl.isNotEmpty) {
            // 2. Patch Profile
            final patchRes = await networkClient.patchRequest(
              url: "https://wellfitsync.com/trainer/profile",
              body: {"images": imageUrl},
            );

            if (patchRes.isSuccess) {
              EasyLoading.showSuccess("Profile updated");
              fetchTrainerProfile();
            } else {
              EasyLoading.showError(patchRes.errorMessage ?? "Update failed");
            }
          }
        } else {
          EasyLoading.showError(uploadRes.errorMessage ?? "Upload failed");
        }
      }
    } catch (e) {
      EasyLoading.showError("Error: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
