import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import '../model/package_details_model.dart';

class PackageDetailsController extends GetxController {
  final NetworkClient _networkClient = Get.find<NetworkClient>();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<PackageDetails?> packageDetails = Rx<PackageDetails?>(null);

  Future<void> fetchPackageDetails(String packageId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _networkClient.getRequest(
        url: 'https://wellfitsync.com/package/$packageId',
      );

      if (response.isSuccess) {
        final dynamic responseData = response.responseData;
        Map<String, dynamic> packageJson = {};

        if (responseData is Map<String, dynamic>) {
          if (responseData['data'] is Map<String, dynamic>) {
            packageJson = responseData['data'] as Map<String, dynamic>;
          } else {
            packageJson = responseData;
          }
        }

        if (packageJson.isNotEmpty) {
          final details = PackageDetails.fromJson(packageJson);
          packageDetails.value = details;
        }
      } else {
        errorMessage.value =
            response.errorMessage ?? 'Failed to fetch package details';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deletePackage(String packageId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _networkClient.deleteRequest(
        'https://wellfitsync.com/package/$packageId',
      );

      if (response.isSuccess) {
        Get.snackbar('Success', 'Package deleted successfully');
        Get.back();
        Get.back(); // Go back twice - from details to all packages, then to previous screen
        return true;
      } else {
        errorMessage.value =
            response.errorMessage ?? 'Failed to delete package';
        Get.snackbar('Error', errorMessage.value);
        return false;
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      Get.snackbar('Error', errorMessage.value);
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
