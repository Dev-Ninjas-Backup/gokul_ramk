class ProgramsResponse {
  String? status;
  String? message;
  ProgramsData? data;
  int? statusCode;

  ProgramsResponse({
    this.status,
    this.message,
    this.data,
    this.statusCode,
  });

  factory ProgramsResponse.fromJson(Map<String, dynamic> json) {
    return ProgramsResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? ProgramsData.fromJson(json['data'])
          : null,
      statusCode: json['statusCode'],
    );
  }
}
class ProgramsData {
  List<Program1>? data;
  Meta? meta;

  ProgramsData({
    this.data,
    this.meta,
  });

  factory ProgramsData.fromJson(Map<String, dynamic> json) {
    return ProgramsData(
      data: (json['data'] as List?)
          ?.map((e) => Program1.fromJson(e))
          .toList(),
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }
}

class Program1 {
  String? id;
  String? trainerId;
  String? name;
  String? description;
  String? difficulty;
  String? thumbnailUrl;
  String? videoUrl;
  String? price;
  String? currency;
  bool? isActive;
  int? maxParticipants;
  String? createdAt;
  String? updatedAt;
  Trainer? trainer;
  List<Session>? sessions;

  Program1({
    this.id,
    this.trainerId,
    this.name,
    this.description,
    this.difficulty,
    this.thumbnailUrl,
    this.videoUrl,
    this.price,
    this.currency,
    this.isActive,
    this.maxParticipants,
    this.createdAt,
    this.updatedAt,
    this.trainer,
    this.sessions,
  });

  factory Program1.fromJson(Map<String, dynamic> json) {
    return Program1(
      id: json['id'],
      trainerId: json['trainerId'],
      name: json['name'],
      description: json['description'],
      difficulty: json['difficulty'],
      thumbnailUrl: json['thumbnailUrl'],
      videoUrl: json['videoUrl'],
      price: json['price']?.toString(),
      currency: json['currency'],
      isActive: json['isActive'],
      maxParticipants: json['maxParticipants'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      trainer:
          json['trainer'] != null ? Trainer.fromJson(json['trainer']) : null,
      sessions: (json['sessions'] as List?)
          ?.map((e) => Session.fromJson(e))
          .toList(),
    );
  }
}
class Trainer {
  String? id;
  String? fullname;
  String? email;

  Trainer({
    this.id,
    this.fullname,
    this.email,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
    );
  }
}
class Session {
  String? id;
  String? programId;
  String? packageId;
  String? trainerId;
  String? categoryId;
  String? title;
  String? description;
  int? order;
  String? startDate;
  String? endDate;
  int? duration;
  double? price;
  String? sessionLocation;
  String? sessionType;
  String? createdAt;
  String? updatedAt;

  Session({
    this.id,
    this.programId,
    this.packageId,
    this.trainerId,
    this.categoryId,
    this.title,
    this.description,
    this.order,
    this.startDate,
    this.endDate,
    this.duration,
    this.price,
    this.sessionLocation,
    this.sessionType,
    this.createdAt,
    this.updatedAt,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      programId: json['programId'],
      packageId: json['packageId'],
      trainerId: json['trainerId'],
      categoryId: json['categoryId'],
      title: json['title'],
      description: json['description'],
      order: json['order'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      duration: json['duration'],
      price: json['price'] != null
          ? double.tryParse(json['price'].toString())
          : null,
      sessionLocation: json['sessionLocation'],
      sessionType: json['sessionType'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
class Meta {
  int? total;
  int? page;
  int? limit;
  int? totalPages;

  Meta({
    this.total,
    this.page,
    this.limit,
    this.totalPages,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
    );
  }
}
