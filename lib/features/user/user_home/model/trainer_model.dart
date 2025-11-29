class FeatureTrainerModel {
  final String id;
  final String name;
  final String? bio;
  final List<String> specializations;
  final String? image;
  final String? city;
  final String? nationality;

  FeatureTrainerModel({
    required this.id,
    required this.name,
    this.bio,
    required this.specializations,
    this.image,
    this.city,
    this.nationality,
  });

  factory FeatureTrainerModel.fromJson(Map<String, dynamic> json) {
    return FeatureTrainerModel(
      id: json["id"] ?? "",
      name: json["fullname"] ?? "",
      bio: json["bio"] ?? "No Bio",
      specializations: json["specializations"] != null
          ? List<String>.from(json["specializations"])
          : [],
      image: json["images"], // could be null
      city: json["city"],
      nationality: json["nationality"],
    );
  }
}
