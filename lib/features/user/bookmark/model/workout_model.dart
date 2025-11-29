class WorkoutModel {
  final String id;
  final String name;
  final String difficulty;
  final int duration;
  final String description;
  final String status;
  final String coverImage;
  final String workoutType;
  final int usageCount;
  final String createdAt;
  final String updatedAt;
  final String userId;
  final String categoryId;
  final CategoryModel? category;
  final UserModel? user;
  final List<dynamic> exercises;

  WorkoutModel({
    required this.id,
    required this.name,
    required this.difficulty,
    required this.duration,
    required this.description,
    required this.status,
    required this.coverImage,
    required this.workoutType,
    required this.usageCount,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.categoryId,
    this.category,
    this.user,
    required this.exercises,
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      id: json['id'] as String,
      name: json['name'] as String,
      difficulty: json['difficulty'] as String,
      duration: json['duration'] as int,
      description: json['description'] as String,
      status: json['status'] as String,
      coverImage: json['coverImage'] as String,
      workoutType: json['workoutType'] as String,
      usageCount: json['usageCount'] as int,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      userId: json['userId'] as String,
      categoryId: json['categoryId'] as String,
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      exercises: json['exercises'] as List<dynamic>? ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'user': user?.toJson(),
      'exercises': exercises,
    };
  }
}

class CategoryModel {
  final String id;
  final String name;
  final String type;
  final String color;
  final String desc;
  final String createdAt;
  final String updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.type,
    required this.color,
    required this.desc,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      color: json['color'] as String,
      desc: json['desc'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'color': color,
      'desc': desc,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class UserModel {
  final String id;
  final String fullname;
  final String email;
  final String phone;
  final String? images;

  UserModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.phone,
    this.images,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullname: json['fullname'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      images: json['images'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'images': images,
    };
  }
}
