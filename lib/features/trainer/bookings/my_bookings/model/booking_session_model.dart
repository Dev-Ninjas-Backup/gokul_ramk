enum SessionStatus {
  upcoming,
  completed,
  cancelled,
  pending,
  active,
  reschedule,
}

class UserInfo {
  final String id;
  final String email;
  final String fullname;
  final String? phone;

  UserInfo({
    required this.id,
    required this.email,
    required this.fullname,
    this.phone,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      fullname: json['fullname'] ?? '',
      phone: json['phone'] as String?,
    );
  }
}

class BookingSessionModel {
  final String id;
  final String userId;
  final String trainerId;
  final String mode; // ONLINE, ONSITE
  final int duration; // in minutes
  final DateTime scheduledDate;
  final String scheduledTime; // e.g., "09:00"
  final String endTime; // e.g., "09:40"
  final String? location;
  final String? notes;
  final String? meetLink;
  final String status; // PENDING, CONFIRMED, COMPLETED, CANCELLED, etc.
  final String price;
  final String currency;
  final String advancePayment;
  final String? assignedProgram;
  final DateTime? cancelledAt;
  final String? cancelledBy;
  final String? cancellationReason;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? bookingType; // ONLINE, ONSITE
  final String? meetingType;
  final String? meetingLink;
  final String? meetingStatus;
  final UserInfo user;
  final UserInfo trainer;
  final dynamic payment;
  final dynamic review;

  BookingSessionModel({
    required this.id,
    required this.userId,
    required this.trainerId,
    required this.mode,
    required this.duration,
    required this.scheduledDate,
    required this.scheduledTime,
    required this.endTime,
    this.location,
    this.notes,
    this.meetLink,
    required this.status,
    required this.price,
    required this.currency,
    required this.advancePayment,
    this.assignedProgram,
    this.cancelledAt,
    this.cancelledBy,
    this.cancellationReason,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
    this.bookingType,
    this.meetingType,
    this.meetingLink,
    this.meetingStatus,
    required this.user,
    required this.trainer,
    this.payment,
    this.review,
  });

  factory BookingSessionModel.fromJson(Map<String, dynamic> json) {
    return BookingSessionModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      trainerId: json['trainerId'] ?? '',
      mode: json['mode'] ?? json['bookingType'] ?? 'ONLINE',
      duration: json['duration'] ?? 0,
      scheduledDate: DateTime.parse(json['scheduledDate'].toString()),
      scheduledTime: json['scheduledTime'] ?? '00:00',
      endTime: json['endTime'] ?? '00:00',
      location: json['location'] as String?,
      notes: json['notes'] as String?,
      meetLink: json['meetLink'] as String?,
      status: json['status'] ?? 'PENDING',
      price: json['price']?.toString() ?? '0',
      currency: json['currency'] ?? 'USD',
      advancePayment: json['advancePayment']?.toString() ?? '0',
      assignedProgram: json['assignedProgram'] as String?,
      cancelledAt: json['cancelledAt'] != null
          ? DateTime.parse(json['cancelledAt'].toString())
          : null,
      cancelledBy: json['cancelledBy'] as String?,
      cancellationReason: json['cancellationReason'] as String?,
      completedAt: json['completedAt'] != null
          ? DateTime.parse(json['completedAt'].toString())
          : null,
      createdAt: DateTime.parse(json['createdAt'].toString()),
      updatedAt: DateTime.parse(json['updatedAt'].toString()),
      bookingType: json['bookingType'] as String?,
      meetingType: json['meetingType'] as String?,
      meetingLink: json['meetingLink'] as String?,
      meetingStatus: json['meetingStatus'] as String?,
      user: UserInfo.fromJson(json['user'] as Map<String, dynamic>),
      trainer: UserInfo.fromJson(json['trainer'] as Map<String, dynamic>),
      payment: json['payment'],
      review: json['review'],
    );
  }

  String get formattedDate {
    final month = scheduledDate.month.toString().padLeft(2, '0');
    final day = scheduledDate.day.toString().padLeft(2, '0');
    final hour = int.parse(scheduledTime.split(':')[0]);
    final minute = int.parse(scheduledTime.split(':')[1]);
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour % 12 == 0 ? 12 : hour % 12;
    return "$month/$day, $displayHour:${minute.toString().padLeft(2, '0')} $period";
  }

  SessionStatus get sessionStatus {
    switch (status.toUpperCase()) {
      case 'COMPLETED':
        return SessionStatus.completed;
      case 'CANCELLED':
        return SessionStatus.cancelled;
      case 'PENDING':
        return SessionStatus.pending;
      case 'CONFIRMED':
      case 'ACTIVE':
        return SessionStatus.active;
      case 'RESCHEDULED':
        return SessionStatus.reschedule;
      default:
        return SessionStatus.upcoming;
    }
  }
}
