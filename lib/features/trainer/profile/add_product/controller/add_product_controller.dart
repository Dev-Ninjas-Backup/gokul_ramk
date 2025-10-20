import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController {
  // var images = <String>[].obs;

  var categories = ["Nutrition", "Fitness", "Supplements", "Accessories"].obs;
  var selectedCategory = "Nutrition".obs;

  var deliveryOptions = [
    "Both Shipping & Pickup",
    "Shipping Only",
    "Pickup Only",
  ].obs;
  var selectedDelivery = "Both Shipping & Pickup".obs;

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final descriptionController = TextEditingController();

  // void addImage() {
  //   // for demo, just add sample image
  //   images.add("assets/images/productSample.png");
  // }

  final ImagePicker _picker = ImagePicker();
  var selectedImages = <File>[].obs;
  var index=0.obs;
  

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        selectedImages.add(File(image.path));
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }
 
}
