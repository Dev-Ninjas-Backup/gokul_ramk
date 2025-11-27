class FeatureTrainerModel {
  final String name;
  final String? bio;
  final List<String> specializations;
  final String? image;

  FeatureTrainerModel({
    required this.name,
    this.bio,
    required this.specializations,
    this.image,
  });

  factory FeatureTrainerModel.fromJson(Map<String, dynamic> json) {
    return FeatureTrainerModel(
      name: json["fullname"] ?? "",
      bio: json["bio"] ?? "No Bio",
      specializations: json["specializations"] != null
          ? List<String>.from(json["specializations"])
          : [],
      image: json["images"], 
    );
  }
}
