// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';
import 'package:gokul_ramk/features/trainer/community/posts/model/comment_model.dart';
import 'package:gokul_ramk/features/trainer/community/posts/model/posts_model.dart';
import 'package:gokul_ramk/features/trainer/community/posts/repository/comment_repository.dart';
import 'package:gokul_ramk/features/trainer/community/posts/repository/post_repository.dart';
import 'package:gokul_ramk/features/trainer/community/posts/widget/comment_widget.dart';

class PostCardWidget extends StatefulWidget {
  final PostModel post;
  const PostCardWidget({super.key, required this.post});

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {
  late CommentRepository commentRepository;
  late PostRepository postRepository;
  final TextEditingController _commentController = TextEditingController();
  var allComments = <CommentModel>[].obs;
  var displayedComments = <CommentModel>[].obs;
  var isLoadingComments = false.obs;
  var showComments = false.obs;
  var commentCount = 0.obs;
  var commentsPerPage = 5;
  var currentPage = 1;

  late var isLiked = false.obs;
  late var likeCount = 0.obs;
  var isLiking = false.obs;

  @override
  void initState() {
    super.initState();
    final networkClient = Get.find<NetworkClient>();
    commentRepository = CommentRepository(networkClient: networkClient);
    postRepository = PostRepository(networkClient: networkClient);
    commentCount.value = widget.post.comments;

    // Initialize like state from post
    isLiked.value = widget.post.liked;
    likeCount.value = widget.post.likes;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  String _getTimeAgo(String dateString) {
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

  Future<void> _toggleLike() async {
    if (isLiking.value) return; // Prevent multiple simultaneous requests

    isLiking.value = true;
    try {
      final (liked, likeId, _) = await postRepository.toggleLike(
        widget.post.id,
      );

      // Update UI based on response
      isLiked.value = liked;
      if (liked) {
        likeCount.value += 1;
      } else {
        likeCount.value -= 1;
      }

      print('Like toggled: liked=$liked, likeId=$likeId');
    } catch (e) {
      print('Error toggling like: $e');
      Get.snackbar('Error', 'Failed to toggle like');
    } finally {
      isLiking.value = false;
    }
  }

  Future<void> _loadComments() async {
    isLoadingComments.value = true;
    try {
      final loadedComments = await commentRepository.getPostComments(
        postId: widget.post.id,
      );
      print(
        'Loaded ${loadedComments.length} comments for post ${widget.post.id}',
      );
      for (int i = 0; i < loadedComments.length; i++) {
        print(
          'Comment $i: ID=${loadedComments[i].id}, Content=${loadedComments[i].content}',
        );
      }
      allComments.value = loadedComments;
      commentCount.value = loadedComments.length;
      currentPage = 1;
      _updateDisplayedComments();
    } catch (e) {
      print('Error loading comments: $e');
    } finally {
      isLoadingComments.value = false;
    }
  }

  void _updateDisplayedComments() {
    final startIndex = 0;
    final endIndex = currentPage * commentsPerPage;
    if (endIndex <= allComments.length) {
      displayedComments.value = allComments.sublist(startIndex, endIndex);
    } else {
      displayedComments.value = allComments;
    }
  }

  void _loadMoreComments() {
    currentPage++;
    _updateDisplayedComments();
  }

  bool _hasMoreComments() {
    return (currentPage * commentsPerPage) < allComments.length;
  }

  Future<void> _submitComment() async {
    if (_commentController.text.isEmpty) return;

    final commentContent = _commentController.text;
    _commentController.clear();

    try {
      final newComment = await commentRepository.addComment(
        postId: widget.post.id,
        content: commentContent,
      );
      if (newComment != null) {
        // Reload all comments to ensure we have the complete list
        await _loadComments();
        showComments.value = true;
        Get.snackbar('Success', 'Comment added successfully');
      } else {
        Get.snackbar('Error', 'Failed to add comment');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add comment');
      print('Error adding comment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              backgroundImage:
                  widget.post.user.images != null &&
                      widget.post.user.images!.isNotEmpty
                  ? NetworkImage(widget.post.user.images!)
                  : null,
              child:
                  widget.post.user.images == null ||
                      widget.post.user.images!.isEmpty
                  ? Icon(Icons.person)
                  : null,
            ),
            title: Text(
              widget.post.user.fullname,
              style: getTextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.post.user.email),
            trailing: Icon(Icons.more_vert),
          ),

          // Post Image
          if (widget.post.image.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.post.image,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 300,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Center(child: Icon(Icons.image_not_supported)),
                  );
                },
              ),
            ),

          // --- Like & Comment Row ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Obx(
                  () => GestureDetector(
                    onTap: _toggleLike,
                    child: isLiked.value
                        ? Image.asset(IconPath.favoriteIcon, color: Colors.red)
                        : Image.asset(IconPath.favoriteIcon),
                  ),
                ),
                SizedBox(width: 4),
                Obx(() => Text("${likeCount.value}")),
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    showComments.value = !showComments.value;
                    if (showComments.value && displayedComments.isEmpty) {
                      _loadComments();
                    }
                  },
                  child: Row(
                    children: [
                      Image.asset(IconPath.commentIcon),
                      SizedBox(width: 4),
                      Obx(() => Text("${commentCount.value}")),
                    ],
                  ),
                ),
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
                  TextSpan(
                    text: "${widget.post.user.fullname} ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: widget.post.content),
                ],
              ),
            ),
          ),

          // --- Time Ago ---
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 10),
            child: Text(
              _getTimeAgo(widget.post.createdAt),
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),

          // --- Comments Section ---
          Obx(() {
            if (showComments.value) {
              return Column(
                children: [
                  Divider(thickness: 1, color: Colors.grey.shade200),
                  if (isLoadingComments.value)
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    )
                  else if (displayedComments.isEmpty)
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No comments yet'),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          ...displayedComments.map(
                            (comment) => CommentWidget(comment: comment),
                          ),
                          if (_hasMoreComments())
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: GestureDetector(
                                onTap: _loadMoreComments,
                                child: Text(
                                  'Load More Comments',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  Divider(thickness: 1, color: Colors.grey.shade200),
                ],
              );
            }
            return SizedBox.shrink();
          }),

          // --- Comment Input ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/89.jpg",
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: "Add a comment...",
                      contentPadding: EdgeInsets.all(12),
                      fillColor: Colors.grey.withValues(alpha: 0.06),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: _submitComment,
                      ),
                    ),
                    onSubmitted: (_) => _submitComment(),
                  ),
                ),
              ],
            ),
          ),

          Divider(thickness: 4, color: Colors.grey.shade100),
        ],
      ),
    );
  }
}
