class BookingModel {
  final String id;
  final String userId;
  final String trainerId;
  final String trainerName;
  final int duration;
  final String? location;
  final String status;
  final String? scheduledDate;
  final String? scheduledTime;

  BookingModel({
    required this.id,
    required this.userId,
    required this.trainerId,
    required this.trainerName,
    required this.duration,
    this.location,
    required this.status,
    this.scheduledDate,
    this.scheduledTime,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      trainerId: json['trainerId'] as String,
      trainerName: json['trainer'] != null
          ? (json['trainer']['fullname'] ?? '') as String
          : '',
      duration: (json['duration'] ?? 0) as int,
      location: json['location'] as String?,
      status: (json['status'] ?? '') as String,
      scheduledDate: json['scheduledDate'] as String?,
      scheduledTime: json['scheduledTime'] as String?,
    );
  }
}
