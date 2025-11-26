class GroupApiResponse {
  final bool success;
  final String message;
  final GroupData data;

  GroupApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GroupApiResponse.fromJson(Map<String, dynamic> json) {
    return GroupApiResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: GroupData.fromJson(json['data'] ?? {}),
    );
  }
}

class GroupData {
  final String id;
  final String name;
  final String description;
  final String thumbnail;
  final String createdBy;
  final String createdAt;
  final String updatedAt;
  final Creator creator;

  GroupData({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.creator,
  });

  factory GroupData.fromJson(Map<String, dynamic> json) {
    return GroupData(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      createdBy: json['createdBy'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      creator: Creator.fromJson(json['creator'] ?? {}),
    );
  }
}

class Creator {
  final String id;
  final String fullname;
  final String email;
  final String? phone;

  Creator({
    required this.id,
    required this.fullname,
    required this.email,
    this.phone,
  });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json['id'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
    );
  }
}
