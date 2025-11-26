import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/community/groups/repository/group_repository.dart';

class GroupsController extends GetxController {
  late GroupRepository groupRepository;
  final ImagePicker _imagePicker = ImagePicker();

  var isCreatingGroup = false.obs;
  var selectedImage = Rxn<File>();
  var selectedImageName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final networkClient = Get.find<NetworkClient>();
    groupRepository = GroupRepository(networkClient: networkClient);
  }

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        selectedImageName.value = pickedFile.name;
        print('Image selected: ${pickedFile.path}');
      }
    } catch (e) {
      print('Error picking image: $e');
      Get.snackbar('Error', 'Failed to pick image');
    }
  }

  Future<void> createGroup({
    required String name,
    required String description,
  }) async {
    if (name.isEmpty || description.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    isCreatingGroup.value = true;
    try {
      final response = await groupRepository.createGroup(
        name: name,
        description: description,
        thumbnailFile: selectedImage.value,
      );

      if (response != null && response.success) {
        // Show success dialog
        _showSuccessDialog(response.data);
        // Clear form
        selectedImage.value = null;
        selectedImageName.value = '';
      } else {
        Get.snackbar('Error', response?.message ?? 'Failed to create group');
      }
    } catch (e) {
      print('Error creating group: $e');
      Get.snackbar('Error', 'Failed to create group: $e');
    } finally {
      isCreatingGroup.value = false;
    }
  }

  void _showSuccessDialog(dynamic groupData) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green[100],
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 50,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Group Created Successfully!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Your group has been created and is ready to use.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF148CBB),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Get.back(); // Close dialog
                    Get.back(); // Go back to previous screen
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void clearImage() {
    selectedImage.value = null;
    selectedImageName.value = '';
  }
}
