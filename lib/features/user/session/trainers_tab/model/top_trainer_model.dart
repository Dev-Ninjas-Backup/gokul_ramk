class TopTrainer {
  final String id;
  final String fullname;
  final String email;
  final String? phone;
  final String? nationality;
  final dynamic rate;
  final String? bio;
  final List<String> specializations;
  final String? images;
  final String? city;
  final String? sessionType;
  final double avgRating;
  final int totalReviews;
  final int totalPrograms;
  final String? areaOfService;
  final double hourlyRate;

  TopTrainer({
    required this.id,
    required this.fullname,
    required this.email,
    this.phone,
    this.nationality,
    this.rate,
    this.bio,
    required this.specializations,
    this.images,
    this.city,
    this.sessionType,
    required this.avgRating,
    required this.totalReviews,
    required this.totalPrograms,
    this.areaOfService,
    required this.hourlyRate,
  });

  factory TopTrainer.fromJson(Map<String, dynamic> json) {
    return TopTrainer(
      id: json["id"] ?? "",
      fullname: json["fullname"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"],
      nationality: json["nationality"],
      rate: json["rate"],
      bio: json["bio"],
      specializations: json["specializations"] != null
          ? List<String>.from(json["specializations"])
          : [],
      images: json["images"],
      city: json["city"],
      sessionType: json["sessionType"],
      avgRating: (json["avgRating"] ?? 0).toDouble(),
      totalReviews: json["totalReviews"] ?? 0,
      totalPrograms: json["totalPrograms"] ?? 0,
      areaOfService: json["areaOfService"],
      hourlyRate:
          json["hourlyRate"] != null ? (json["hourlyRate"]).toDouble() : 0.0,
    );
  }
}
