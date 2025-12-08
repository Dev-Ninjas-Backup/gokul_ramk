// ignore_for_file: avoid_print, unnecessary_cast

import 'dart:io';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/community/events/model/event_model.dart';
import 'package:gokul_ramk/features/trainer/community/events/model/event_participant_model.dart';

class ChallengeRepository {
  final NetworkClient networkClient;

  ChallengeRepository({required this.networkClient});

  Future<EventApiResponse?> createChallenge({
    required String title,
    required String description,
    required EventFormat format,
    required DateTime startDate,
    required DateTime endDate,
    String? location,
    File? coverImageFile,
    String? challengeCategory,
    int? targetValue,
    String? targetUnit,
  }) async {
    try {
      String? coverImageUrl;

      // Step 1: Upload cover image if provided
      if (coverImageFile != null) {
        coverImageUrl = await _uploadCoverImage(coverImageFile);
        if (coverImageUrl == null) {
          print('Error: Failed to upload cover image');
          return EventApiResponse(
            success: false,
            message: 'Failed to upload cover image',
          );
        }
      }

      // Step 2: Create challenge with the uploaded image URL
      final Map<String, dynamic> challengeData = {
        'title': title,
        'description': description,
        'type': 'CHALLENGE',
        'format': _eventFormatToString(format),
        'startDate': startDate.toUtc().toIso8601String(),
        'endDate': endDate.toUtc().toIso8601String(),
        'status': 'DRAFT',
        if (location != null && location.isNotEmpty) 'location': location,
        if (coverImageUrl != null) 'coverImage': coverImageUrl,
        if (challengeCategory != null) 'challengeCategory': challengeCategory,
        if (targetValue != null) 'targetValue': targetValue,
        if (targetUnit != null) 'targetUnit': targetUnit,
      };

      final response = await networkClient.postRequest(
        url: Urls.createEvent,
        body: challengeData,
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData;

        if (data is Map<String, dynamic>) {
          return EventApiResponse.fromJson(data);
        } else {
          return EventApiResponse(
            success: false,
            message: 'Invalid response format',
          );
        }
      } else if (!response.isSuccess && response.responseData != null) {
        // Handle error responses that have response data
        final data = response.responseData;
        if (data is Map<String, dynamic>) {
          return EventApiResponse.fromJson(data);
        }
      }

      return EventApiResponse(
        success: false,
        message: response.errorMessage ?? 'Failed to create challenge',
      );
    } catch (e) {
      print('Error creating challenge: $e');
      return EventApiResponse(
        success: false,
        message: 'Error: ${e.toString()}',
      );
    }
  }

  Future<String?> _uploadCoverImage(File imageFile) async {
    try {
      final response = await networkClient.uploadFile(
        url: Urls.uploadFile,
        file: imageFile,
        fieldName: 'file',
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData;

        // Ensure data is a Map
        if (data is! Map<String, dynamic>) {
          print('Error: Upload response is not a valid map');
          return null;
        }

        if (!data.containsKey('file')) {
          print('Error: Upload response missing "file" field');
          return null;
        }

        final fileData = data['file'];
        if (fileData is! Map<String, dynamic>) {
          print('Error: file field is not a valid map');
          return null;
        }

        if (!fileData.containsKey('url')) {
          print('Error: file object missing "url" field');
          return null;
        }

        final urlPath = fileData['url'] as String;
        // If URL is already complete (starts with http), use as-is
        if (urlPath.startsWith('http')) {
          return urlPath;
        }
        // Otherwise combine baseUrl with the relative path
        return '${Urls.baseUrl}$urlPath';
      } else {
        print('Error: Upload failed - ${response.errorMessage}');
      }
      return null;
    } catch (e) {
      print('Error uploading cover image: $e');
      return null;
    }
  }

  Future<List<EventModel>> getChallenges({
    required int page,
    required int limit,
    String sortBy = 'createdAt',
  }) async {
    try {
      final url =
          '${Urls.getEvents}?sortBy=$sortBy&limit=$limit&page=$page&type=CHALLENGE';
      final response = await networkClient.getRequest(url: url);

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData;
        List<dynamic> challengesList = [];

        if (data is List) {
          challengesList = data as List<dynamic>;
        } else if (data is Map<String, dynamic>) {
          if (data.containsKey('data')) {
            final dataField = data['data'];
            if (dataField is List) {
              challengesList = dataField;
            }
          }
        }

        final validChallengeMaps = challengesList
            .whereType<Map<String, dynamic>>()
            .toList();
        return validChallengeMaps
            .map((challenge) => EventModel.fromJson(challenge))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching challenges: $e');
      return [];
    }
  }

  Future<ParticipantApiResponse?> joinChallenge({
    required String challengeId,
  }) async {
    try {
      final response = await networkClient.postRequest(
        url: Urls.joinEvent(challengeId),
        body: {'type': 'CHALLENGE'},
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData;

        if (data is Map<String, dynamic>) {
          return ParticipantApiResponse.fromJson(data);
        } else {
          return ParticipantApiResponse(
            success: false,
            message: 'Invalid response format',
          );
        }
      } else if (!response.isSuccess && response.responseData != null) {
        // Handle error responses that have response data
        final data = response.responseData;
        if (data is Map<String, dynamic>) {
          return ParticipantApiResponse.fromJson(data);
        }
      }

      return ParticipantApiResponse(
        success: false,
        message: response.errorMessage ?? 'Failed to join challenge',
      );
    } catch (e) {
      print('Error joining challenge: $e');
      return ParticipantApiResponse(
        success: false,
        message: 'Error: ${e.toString()}',
      );
    }
  }

  static String _eventFormatToString(EventFormat format) {
    return format.toString().split('.').last;
  }
}
