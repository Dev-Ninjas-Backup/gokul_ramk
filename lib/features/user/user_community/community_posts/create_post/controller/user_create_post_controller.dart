import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserCreatePostController extends GetxController {
  final titleController = ''.obs;
  final contentController = ''.obs;
  final pickedImage = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage.value = File(image.path);
    }
  }

  void removeImage() {
    pickedImage.value = null;
  }

  void submitPost() {
    if (titleController.value.isEmpty || contentController.value.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    // For now just print — integrate with backend later
    if (kDebugMode) {
      print("Title: ${titleController.value}");
      print("Content: ${contentController.value}");
      print("Image: ${pickedImage.value?.path}");
    }
    

    Get.snackbar("Success", "Post Created Successfully");
  }
}
