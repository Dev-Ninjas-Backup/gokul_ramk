import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import '../model/package_list_model.dart';

class AllPackagesController extends GetxController {
  final NetworkClient _networkClient = Get.find<NetworkClient>();

  final RxList<PackageListItem> packageList = <PackageListItem>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllPackages();
  }

  Future<void> fetchAllPackages() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _networkClient.getRequest(
        url: 'https://wellfitsync.com/package',
      );

      if (response.isSuccess) {
        final dynamic data = response.responseData;

        List<dynamic> packagesData = [];
        if (data is Map<String, dynamic>) {
          if (data['data'] is List<dynamic>) {
            packagesData = data['data'] as List<dynamic>;
          }
        } else if (data is List<dynamic>) {
          packagesData = data;
        }

        final packages = packagesData
            .map((p) => PackageListItem.fromJson(p as Map<String, dynamic>))
            .toList();

        packageList.assignAll(packages);
      } else {
        errorMessage.value =
            response.errorMessage ?? 'Failed to fetch packages';
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
        // Remove the deleted package from the list
        packageList.removeWhere((item) => item.id == packageId);
        Get.snackbar('Success', 'Package deleted successfully');
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
