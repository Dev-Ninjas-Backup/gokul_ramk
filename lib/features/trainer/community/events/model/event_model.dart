enum EventType { EVENT, CHALLENGE }

enum EventFormat { ONLINE, ONSITE }

enum EventStatus { DRAFT, UPCOMING, ACTIVE, COMPLETED, CANCELLED, ENDED }

class EventModel {
  final String? id;
  final String title;
  final String description;
  final EventType type;
  final EventFormat format;
  final EventStatus status;
  final String? location;
  final DateTime startDate;
  final DateTime endDate;
  final String? coverImage;

  EventModel({
    this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.format,
    this.status = EventStatus.DRAFT,
    this.location,
    required this.startDate,
    required this.endDate,
    this.coverImage,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String?,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: _parseEventType(json['type']),
      format: _parseEventFormat(json['format']),
      status: _parseEventStatus(json['status'] ?? 'DRAFT'),
      location: json['location'] as String?,
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'].toString())
          : DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'].toString())
          : DateTime.now(),
      coverImage: json['coverImage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'type': _eventTypeToString(type),
      'format': _eventFormatToString(format),
      'status': _eventStatusToString(status),
      'location': location,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      if (coverImage != null) 'coverImage': coverImage,
    };
  }

  EventModel copyWith({
    String? id,
    String? title,
    String? description,
    EventType? type,
    EventFormat? format,
    EventStatus? status,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    String? coverImage,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      format: format ?? this.format,
      status: status ?? this.status,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      coverImage: coverImage ?? this.coverImage,
    );
  }

  static EventType _parseEventType(dynamic value) {
    if (value is String) {
      return EventType.values.firstWhere(
        (e) => e.toString().split('.').last == value,
        orElse: () => EventType.EVENT,
      );
    }
    return EventType.EVENT;
  }

  static EventFormat _parseEventFormat(dynamic value) {
    if (value is String) {
      return EventFormat.values.firstWhere(
        (e) => e.toString().split('.').last == value,
        orElse: () => EventFormat.ONLINE,
      );
    }
    return EventFormat.ONLINE;
  }

  static EventStatus _parseEventStatus(dynamic value) {
    if (value is String) {
      return EventStatus.values.firstWhere(
        (e) => e.toString().split('.').last == value,
        orElse: () => EventStatus.DRAFT,
      );
    }
    return EventStatus.DRAFT;
  }

  static String _eventTypeToString(EventType type) {
    return type.toString().split('.').last;
  }

  static String _eventFormatToString(EventFormat format) {
    return format.toString().split('.').last;
  }

  static String _eventStatusToString(EventStatus status) {
    return status.toString().split('.').last;
  }
}

class EventApiResponse {
  final bool success;
  final String message;
  final EventModel? data;

  EventApiResponse({required this.success, required this.message, this.data});

  factory EventApiResponse.fromJson(Map<String, dynamic> json) {
    return EventApiResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? EventModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}
