// lib/models/trainer_model.dart

class Trainer {
  final String id;
  final String fullname;
  final String email;
  final String? phone;
  final String role;
  final String nationality;
  final String city;
  final String images;
  final String bio;
  final List<String> specializations;
  final String areaOfService;
  final String? rate;
  final String trainerStatus;
  final String userStatus;
  final bool isDeleted;
  final List<Availability> availabilities;
  final String sessionType;
  final List<dynamic> receivedReviews;
  final bool isVerified;
  final String hourlyRate;
  final DateTime createdAt;
  final DateTime updatedAt;

  Trainer({
    required this.id,
    required this.fullname,
    required this.email,
    this.phone,
    required this.role,
    required this.nationality,
    required this.city,
    required this.images,
    required this.bio,
    required this.specializations,
    required this.areaOfService,
    this.rate,
    required this.trainerStatus,
    required this.userStatus,
    required this.isDeleted,
    required this.availabilities,
    required this.sessionType,
    required this.receivedReviews,
    required this.isVerified,
    required this.hourlyRate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      id: json['id'] as String,
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      role: json['role'] as String,
      nationality: json['nationality'] as String,
      city: json['city'] as String,
      images: json['images'] as String,
      bio: json['bio'] as String,
      specializations:
          List<String>.from(json['specializations'] ?? <String>["Yoga","Cardio"]),
      areaOfService: json['areaOfService'] as String,
      rate: json['rate']?.toString(),
      trainerStatus: json['trainerStatus'] as String,
      userStatus: json['userStatus'] as String,
      isDeleted: json['isDeleted'] as bool,
      availabilities: (json['availabilities'] as List<dynamic>? ?? [])
          .map((e) => Availability.fromJson(e as Map<String, dynamic>))
          .toList(),
      sessionType: json['sessionType'] as String,
      receivedReviews: json['receivedReviews'] as List<dynamic>? ?? [],
      isVerified: json['isVerified'] as bool,
      hourlyRate: json['hourlyRate'].toString(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}

class Availability {
  final String id;
  final String day;
  final DateTime startDate;
  final DateTime endDate;
  final bool isBooked;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Availability({
    required this.id,
    required this.day,
    required this.startDate,
    required this.endDate,
    required this.isBooked,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      id: json['id'] as String,
      day: json['day'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      isBooked: json['isBooked'] as bool,
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}
