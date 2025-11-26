class TrainerModel {
  final String id;
  final String fullname;
  final String email;
  final String? phone;
  final String role;
  final String? nationality;
  final String? city;
  final String? images;
  final String? bio;
  final List<String>? specializations;
  final String? areaOfService;
  final String? trainerStatus;
  final String? userStatus;
  final bool? isDeleted;
  final List<Availability>? availabilities;
  final String? sessionType;
  final List<dynamic>? receivedReviews;
  final bool? isVerified;
  final String? hourlyRate;
  final String? createdAt;
  final String? updatedAt;

  TrainerModel({
    required this.id,
    required this.fullname,
    required this.email,
    this.phone,
    required this.role,
    this.nationality,
    this.city,
    this.images,
    this.bio,
    this.specializations,
    this.areaOfService,
    this.trainerStatus,
    this.userStatus,
    this.isDeleted,
    this.availabilities,
    this.sessionType,
    this.receivedReviews,
    this.isVerified,
    this.hourlyRate,
    this.createdAt,
    this.updatedAt,
  });

  factory TrainerModel.fromJson(Map<String, dynamic> json) {
    return TrainerModel(
      id: json['id'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      role: json['role'] ?? '',
      nationality: json['nationality'],
      city: json['city'],
      images: json['images'],
      bio: json['bio'],
      specializations: (json['specializations'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      areaOfService: json['areaOfService'],
      trainerStatus: json['trainerStatus'],
      userStatus: json['userStatus'],
      isDeleted: json['isDeleted'] ?? false,
      availabilities: (json['availabilities'] as List<dynamic>?)
          ?.map((e) => Availability.fromJson(e as Map<String, dynamic>))
          .toList(),
      sessionType: json['sessionType'],
      receivedReviews: json['receivedReviews'] as List<dynamic>?,
      isVerified: json['isVerified'] ?? false,
      hourlyRate: json['hourlyRate'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Availability {
  final String id;
  final String day;
  final String startDate;
  final String endDate;
  final bool isBooked;
  final String userId;
  final String createdAt;
  final String updatedAt;

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
      id: json['id'] ?? '',
      day: json['day'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      isBooked: json['isBooked'] ?? false,
      userId: json['userId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}
