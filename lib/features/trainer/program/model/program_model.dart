// models/program_model.dart
class WorkoutSession {
  final String exercise;
  final String sets;
  final String reps;
  final String duration;
  final String? videoUrl;

  WorkoutSession({
    required this.exercise,
    required this.sets,
    required this.reps,
    required this.duration,
    this.videoUrl,
  });
}

class WorkoutProgram {
  final String name;
  final String duration;
  final String category;
  final String description;
  final String? thumbnail;
  final List<WorkoutSession> sessions;

  WorkoutProgram({
    required this.name,
    required this.duration,
    required this.category,
    required this.description,
    this.thumbnail,
    this.sessions = const [],
  });

  WorkoutProgram copyWith({List<WorkoutSession>? sessions}) {
    return WorkoutProgram(
      name: name,
      duration: duration,
      category: category,
      description: description,
      thumbnail: thumbnail,
      sessions: sessions ?? this.sessions,
    );
  }
}

class TrainerInfo {
  final String id;
  final String fullname;
  final String? phone;
  final String email;

  TrainerInfo({
    required this.id,
    required this.fullname,
    this.phone,
    required this.email,
  });

  factory TrainerInfo.fromJson(Map<String, dynamic> json) {
    return TrainerInfo(
      id: json['id'] ?? '',
      fullname: json['fullname'] ?? '',
      phone: json['phone'],
      email: json['email'] ?? '',
    );
  }
}

class ProgramModel {
  final String id;
  final String trainerId;
  final String name;
  final String description;
  final String difficulty;
  final String thumbnailUrl;
  final String videoUrl;
  final String price;
  final String currency;
  final bool isActive;
  final int maxParticipants;
  final String createdAt;
  final String updatedAt;
  final List<dynamic> sessions;
  final int enrollments;
  final TrainerInfo? trainer;

  ProgramModel({
    required this.id,
    required this.trainerId,
    required this.name,
    required this.description,
    required this.difficulty,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.price,
    required this.currency,
    required this.isActive,
    required this.maxParticipants,
    required this.createdAt,
    required this.updatedAt,
    required this.sessions,
    required this.enrollments,
    this.trainer,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> json) {
    return ProgramModel(
      id: json['id'] ?? '',
      trainerId: json['trainerId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      difficulty: json['difficulty'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      price: json['price']?.toString() ?? '0',
      currency: json['currency'] ?? 'USD',
      isActive: json['isActive'] ?? false,
      maxParticipants: json['maxParticipants'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      sessions: json['sessions'] ?? [],
      enrollments: json['_count']?['enrollments'] ?? 0,
      trainer: json['trainer'] != null
          ? TrainerInfo.fromJson(json['trainer'] as Map<String, dynamic>)
          : null,
    );
  }
}
