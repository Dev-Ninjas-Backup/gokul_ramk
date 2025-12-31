import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import '../model/program_model.dart';

class MyProgramsController extends GetxController {
  final NetworkClient _client = Get.find<NetworkClient>();

  var programs = <ProgramModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyPrograms();
  }

  Future<void> fetchMyPrograms() async {
    try {
      isLoading(true);
      final response = await _client.getRequest(url: Urls.myProgram);

      if (response.isSuccess) {
        final List<dynamic> data = response.responseData['data'] ?? [];
        programs.value = data
            .map((item) => ProgramModel.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      if (kDebugMode) print("❌ Error fetching programs: $e");
      Get.snackbar('Error', 'Failed to load programs');
    } finally {
      isLoading(false);
    }
  }

  // Public method to refresh programs list
  Future<void> refreshPrograms() async {
    if (kDebugMode) print("🔄 Refreshing programs list...");
    await fetchMyPrograms();
    if (kDebugMode) print("✅ Programs list refreshed");
  }
}
