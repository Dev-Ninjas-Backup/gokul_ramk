// ignore_for_file: constant_identifier_names, avoid_print

enum EventType { EVENT, CHALLENGE }

enum EventFormat { ONLINE, ONSITE }

enum EventStatus { DRAFT, UPCOMING, ACTIVE, COMPLETED, CANCELLED, ENDED }

enum ParticipantStatus {
  PENDING,
  APPROVED,
  REJECTED,
  JOINED,
  COMPLETED,
  WITHDRAWN,
}

class EventCreator {
  final String id;
  final String fullname;

  EventCreator({required this.id, required this.fullname});

  factory EventCreator.fromJson(Map<String, dynamic> json) {
    return EventCreator(id: json['id'] ?? '', fullname: json['fullname'] ?? '');
  }
}

class EventModel {
  final String id;
  final String title;
  final String description;
  final EventType type;
  final EventFormat format;
  final EventStatus status;
  final String? location;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? registrationDeadline;
  final String? coverImage;
  final List<String>? images;
  final String creatorId;
  final String? hostId;
  final String? challengeCategory;
  final int? targetValue;
  final String? targetUnit;
  final DateTime createdAt;
  final DateTime updatedAt;
  final EventCreator? creator;
  final EventCreator? host;
  final int participantCount;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.format,
    this.status = EventStatus.DRAFT,
    this.location,
    required this.startDate,
    required this.endDate,
    this.registrationDeadline,
    this.coverImage,
    this.images,
    required this.creatorId,
    this.hostId,
    this.challengeCategory,
    this.targetValue,
    this.targetUnit,
    required this.createdAt,
    required this.updatedAt,
    this.creator,
    this.host,
    this.participantCount = 0,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] ?? '',
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
      registrationDeadline: json['registrationDeadline'] != null
          ? DateTime.parse(json['registrationDeadline'].toString())
          : null,
      coverImage: json['coverImage'] as String?,
      images: json['images'] != null
          ? List<String>.from(json['images'] as List)
          : null,
      creatorId: json['creatorId'] ?? '',
      hostId: json['hostId'] as String?,
      challengeCategory: json['challengeCategory'] as String?,
      targetValue: json['targetValue'] as int?,
      targetUnit: json['targetUnit'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'].toString())
          : DateTime.now(),
      creator: json['creator'] != null
          ? EventCreator.fromJson(json['creator'] as Map<String, dynamic>)
          : null,
      host: json['host'] != null
          ? EventCreator.fromJson(json['host'] as Map<String, dynamic>)
          : null,
      participantCount: _parseParticipantCount(json['_count']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': _eventTypeToString(type),
      'format': _eventFormatToString(format),
      'status': _eventStatusToString(status),
      'location': location,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'registrationDeadline': registrationDeadline?.toIso8601String(),
      'coverImage': coverImage,
      'images': images,
      'creatorId': creatorId,
      'hostId': hostId,
      'challengeCategory': challengeCategory,
      'targetValue': targetValue,
      'targetUnit': targetUnit,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '_count': {
        'participants': participantCount,
      },
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
    DateTime? registrationDeadline,
    String? coverImage,
    List<String>? images,
    String? creatorId,
    String? hostId,
    String? challengeCategory,
    int? targetValue,
    String? targetUnit,
    DateTime? createdAt,
    DateTime? updatedAt,
    EventCreator? creator,
    EventCreator? host,
    int? participantCount,
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
      registrationDeadline: registrationDeadline ?? this.registrationDeadline,
      coverImage: coverImage ?? this.coverImage,
      images: images ?? this.images,
      creatorId: creatorId ?? this.creatorId,
      hostId: hostId ?? this.hostId,
      challengeCategory: challengeCategory ?? this.challengeCategory,
      targetValue: targetValue ?? this.targetValue,
      targetUnit: targetUnit ?? this.targetUnit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      creator: creator ?? this.creator,
      host: host ?? this.host,
      participantCount: participantCount ?? this.participantCount,
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

  static int _parseParticipantCount(dynamic count) {
    if (count is Map<String, dynamic>) {
      final participants = count['participants'];
      if (participants is int) return participants;
    }
    return 0;
  }
}

class EventApiResponse {
  final bool success;
  final String message;
  final EventModel? data;

  EventApiResponse({required this.success, required this.message, this.data});

  factory EventApiResponse.fromJson(Map<String, dynamic> json) {
    // Handle data field - it can be a Map (event data) or String (error message)
    EventModel? eventData;
    if (json['data'] != null && json['data'] is Map<String, dynamic>) {
      try {
        eventData = EventModel.fromJson(json['data'] as Map<String, dynamic>);
      } catch (e) {
        print('Error parsing event data: $e');
      }
    }

    // Extract message - use 'data' field as fallback if it's a string error message
    String messageText = _parseMessage(json['message']);
    if (messageText.isEmpty && json['data'] is String) {
      messageText = json['data'] as String;
    }

    return EventApiResponse(
      success: json['success'] ?? false,
      message: messageText,
      data: eventData,
    );
  }

  static String _parseMessage(dynamic message) {
    if (message == null) return '';
    if (message is String) return message;
    return message.toString();
  }
}
