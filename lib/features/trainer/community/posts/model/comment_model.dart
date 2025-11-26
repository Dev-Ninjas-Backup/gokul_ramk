class CommentModel {
  final String id;
  final String content;
  final String? replyId;
  final String userId;
  final String postId;
  final String createdAt;
  final CommentUser? user;
  final List<CommentModel> otherComments;

  CommentModel({
    required this.id,
    required this.content,
    this.replyId,
    required this.userId,
    required this.postId,
    required this.createdAt,
    this.user,
    required this.otherComments,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    final userData = json['user'];
    final user = userData is Map<String, dynamic>
        ? CommentUser.fromJson(userData)
        : null;

    final otherCommentsRaw = json['other_Comment'];
    final otherComments = <CommentModel>[];
    if (otherCommentsRaw is List) {
      for (final entry in otherCommentsRaw) {
        if (entry is Map<String, dynamic>) {
          otherComments.add(CommentModel.fromJson(entry));
        }
      }
    }

    return CommentModel(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      replyId: json['replyId'],
      userId: json['userId'] ?? '',
      postId: json['postId'] ?? '',
      createdAt: json['createdAt'] ?? '',
      user: user,
      otherComments: otherComments,
    );
  }
}

class CommentUser {
  final String id;
  final String fullname;
  final String email;
  final String? images;

  CommentUser({
    required this.id,
    required this.fullname,
    required this.email,
    this.images,
  });

  factory CommentUser.fromJson(Map<String, dynamic> json) {
    return CommentUser(
      id: json['id'] ?? '',
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      images: json['images'],
    );
  }
}
