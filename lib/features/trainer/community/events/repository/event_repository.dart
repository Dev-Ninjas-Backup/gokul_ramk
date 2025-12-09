// ignore_for_file: avoid_print, unnecessary_cast

import 'dart:io';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/community/events/model/event_model.dart';
import 'package:gokul_ramk/features/trainer/community/events/model/event_participant_model.dart';

class EventRepository {
  final NetworkClient networkClient;

  EventRepository({required this.networkClient});

  Future<EventApiResponse?> createEvent({
    required String title,
    required String description,
    required EventType type,
    required EventFormat format,
    required DateTime startDate,
    required DateTime endDate,
    String? location,
    File? coverImageFile,
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

      // Step 2: Create event with the uploaded image URL
      final Map<String, dynamic> eventData = {
        'title': title,
        'description': description,
        'type': _eventTypeToString(type),
        'format': _eventFormatToString(format),
        'startDate': startDate.toUtc().toIso8601String(),
        'endDate': endDate.toUtc().toIso8601String(),
        'status': 'DRAFT',
        if (location != null && location.isNotEmpty) 'location': location,
        if (coverImageUrl != null) 'coverImage': coverImageUrl,
      };

      final response = await networkClient.postRequest(
        url: Urls.createEvent,
        body: eventData,
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
        message: response.errorMessage ?? 'Failed to create event',
      );
    } catch (e) {
      print('Error creating event: $e');
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

  Future<List<EventModel>> getEvents({
    required int page,
    required int limit,
    String sortBy = 'createdAt',
  }) async {
    try {
      final url = '${Urls.getEvents}?sortBy=$sortBy&limit=$limit&page=$page';
      final response = await networkClient.getRequest(url: url);

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData;
        List<dynamic> eventsList = [];

        if (data is List) {
          eventsList = data as List<dynamic>;
        } else if (data is Map<String, dynamic>) {
          if (data.containsKey('data')) {
            final dataField = data['data'];
            if (dataField is List) {
              eventsList = dataField;
            }
          }
        }

        final validEventMaps = eventsList
            .whereType<Map<String, dynamic>>()
            .toList();
        return validEventMaps
            .map((event) => EventModel.fromJson(event))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching events: $e');
      return [];
    }
  }

  Future<ParticipantApiResponse?> joinEvent({required String eventId}) async {
    try {
      final response = await networkClient.postRequest(
        url: Urls.joinEvent(eventId),
        body: {},
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
        message: response.errorMessage ?? 'Failed to join event',
      );
    } catch (e) {
      print('Error joining event: $e');
      return ParticipantApiResponse(
        success: false,
        message: 'Error: ${e.toString()}',
      );
    }
  }

  static String _eventTypeToString(EventType type) {
    return type.toString().split('.').last;
  }

  static String _eventFormatToString(EventFormat format) {
    return format.toString().split('.').last;
  }
}
