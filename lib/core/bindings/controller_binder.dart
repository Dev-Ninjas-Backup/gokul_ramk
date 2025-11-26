import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // Initialize NetworkClient
    Get.put<NetworkClient>(
      NetworkClient(
        onUnAuthorize: () {
          // Handle unauthorized access
          // You can navigate to login or refresh token here
        },
      ),
    );
  }
}
