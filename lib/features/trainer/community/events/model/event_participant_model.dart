// ignore_for_file: constant_identifier_names, avoid_print

enum ParticipantStatus {
  PENDING,
  APPROVED,
  REJECTED,
  JOINED,
  COMPLETED,
  WITHDRAWN,
}

class EventParticipant {
  final String id;
  final String userId;
  final String eventId;
  final ParticipantStatus status;
  final DateTime joinedAt;
  final DateTime? completedAt;
  final DateTime? withdrawnAt;
  final String? approvedBy;
  final DateTime? approvedAt;
  final String? rejectionReason;
  final DateTime updatedAt;
  final ParticipantUser? user;
  final ParticipantEvent? event;

  EventParticipant({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.status,
    required this.joinedAt,
    this.completedAt,
    this.withdrawnAt,
    this.approvedBy,
    this.approvedAt,
    this.rejectionReason,
    required this.updatedAt,
    this.user,
    this.event,
  });

  factory EventParticipant.fromJson(Map<String, dynamic> json) {
    return EventParticipant(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      eventId: json['eventId'] ?? '',
      status: _parseParticipantStatus(json['status']),
      joinedAt: json['joinedAt'] != null
          ? DateTime.parse(json['joinedAt'].toString())
          : DateTime.now(),
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'].toString())
          : null,
      withdrawnAt: json['withdrawnAt'] != null
          ? DateTime.parse(json['withdrawnAt'].toString())
          : null,
      approvedBy: json['approvedBy'] as String?,
      approvedAt: json['approvedAt'] != null
          ? DateTime.parse(json['approvedAt'].toString())
          : null,
      rejectionReason: json['rejectionReason'] as String?,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'].toString())
          : DateTime.now(),
      user: json['user'] != null
          ? ParticipantUser.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      event: json['event'] != null
          ? ParticipantEvent.fromJson(json['event'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'eventId': eventId,
      'status': _participantStatusToString(status),
      'joinedAt': joinedAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'withdrawnAt': withdrawnAt?.toIso8601String(),
      'approvedBy': approvedBy,
      'approvedAt': approvedAt?.toIso8601String(),
      'rejectionReason': rejectionReason,
      'updatedAt': updatedAt.toIso8601String(),
      'user': user?.toJson(),
      'event': event?.toJson(),
    };
  }

  static ParticipantStatus _parseParticipantStatus(dynamic value) {
    if (value is String) {
      return ParticipantStatus.values.firstWhere(
        (e) => e.toString().split('.').last == value,
        orElse: () => ParticipantStatus.PENDING,
      );
    }
    return ParticipantStatus.PENDING;
  }

  static String _participantStatusToString(ParticipantStatus status) {
    return status.toString().split('.').last;
  }
}

class ParticipantUser {
  final String id;
  final String fullname;

  ParticipantUser({required this.id, required this.fullname});

  factory ParticipantUser.fromJson(Map<String, dynamic> json) {
    return ParticipantUser(
      id: json['id'] ?? '',
      fullname: json['fullname'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'fullname': fullname};
  }
}

class ParticipantEvent {
  final String id;
  final String title;
  final String description;
  final String type;
  final String format;
  final String status;
  final String? location;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime registrationDeadline;
  final String? coverImage;
  final List<String>? images;
  final String creatorId;
  final String? hostId;
  final String? challengeCategory;
  final int? targetValue;
  final String? targetUnit;
  final DateTime createdAt;
  final DateTime updatedAt;

  ParticipantEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.format,
    required this.status,
    this.location,
    required this.startDate,
    required this.endDate,
    required this.registrationDeadline,
    this.coverImage,
    this.images,
    required this.creatorId,
    this.hostId,
    this.challengeCategory,
    this.targetValue,
    this.targetUnit,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ParticipantEvent.fromJson(Map<String, dynamic> json) {
    return ParticipantEvent(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      format: json['format'] ?? '',
      status: json['status'] ?? '',
      location: json['location'] as String?,
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'].toString())
          : DateTime.now(),
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'].toString())
          : DateTime.now(),
      registrationDeadline: json['registrationDeadline'] != null
          ? DateTime.parse(json['registrationDeadline'].toString())
          : DateTime.now(),
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'format': format,
      'status': status,
      'location': location,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'registrationDeadline': registrationDeadline.toIso8601String(),
      'coverImage': coverImage,
      'images': images,
      'creatorId': creatorId,
      'hostId': hostId,
      'challengeCategory': challengeCategory,
      'targetValue': targetValue,
      'targetUnit': targetUnit,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class ParticipantApiResponse {
  final bool success;
  final String message;
  final EventParticipant? data;

  ParticipantApiResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ParticipantApiResponse.fromJson(Map<String, dynamic> json) {
    // Handle data field - it can be a Map (participant data) or String (error message)
    EventParticipant? participantData;
    if (json['data'] != null && json['data'] is Map<String, dynamic>) {
      try {
        participantData = EventParticipant.fromJson(
          json['data'] as Map<String, dynamic>,
        );
      } catch (e) {
        print('Error parsing participant data: $e');
      }
    }

    // If data is directly in the root level (not wrapped in 'data' field)
    if (participantData == null &&
        json.containsKey('id') &&
        json.containsKey('userId') &&
        json.containsKey('eventId')) {
      try {
        participantData = EventParticipant.fromJson(json);
      } catch (e) {
        print('Error parsing participant data from root: $e');
      }
    }

    // Extract message - use 'data' field as fallback if it's a string error message
    String messageText = _parseMessage(json['message']);
    if (messageText.isEmpty && json['data'] is String) {
      messageText = json['data'] as String;
    }

    return ParticipantApiResponse(
      success: json['success'] ?? true,
      message: messageText,
      data: participantData,
    );
  }

  static String _parseMessage(dynamic message) {
    if (message == null) return '';
    if (message is String) return message;
    return message.toString();
  }
}
