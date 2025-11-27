import 'dart:io';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/community/events/model/event_model.dart';

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
      Map<String, String> extraFields = {
        'title': title,
        'description': description,
        'type': _eventTypeToString(type),
        'format': _eventFormatToString(format),
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'status': 'DRAFT',
        if (location != null) 'location': location,
      };

      NetworkResponse response;

      if (coverImageFile != null) {
        // Upload with file
        response = await networkClient.uploadFile(
          url: Urls.createEvent,
          file: coverImageFile,
          fieldName: 'coverImage',
          extraFields: extraFields,
        );
      } else {
        // Create without file (coverImage optional)
        response = await networkClient.postRequest(
          url: Urls.createEvent,
          body: extraFields,
        );
      }

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData;

        if (data is Map<String, dynamic>) {
          return EventApiResponse.fromJson(data);
        }
      }
      return null;
    } catch (e) {
      print('Error creating event: $e');
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

  static String _eventTypeToString(EventType type) {
    return type.toString().split('.').last;
  }

  static String _eventFormatToString(EventFormat format) {
    return format.toString().split('.').last;
  }
}
