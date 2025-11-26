import 'package:flutter/material.dart';
import 'package:gokul_ramk/features/trainer/community/posts/model/comment_model.dart';

class CommentWidget extends StatelessWidget {
  final CommentModel comment;
  const CommentWidget({super.key, required this.comment});

  String _timeAgo(String dateString) {
    try {
      final postDate = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(postDate);

      if (difference.inSeconds < 60) {
        return '${difference.inSeconds}s ago';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes}m ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours}h ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}d ago';
      } else {
        return postDate.toString().split(' ')[0];
      }
    } catch (e) {
      return 'recently';
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = comment.user;
    final avatar = user?.images;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.grey[300],
            backgroundImage: avatar != null && avatar.isNotEmpty
                ? NetworkImage(avatar)
                : null,
            child: avatar == null || avatar.isEmpty
                ? Icon(Icons.person, size: 16)
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.fullname ?? 'Unknown',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(comment.content),
                const SizedBox(height: 4),
                Text(
                  _timeAgo(comment.createdAt),
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
