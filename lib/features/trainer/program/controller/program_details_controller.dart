import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import '../model/program_model.dart';

class TrainerProgramDetailsController extends GetxController {
  final NetworkClient _client = Get.find<NetworkClient>();

  var program = Rxn<ProgramModel>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchProgramDetails(String programId) async {
    try {
      isLoading(true);
      errorMessage('');

      final url = Urls.getProgramDetails(programId);
      final response = await _client.getRequest(url: url);

      if (response.isSuccess) {
        final data = response.responseData['data'];
        if (data != null) {
          program.value = ProgramModel.fromJson(data as Map<String, dynamic>);
        }
      } else {
        errorMessage.value =
            response.errorMessage ?? 'Failed to load program details';
      }
    } catch (e) {
      if (kDebugMode) print("❌ Error fetching program details: $e");
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoading(false);
    }
  }
}
