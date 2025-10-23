import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/features/user/user_community/community_posts/create_post/controller/user_create_post_controller.dart';
import 'package:gokul_ramk/features/user/user_community/community_posts/create_post/widget/post_content_text_field.dart';

class CreatePostScreen extends StatelessWidget {
  final UserCreatePostController controller = Get.put(
    UserCreatePostController());

  CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomAppBarTitle(title: 'Create Post'),
            // Title Field
            PostContentTextField(
              hint: "Enter Post Title",
              onChanged: (val) => controller.titleController.value = val,
            ),
            const SizedBox(height: 12),

            // Content Field
            PostContentTextField(
              hint: "Write your content here...",
              onChanged: (val) => controller.contentController.value = val,
              maxLines: 5,
            ),
            const SizedBox(height: 12),

            // Image Picker
            Obx(() {
              final image = controller.pickedImage.value;
              return Column(
                children: [
                  if (image != null)
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            image,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: CircleAvatar(
                            backgroundColor: Colors.black54,
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: controller.removeImage,
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    GestureDetector(
                      onTap: controller.pickImage,
                      child: DottedBorderContainer(),
                    ),
                ],
              );
            }),
            const SizedBox(height: 20),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.submitPost,
                icon: const Icon(Icons.send),
                label: const Text("Post"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Simple reusable dotted border for image picker
class DottedBorderContainer extends StatelessWidget {
  const DottedBorderContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          style: BorderStyle.solid,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_outlined, size: 40, color: Colors.grey),
          SizedBox(height: 8),
          Text("Tap to add image", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
