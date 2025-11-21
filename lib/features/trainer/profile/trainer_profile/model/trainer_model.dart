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
      id: json['id'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      role: json['role'] ?? '',
      nationality: json['nationality'] ?? '',
      city: json['city'] ?? '',

      // SAFE IMAGE
      images: (json['images'] ?? "").toString().isEmpty
          ? "https://www.pngitem.com/pimgs/m/663-6635378_user-avatar-login-account-profile-people-simple-head.png"
          : json['images'],

      // SAFE BIO
      bio: json['bio'] ?? "No bio available",

      // SAFE LIST
      specializations: json['specializations'] != null
          ? List<String>.from(json['specializations'])
          : <String>["Yoga", "Cardio"],

      areaOfService: json['areaOfService'] ?? "",

      // Convert any type → string
      rate: json['rate']?.toString(),

      trainerStatus: json['trainerStatus'] ?? "",
      userStatus: json['userStatus'] ?? "",
      isDeleted: json['isDeleted'] ?? false,

      // SAFE AVAILABILITY LIST
      availabilities: json['availabilities'] != null
          ? (json['availabilities'] as List)
                .map((e) => Availability.fromJson(e))
                .toList()
          : <Availability>[],

      sessionType: json['sessionType'] ?? "",

      // SAFE REVIEW LIST
      receivedReviews: json['receivedReviews'] ?? [],

      isVerified: json['isVerified'] ?? false,

      hourlyRate: json['hourlyRate']?.toString() ?? "0",

      createdAt:
          DateTime.tryParse(json['createdAt'] ?? "") ??
          DateTime.fromMillisecondsSinceEpoch(0),

      updatedAt:
          DateTime.tryParse(json['updatedAt'] ?? "") ??
          DateTime.fromMillisecondsSinceEpoch(0),
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
      id: json['id'] ?? '',
      day: json['day'] ?? '',
      startDate:
          DateTime.tryParse(json['startDate'] ?? "") ??
          DateTime.fromMillisecondsSinceEpoch(0),
      endDate:
          DateTime.tryParse(json['endDate'] ?? "") ??
          DateTime.fromMillisecondsSinceEpoch(0),
      isBooked: json['isBooked'] ?? false,
      userId: json['userId'] ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? "") ??
          DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt:
          DateTime.tryParse(json['updatedAt'] ?? "") ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}
