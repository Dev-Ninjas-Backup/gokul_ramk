import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/user/user_home/model/program_model.dart';
import 'package:gokul_ramk/features/user/user_home/service/user_home_service.dart';

class ProgramDetailsController extends GetxController {
 final CategoryService service = CategoryService(
    client: NetworkClient(
      onUnAuthorize: () {
        if (kDebugMode) {
          print("unauthorized");
        }
      },
    ),
  );

  var isLoading = false.obs;
  var program = Rxn<Program1>();
  var errorMessage = ''.obs;

  Future<void> fetchProgramDetails(String id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await service.fetchProgramById(id);

      if (result != null) {
        program.value = result;
      } else {
        errorMessage.value = 'Program not found';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
