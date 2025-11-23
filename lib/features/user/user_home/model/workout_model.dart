import 'user_home_model.dart';

class WorkoutModel {
  bool? success;
  String? message;
  WorkoutData? data;

  WorkoutModel({this.success, this.message, this.data});

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? WorkoutData.fromJson(json['data']) : null,
    );
  }
}

class WorkoutData {
  List<WorkOutModel>? data;
  int? totalCount;
  int? page;
  int? pageSize;
  int? totalPages;

  WorkoutData({
    this.data,
    this.totalCount,
    this.page,
    this.pageSize,
    this.totalPages,
  });

  factory WorkoutData.fromJson(Map<String, dynamic> json) {
    return WorkoutData(
      data: json['data'] != null
          ? (json['data'] as List).map((e) => WorkOutModel.fromJson(e)).toList()
          : null,
      totalCount: json['totalCount'],
      page: json['page'],
      pageSize: json['pageSize'],
      totalPages: json['totalPages'],
    );
  }
}

class WorkOutModel {
  String? id;
  String? name;
  String? difficulty;
  int? duration;
  String? description;
  String? status;
  String? coverImage;
  String? workoutType;
  int? usageCount;
  String? createdAt;
  String? updatedAt;
  String? userId;
  String? categoryId;
  CategoryModelWorkOut? category;
  List<dynamic>? exercises;

  WorkOutModel({
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

  factory WorkOutModel.fromJson(Map<String, dynamic> json) {
    return WorkOutModel(
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
      category: json['category'] != null
          ? CategoryModelWorkOut.fromJson(json['category'])
          : null,
      exercises: json['exercises'] ?? [],
    );
  }
}
