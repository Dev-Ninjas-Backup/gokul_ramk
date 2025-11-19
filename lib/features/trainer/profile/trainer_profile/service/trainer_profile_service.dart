import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/model/trainer_model.dart';

class TrainerService {
  // ignore: avoid_print
  final NetworkClient client = Get.put(NetworkClient(onUnAuthorize: () {
    if (kDebugMode) {
      print("Unauthorized access - TrainerService");
    }
  }));

  Future<Trainer?> getProfile() async {
    final response = await client.getRequest(url: Urls.trainerProfile);

    if (response.isSuccess &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      return Trainer.fromJson(response.responseData!['data']);
    }
    return null;
  }
}
