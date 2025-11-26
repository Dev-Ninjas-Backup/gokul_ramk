import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/community/groups/model/groups_model.dart';
import 'package:gokul_ramk/features/trainer/community/groups/repository/group_repository.dart';
import 'package:gokul_ramk/features/trainer/community/groups/repository/trainer_service.dart';

class GroupsController extends GetxController {
  late GroupRepository groupRepository;
  late TrainerService trainerService;
  final ImagePicker _imagePicker = ImagePicker();

  // Group creation
  var isCreatingGroup = false.obs;
  var selectedImage = Rxn<File>();
  var selectedImageName = ''.obs;

  // Group listing
  var groups = <GroupModel>[].obs;
  var isLoadingGroups = false.obs;
  var currentPage = 1;
  var groupsPerPage = 10;
  var hasMoreGroups = true.obs;
  var joiningGroupId = ''.obs;
  var currentUserId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final networkClient = Get.find<NetworkClient>();
    groupRepository = GroupRepository(networkClient: networkClient);
    trainerService = TrainerService(networkClient: networkClient);

    // Fetch current user ID first
    _initializeCurrentUser();
  }

  Future<void> _initializeCurrentUser() async {
    try {
      final trainer = await trainerService.getCurrentTrainer();
      if (trainer != null) {
        currentUserId.value = trainer.id;
        // Set the current user ID in the GroupModel
        GroupModel.setCurrentUserId(trainer.id);
        print('Current user ID set: ${trainer.id}');
        // Now load groups
        await loadMoreGroups();
      }
    } catch (e) {
      print('Error initializing current user: $e');
      // Still load groups even if we can't get user ID
      await loadMoreGroups();
    }
  }

  // Load groups with pagination
  Future<void> loadMoreGroups() async {
    if (isLoadingGroups.value || !hasMoreGroups.value) return;

    isLoadingGroups.value = true;
    try {
      final newGroups = await groupRepository.getGroups(
        page: currentPage,
        limit: groupsPerPage,
        sortBy: 'createdAt',
      );

      if (newGroups.isEmpty) {
        hasMoreGroups.value = false;
      } else {
        groups.addAll(newGroups);
        currentPage++;
      }
    } catch (e) {
      print('Error loading groups: $e');
      hasMoreGroups.value = false;
    } finally {
      isLoadingGroups.value = false;
    }
  }

  // Refresh groups (clear and reload from page 1)
  Future<void> refreshGroups() async {
    groups.clear();
    currentPage = 1;
    hasMoreGroups.value = true;
    await loadMoreGroups();
  }

  // Join group
  Future<void> joinGroup(String groupId, int index) async {
    joiningGroupId.value = groupId;
    try {
      final updatedGroup = await groupRepository.joinGroup(groupId);
      if (updatedGroup != null) {
        // Update the group in the list
        groups[index] = updatedGroup;
        Get.snackbar('Success', 'Joined group successfully');
      } else {
        Get.snackbar('Error', 'Failed to join group');
      }
    } catch (e) {
      print('Error joining group: $e');
      Get.snackbar('Error', 'Failed to join group');
    } finally {
      joiningGroupId.value = '';
    }
  }

  // Leave group
  Future<void> leaveGroup(String groupId, int index) async {
    joiningGroupId.value = groupId;
    try {
      final success = await groupRepository.leaveGroup(groupId);
      if (success) {
        // Update the group in the list by reloading it
        final updatedGroups = await groupRepository.getGroups(
          page: 1,
          limit: (index + 1) * 2,
        );
        if (updatedGroups.isNotEmpty && updatedGroups.length > index) {
          groups[index] = updatedGroups[index];
        }
        Get.snackbar('Success', 'Left group successfully');
      } else {
        Get.snackbar('Error', 'Failed to leave group');
      }
    } catch (e) {
      print('Error leaving group: $e');
      Get.snackbar('Error', 'Failed to leave group');
    } finally {
      joiningGroupId.value = '';
    }
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
        // Refresh groups list
        await refreshGroups();
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
                child: Icon(Icons.check_circle, size: 50, color: Colors.green),
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
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
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
