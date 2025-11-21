import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';

class TrainerProfileService {
  final NetworkClient _client = Get.find<NetworkClient>();

  Future<NetworkResponse> createProfile(Map<String, dynamic> body) {
    const url = "https://yourapi.com/api/trainer/profile";
    return _client.postRequest(url: url, body: body);
  }
}
