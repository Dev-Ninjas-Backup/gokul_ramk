class FeatureWorkoutsModel {
  final bool? success;
  final String? message;
  final FeatureData? data;

  FeatureWorkoutsModel({
    this.success,
    this.message,
    this.data,
  });

  factory FeatureWorkoutsModel.fromJson(Map<String, dynamic> json) {
    return FeatureWorkoutsModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? FeatureData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };
}

class FeatureData {
  final List<Workout> data;
  final int? totalCount;
  final int? page;
  final int? pageSize;
  final int? totalPages;

  FeatureData({
    required this.data,
    this.totalCount,
    this.page,
    this.pageSize,
    this.totalPages,
  });

  factory FeatureData.fromJson(Map<String, dynamic> json) {
    return FeatureData(
      data: json['data'] != null
          ? List<Workout>.from(json['data'].map((x) => Workout.fromJson(x)))
          : [],
      totalCount: json['totalCount'],
      page: json['page'],
      pageSize: json['pageSize'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data.map((e) => e.toJson()).toList(),
        'totalCount': totalCount,
        'page': page,
        'pageSize': pageSize,
        'totalPages': totalPages,
      };
}

class Workout {
  final String? id;
  final String? name;
  final String? difficulty;
  final int? duration;
  final String? description;
  final String? status;
  final String? coverImage;
  final String? workoutType;
  final int? usageCount;
  final String? createdAt;
  final String? updatedAt;
  final String? userId;
  final String? categoryId;
  final Category? category;
  final List<dynamic>? exercises;

  Workout({
    this.id,
    this.name,
    this.difficulty,
    this.duration,
    this.description,
    this.status,
    this.coverImage,
    this.workoutType,
    this.usageCount,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.categoryId,
    this.category,
    this.exercises,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      name: json['name'],
      difficulty: json['difficulty'],
      duration: json['duration'],
      description: json['description'],
      status: json['status'],
      coverImage: json['coverImage'],
      workoutType: json['workoutType'],
      usageCount: json['usageCount'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      userId: json['userId'],
      categoryId: json['categoryId'],
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
      exercises: json['exercises'] ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'difficulty': difficulty,
        'duration': duration,
        'description': description,
        'status': status,
        'coverImage': coverImage,
        'workoutType': workoutType,
        'usageCount': usageCount,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'userId': userId,
        'categoryId': categoryId,
        'category': category?.toJson(),
        'exercises': exercises,
      };
}

class Category {
  final String? id;
  final String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
