class PackagesResponse {
  bool? success;
  String? message;
  List<PackageData>? data;
  Metadata? metadata;

  PackagesResponse({
    this.success,
    this.message,
    this.data,
    this.metadata,
  });

  factory PackagesResponse.fromJson(Map<String, dynamic> json) {
    return PackagesResponse(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List?)
          ?.map((e) => PackageData.fromJson(e))
          .toList(),
      metadata:
          json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null,
    );
  }
}
class PackageData {
  String? id;
  String? name;
  String? description;
  num? price;
  num? discount;
  String? expiresInDate;
  bool? isActive;
  bool? isPublic;
  String? ownerId;
  int? purchaseCount;
  String? createdAt;
  String? updatedAt;
  Owner? owner;
  List<Session>? sessions;

  PackageData({
    this.id,
    this.name,
    this.description,
    this.price,
    this.discount,
    this.expiresInDate,
    this.isActive,
    this.isPublic,
    this.ownerId,
    this.purchaseCount,
    this.createdAt,
    this.updatedAt,
    this.owner,
    this.sessions,
  });

  factory PackageData.fromJson(Map<String, dynamic> json) {
    return PackageData(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      discount: json['discount'],
      expiresInDate: json['expiresInDate'],
      isActive: json['isActive'],
      isPublic: json['isPublic'],
      ownerId: json['ownerId'],
      purchaseCount: json['purchaseCount'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      owner: json['owner'] != null ? Owner.fromJson(json['owner']) : null,
      sessions: (json['sessions'] as List?)
          ?.map((e) => Session.fromJson(e))
          .toList(),
    );
  }
}
class Owner {
  String? id;
  String? fullname;
  String? email;

  Owner({
    this.id,
    this.fullname,
    this.email,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
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
  num? price;
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
      price: json['price'],
      sessionLocation: json['sessionLocation'],
      sessionType: json['sessionType'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
class Metadata {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Metadata({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      totalPage: json['totalPage'],
    );
  }
}
