// ignore_for_file: avoid_print

class PostModel {
  final String id;
  final String title;
  final String content;
  final String image;
  final String userId;
  final String? groupId;
  final String createdAt;
  final String updatedAt;
  final UserInfo user;
  final int likes;
  final int comments;
  final bool liked;
  final String? likeId;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.userId,
    this.groupId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.likes,
    required this.comments,
    this.liked = false,
    this.likeId,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final userData = json['user'];
    late final UserInfo user;

    if (userData is Map<String, dynamic>) {
      user = UserInfo.fromJson(userData);
    } else {
      user = UserInfo(
        id: '',
        fullname: 'Unknown User',
        email: '',
        images: null,
      );
    }

    String imageUrl = json['image'] ?? '';
    if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
      if (imageUrl.startsWith('localhost')) {
        imageUrl = imageUrl.replaceFirst(
          RegExp(r'^localhost:5000/?'),
          'https://wellfitsync.com/',
        );
        if (imageUrl.startsWith('https://wellfitsync.com//')) {
          imageUrl = imageUrl.replaceFirst(
            'https://wellfitsync.com//',
            'https://wellfitsync.com/',
          );
        }
      }
    }

    print('Post image URL normalized to: $imageUrl');

    return PostModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      image: imageUrl,
      userId: json['userId'] ?? '',
      groupId: json['groupId'],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      user: user,
      likes: json['_count']?['likes'] ?? 0,
      comments: json['_count']?['comments'] ?? 0,
      liked: json['liked'] ?? false,
      likeId: json['likeId'],
    );
  }

  PostModel copyWith({
    String? id,
    String? title,
    String? content,
    String? image,
    String? userId,
    String? groupId,
    String? createdAt,
    String? updatedAt,
    UserInfo? user,
    int? likes,
    int? comments,
    bool? liked,
    String? likeId,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
      userId: userId ?? this.userId,
      groupId: groupId ?? this.groupId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      user: user ?? this.user,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      liked: liked ?? this.liked,
      likeId: likeId ?? this.likeId,
    );
  }
}

class UserInfo {
  final String id;
  final String fullname;
  final String email;
  final String? images;

  UserInfo({
    required this.id,
    required this.fullname,
    required this.email,
    this.images,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      images: json['images'],
    );
  }
}
