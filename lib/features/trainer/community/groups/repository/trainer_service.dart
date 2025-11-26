// ignore_for_file: avoid_print

import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/community/groups/model/trainer_model.dart';

class TrainerService {
  final NetworkClient networkClient;

  TrainerService({required this.networkClient});

  Future<TrainerModel?> getCurrentTrainer() async {
    try {
      final response = await networkClient.getRequest(
        url: Urls.trainerProfileMe,
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData;

        if (data is Map<String, dynamic>) {
          // Check if data is wrapped in a 'data' field
          if (data.containsKey('data')) {
            final trainerData = data['data'];
            if (trainerData is Map<String, dynamic>) {
              return TrainerModel.fromJson(trainerData);
            }
          } else {
            // Data is directly the trainer object
            return TrainerModel.fromJson(data);
          }
        }
      }
      return null;
    } catch (e) {
      print('Error fetching current trainer: $e');
      return null;
    }
  }
}
