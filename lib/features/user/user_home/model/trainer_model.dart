

// class FeatureTrainerModel {
//   final String id;
//   final String name;
//   final String? bio;
//   final List<String> specializations;
//   final String? image;
//   final String? city;
//   final String? nationality;

//   // ⭐ Newly added
//   final double avgRating;
//   final int totalReviews;

//   FeatureTrainerModel({
//     required this.id,
//     required this.name,
//     this.bio,
//     required this.specializations,
//     this.image,
//     this.city,
//     this.nationality,
//     required this.avgRating,
//     required this.totalReviews,
//   });

//   factory FeatureTrainerModel.fromJson(Map<String, dynamic> json) {
//     return FeatureTrainerModel(
//       id: json["id"] ?? "",
//       name: json["fullname"] ?? "",
//       bio: json["bio"] ?? "No Bio",
//       specializations: json["specializations"] != null
//           ? List<String>.from(json["specializations"])
//           : [],
//       image: json["images"], 
//       city: json["city"],
//       nationality: json["nationality"],

//       /// ⭐ Safe parsing
//       avgRating: (json["avgRating"] ?? 0).toDouble(),
//       totalReviews: json["totalReviews"] ?? 0,
//     );
//   }
// }


class FeatureTrainerModel {
  final String id;
  final String name;
  final String? bio;
  final List<String> specializations;
  final String? image;
  final String? city;
  final String? nationality;

  final double avgRating;
  final int totalReviews;

  FeatureTrainerModel({
    required this.id,
    required this.name,
    this.bio,
    required this.specializations,
    this.image,
    this.city,
    this.nationality,
    required this.avgRating,
    required this.totalReviews,
  });

  factory FeatureTrainerModel.fromJson(Map<String, dynamic> json) {
    return FeatureTrainerModel(
      id: json["id"] ?? "",
      name: json["fullname"] ?? "",
      bio: json["bio"]?.toString() ?? "No Bio",

      specializations: json["specializations"] is List
          ? List<String>.from(json["specializations"])
          : [],

      image: json["images"]?.toString(),

      city: json["city"]?.toString(),
      nationality: json["nationality"]?.toString(),

      avgRating: _parseToDouble(json["avgRating"]),
      totalReviews: _parseToInt(json["totalReviews"]),
    );
  }

  // ---------- SAFE PARSERS ----------
  static double _parseToDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }

  static int _parseToInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    return int.tryParse(v.toString()) ?? 0;
  }
}
