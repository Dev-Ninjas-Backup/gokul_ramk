// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/community/posts/service/post_service.dart';
import 'package:gokul_ramk/features/trainer/community/posts/controller/trainer_community_controller.dart';
import 'package:image_picker/image_picker.dart';

class TrainerCreatePostController extends GetxController {
  final titleController = ''.obs;
  final contentController = ''.obs;
  final pickedImage = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  /// Pick an image from the gallery
  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        pickedImage.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
    }
  }

  /// Remove selected image
  void removeImage() {
    pickedImage.value = null;
  }

  /// Submit post to API
  Future<void> submitPost() async {
    // Validate inputs
    if (titleController.value.isEmpty || contentController.value.isEmpty) {
      EasyLoading.showError("Please fill all fields");
      return;
    }
    if (pickedImage.value == null) {
      EasyLoading.showError("Please select an image");
      return;
    }

    try {
      EasyLoading.show(status: "Uploading...");

      // Call API to create post (multipart)
      final NetworkResponse response = await createPost(
        title: titleController.value,
        content: contentController.value,
        imageFile: pickedImage.value!,
      );

      if (response.isSuccess &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        EasyLoading.showSuccess("Post created successfully!");
        // Clear form
        titleController.value = '';
        contentController.value = '';
        pickedImage.value = null;

        // Refresh the posts list
        try {
          final communityController = Get.find<CommunityController>();
          await communityController.refreshPosts();
        } catch (e) {
          print('Error refreshing posts: $e');
        }
      } else {
        EasyLoading.showError(
          "Failed to create post: ${response.responseData?['message'] ?? 'Unknown error'}",
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("Error, Error creating post: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
