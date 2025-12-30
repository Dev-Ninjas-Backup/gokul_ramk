class WorkoutListResponse {
  final String? status;
  final String? message;
  final WorkoutData? data;
  final int? statusCode;

  WorkoutListResponse({this.status, this.message, this.data, this.statusCode});

  factory WorkoutListResponse.fromJson(Map<String, dynamic> json) {
    return WorkoutListResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? WorkoutData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      statusCode: json['statusCode'] as int?,
    );
  }
}

class WorkoutData {
  final List<Workout>? workouts;
  final Metadata? metadata;

  WorkoutData({this.workouts, this.metadata});

  factory WorkoutData.fromJson(Map<String, dynamic> json) {
    return WorkoutData(
      workouts: (json['workouts'] as List<dynamic>?)
          ?.map((e) => Workout.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'] != null
          ? Metadata.fromJson(json['metadata'] as Map<String, dynamic>)
          : null,
    );
  }
}

class Workout {
  final String? id;
  final String? name;
  final String? difficulty;
  final int? duration;
  final String? description;
  final String? coverImage;
  final int? usageCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? sessionId;
  final Map<String, dynamic>? session;
  final List<Exercise>? exercises;

  Workout({
    this.id,
    this.name,
    this.difficulty,
    this.duration,
    this.description,
    this.coverImage,
    this.usageCount,
    this.createdAt,
    this.updatedAt,
    this.sessionId,
    this.session,
    this.exercises,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'] as String?,
      name: json['name'] as String?,
      difficulty: json['difficulty'] as String?,
      duration: json['duration'] as int?,
      description: json['description'] as String?,
      coverImage: json['coverImage'] as String?,
      usageCount: json['usageCount'] as int?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      sessionId: json['sessionId'] as String?,
      session: json['session'] as Map<String, dynamic>?,
      exercises: (json['exercises'] as List<dynamic>?)
          ?.map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Exercise {
  final String? id;
  final String? name;
  final String? description;

  Exercise({this.id, this.name, this.description});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
    );
  }
}

class Metadata {
  final int? total;
  final int? page;
  final int? limit;
  final int? totalPages;

  Metadata({this.total, this.page, this.limit, this.totalPages});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      total: json['total'] as int?,
      page: json['page'] as int?,
      limit: json['limit'] as int?,
      totalPages: json['totalPages'] as int?,
    );
  }
}
