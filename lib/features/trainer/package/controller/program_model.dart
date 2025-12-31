class Program {
  final String id;
  final String trainerId;
  final String name;
  final String description;
  final String categoryId;
  final String difficulty;
  final int durationWeeks;
  final int sessionsPerWeek;
  final String thumbnailUrl;
  final String videoUrl;
  final String price;
  final String currency;
  final bool isActive;
  final int? maxParticipants;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProgramCount count;

  Program({
    required this.id,
    required this.trainerId,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.difficulty,
    required this.durationWeeks,
    required this.sessionsPerWeek,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.price,
    required this.currency,
    required this.isActive,
    this.maxParticipants,
    required this.createdAt,
    required this.updatedAt,
    required this.count,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'] as String,
      trainerId: json['trainerId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      categoryId: json['categoryId'] as String,
      difficulty: json['difficulty'] as String,
      durationWeeks: json['durationWeeks'] as int,
      sessionsPerWeek: json['sessionsPerWeek'] as int,
      thumbnailUrl: json['thumbnailUrl'] as String,
      videoUrl: json['videoUrl'] as String,
      price: json['price'] as String,
      currency: json['currency'] as String,
      isActive: json['isActive'] as bool,
      maxParticipants: json['maxParticipants'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      count: ProgramCount.fromJson(json['_count'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trainerId': trainerId,
      'name': name,
      'description': description,
      'categoryId': categoryId,
      'difficulty': difficulty,
      'durationWeeks': durationWeeks,
      'sessionsPerWeek': sessionsPerWeek,
      'thumbnailUrl': thumbnailUrl,
      'videoUrl': videoUrl,
      'price': price,
      'currency': currency,
      'isActive': isActive,
      'maxParticipants': maxParticipants,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '_count': count.toJson(),
    };
  }
}

class ProgramCount {
  final int enrollments;

  ProgramCount({required this.enrollments});

  factory ProgramCount.fromJson(Map<String, dynamic> json) {
    return ProgramCount(enrollments: json['enrollments'] as int);
  }

  Map<String, dynamic> toJson() {
    return {'enrollments': enrollments};
  }
}
