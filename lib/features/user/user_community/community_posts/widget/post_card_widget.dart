import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';
import 'package:gokul_ramk/features/user/user_community/community_posts/controller/user_community_controller.dart';

class PostCardWidget extends StatelessWidget {
  // final PostModel post;
  final UserCommunityController controller;
  final int index;

  const PostCardWidget({
    super.key,
    required this.controller,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final user = controller.posts[index].user!;
    final post = controller.posts[index];

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: 
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              user.images.toString(),
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.person);
              },
              fit: BoxFit.cover,
            ),
          ),
            title: Text(
              user.fullname.toString(),
              style: getTextStyle(fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("${post.username} | ${post.role}"),
            trailing: Icon(Icons.more_vert),
          ),

          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              post.image.toString(),
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Icon(Icons.broken_image));
              },
              fit: BoxFit.cover,
            ),
          ),

          // --- Like & Comment Row ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Image.asset(IconPath.favoriteIcon),
                SizedBox(width: 4),
                Text("${post.count.likes}"),
                SizedBox(width: 16),
                Image.asset(IconPath.commentIcon),
                SizedBox(width: 4),
                Text("${post.count.comments}"),
              ],
            ),
          ),

          // --- Caption ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black),
                children: [
                  // TextSpan(
                  //   text: "${post.username} ",
                  //   style: TextStyle(fontWeight: FontWeight.bold),
                  // ),
                  TextSpan(text: post.content),
                ],
              ),
            ),
          ),

          // --- Comment Input ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              user.images.toString(),
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.person);
              },
              fit: BoxFit.cover,
            ),
          ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Add a comment...",
                      contentPadding: EdgeInsets.all(12),
                      fillColor: Colors.grey.withValues(alpha: 0.06),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // --- Time Ago ---
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 10),
            child: Text(
              post.createdAt.toString(),
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          Divider(thickness: 4, color: Colors.grey.shade100),
        ],
      ),
    );
  }
}
