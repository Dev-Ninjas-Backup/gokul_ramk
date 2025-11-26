// class PostModel {
//   final String name;
//   final String username;
//   final String role;
//   final String imageUrl;
//   final int likes;
//   final int comments;
//   final String caption;
//   final String timeAgo;

//   PostModel({
//     required this.name,
//     required this.username,
//     required this.role,
//     required this.imageUrl,
//     required this.likes,
//     required this.comments,
//     required this.caption,
//     required this.timeAgo,
//   });
// }




class PostResponseModel {
  final bool success;
  final String message;
  final List<PostModel> data;
  final MetaModel meta;

  PostResponseModel({
    required this.success,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory PostResponseModel.fromJson(Map<String, dynamic> json) {
    return PostResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List? ?? [])
          .map((e) => PostModel.fromJson(e))
          .toList(),
      meta: MetaModel.fromJson(json['meta'] ?? {}),
    );
  }
}

class MetaModel {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  MetaModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 10,
      total: json['total'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
    );
  }
}

class PostModel {
  final String id;
  final String title;
  final String content;
  final String? image;
  final String userId;
  final String? groupId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserModel? user;
  final GroupModel? group;
  final CountModel count;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.userId,
    required this.groupId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.group,
    required this.count,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      image: json['image'],
      userId: json['userId'] ?? '',
      groupId: json['groupId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      group: json['group'] != null ? GroupModel.fromJson(json['group']) : null,
      count: CountModel.fromJson(json['_count'] ?? {}),
    );
  }
}

class UserModel {
  final String id;
  final String fullname;
  final String email;
  final String? images;

  UserModel({
    required this.id,
    required this.fullname,
    required this.email,
    required this.images,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      images: json['images'],
    );
  }
}

class GroupModel {
  final String id;
  final String name;

  GroupModel({
    required this.id,
    required this.name,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class CountModel {
  final int likes;
  final int comments;

  CountModel({
    required this.likes,
    required this.comments,
  });

  factory CountModel.fromJson(Map<String, dynamic> json) {
    return CountModel(
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
    );
  }
}
