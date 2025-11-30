class ProgramModel {
  final String id;
  final String trainerId;
  final String name;
  final String description;
  final String categoryId;
  final int duration;
  final int? sessionsPerWeek;
  final String? thumbnailUrl;
  final String? videoUrl;
  final String price;
  final String currency;
  final bool isActive;
  final int? maxParticipants;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<dynamic> workoutDays;
  final Map<String, dynamic>? count;

  ProgramModel({
    required this.id,
    required this.trainerId,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.duration,
    this.sessionsPerWeek,
    this.thumbnailUrl,
    this.videoUrl,
    required this.price,
    required this.currency,
    required this.isActive,
    this.maxParticipants,
    required this.createdAt,
    required this.updatedAt,
    required this.workoutDays,
    this.count,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json) {
    return ProgramModel(
      id: json['id'] as String? ?? '',
      trainerId: json['trainerId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      categoryId: json['categoryId'] as String? ?? '',
      duration: json['duration'] as int? ?? 0,
      sessionsPerWeek: json['sessionsPerWeek'] as int?,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      videoUrl: json['videoUrl'] as String?,
      price: json['price'] as String? ?? '0',
      currency: json['currency'] as String? ?? 'USD',
      isActive: json['isActive'] as bool? ?? false,
      maxParticipants: json['maxParticipants'] as int?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      workoutDays: json['workoutDays'] as List<dynamic>? ?? [],
      count: json['_count'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'trainerId': trainerId,
    'name': name,
    'description': description,
    'categoryId': categoryId,
    'duration': duration,
    'sessionsPerWeek': sessionsPerWeek,
    'thumbnailUrl': thumbnailUrl,
    'videoUrl': videoUrl,
    'price': price,
    'currency': currency,
    'isActive': isActive,
    'maxParticipants': maxParticipants,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
    'workoutDays': workoutDays,
    '_count': count,
  };
}
