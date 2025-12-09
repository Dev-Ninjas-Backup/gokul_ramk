// ignore_for_file: avoid_print, unnecessary_cast

import 'dart:io';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/community/groups/model/group_api_model.dart';
import 'package:gokul_ramk/features/trainer/community/groups/model/groups_model.dart';

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

  Future<List<GroupModel>> getGroups({
    required int page,
    required int limit,
    String sortBy = 'createdAt',
  }) async {
    try {
      final url = '${Urls.getGroups}?sortBy=$sortBy&limit=$limit&page=$page';
      final response = await networkClient.getRequest(url: url);

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData;
        List<dynamic> groupsList = [];

        if (data is List) {
          groupsList = data as List<dynamic>;
        } else if (data is Map<String, dynamic>) {
          if (data.containsKey('data')) {
            final dataField = data['data'];
            if (dataField is List) {
              groupsList = dataField;
            }
          }
        }

        final validGroupMaps = groupsList
            .whereType<Map<String, dynamic>>()
            .toList();
        return validGroupMaps
            .map((group) => GroupModel.fromJson(group))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching groups: $e');
      return [];
    }
  }

  Future<GroupModel?> joinGroup(String groupId) async {
    try {
      final url = Urls.joinGroup(groupId);
      final response = await networkClient.postRequest(url: url, body: {});

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData;

        if (data is Map<String, dynamic>) {
          return GroupModel.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      print('Error joining group: $e');
      return null;
    }
  }

  Future<bool> leaveGroup(String groupId) async {
    try {
      final url = Urls.leaveGroup(groupId);
      final response = await networkClient.deleteRequest(url);

      if (response.isSuccess) {
        return true;
      }
      return false;
    } catch (e) {
      print('Error leaving group: $e');
      return false;
    }
  }
}
