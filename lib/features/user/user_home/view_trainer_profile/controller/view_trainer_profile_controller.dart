import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class ViewTrainerProfileController extends GetxController {
  var rating = 4.obs;
  var clients = 200.obs;

  var isLoading = false.obs;
  var userData = {}.obs;

  late NetworkClient networkClient;

  @override
  void onInit() {
    super.onInit();

    // Initialize NetworkClient with onUnAuthorize callback
    networkClient = NetworkClient(onUnAuthorize: handleUnAuthorized);
  }

  Future<void> checkOnboarding() async {
    try {
      isLoading.value = true;

      final NetworkResponse response = await networkClient.getRequest(
        url: Urls.userProfile,
      );

      if (response.isSuccess && response.responseData != null) {
        userData.value = response.responseData!;

        bool onboardingDone =
            response.responseData!["data"]["onboardingDone"] ?? false;

        if (onboardingDone) {
          Get.toNamed(AppRoute.bookTrainerScreen);
        } else {
          Get.toNamed(AppRoute.tellUsAboutYourselfScreen1);
        }
      } else {
        if (kDebugMode) {
          print("Error: ${response.errorMessage}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching profile: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  void handleUnAuthorized() {
    // Handle token expiry / logout
    if (kDebugMode) {
      print("User Unauthorized - logout flow here");
    }
  }
}
