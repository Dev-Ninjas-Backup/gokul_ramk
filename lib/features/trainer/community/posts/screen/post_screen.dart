import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/trainer/community/posts/controller/trainer_community_controller.dart';
import 'package:gokul_ramk/features/trainer/community/posts/create_post/screen/trainer_create_post_screen.dart';
import 'package:gokul_ramk/features/trainer/community/posts/widget/post_card_widget.dart';

class PostScreen extends StatelessWidget {
  PostScreen({super.key});
  final CommunityController controller = Get.put(
    CommunityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return CustomScrollView(
          slivers: [
            // --- Sliver for Header ---
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(
                        "https://randomuser.me/api/portraits/men/89.jpg",
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.to(TrainerCreatePostScreen()),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Share your progress, ask questions, or motivate others!',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- Sliver for Posts ---
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return PostCardWidget(post: controller.posts[index]);
              }, childCount: controller.posts.length),
            ),
          ],
        );
      }),
    );
  }
}
