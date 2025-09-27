class PostModel {
  final String name;
  final String username;
  final String role;
  final String imageUrl;
  final int likes;
  final int comments;
  final String caption;
  final String timeAgo;

  PostModel({
    required this.name,
    required this.username,
    required this.role,
    required this.imageUrl,
    required this.likes,
    required this.comments,
    required this.caption,
    required this.timeAgo,
  });
}
