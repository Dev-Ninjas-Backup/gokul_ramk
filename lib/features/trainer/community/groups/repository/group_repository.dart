import 'dart:io';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/community/groups/model/group_api_model.dart';

class GroupRepository {
  final NetworkClient networkClient;

  GroupRepository({required this.networkClient});

  Future<GroupApiResponse?> createGroup({
    required String name,
    required String description,
    File? thumbnailFile,
  }) async {
    try {
      Map<String, String> extraFields = {
        'name': name,
        'description': description,
      };

      NetworkResponse response;

      if (thumbnailFile != null) {
        // Upload with file
        response = await networkClient.uploadFile(
          url: Urls.createGroup,
          file: thumbnailFile,
          fieldName: 'thumbnail',
          extraFields: extraFields,
        );
      } else {
        // Create without file (thumbnail optional)
        response = await networkClient.postRequest(
          url: Urls.createGroup,
          body: extraFields,
        );
      }

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData;

        if (data is Map<String, dynamic>) {
          return GroupApiResponse.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      print('Error creating group: $e');
      return null;
    }
  }
}
