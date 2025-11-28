// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gokul_ramk/core/models/enums/user_role.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/community/events/model/event_model.dart';
import 'package:gokul_ramk/features/trainer/community/challenges/repository/challenge_repository.dart';

class ChallengesController extends GetxController {
  late ChallengeRepository challengeRepository;
  final ImagePicker _imagePicker = ImagePicker();

  // Track user role
  var userRole = Rxn<UserRole>();

  var events = <Map<String, dynamic>>[].obs;
  var challengeModels = <EventModel>[].obs;
  var options = ['ONLINE', 'ONSITE'].obs;
  var categoryOptions = [
    'STEPS',
    'WORKOUT',
    'NUTRITION',
    'MEDITATION',
    'CUSTOM',
  ].obs;
  var statusOptions = [
    'DRAFT',
    'UPCOMING',
    'ACTIVE',
    'COMPLETED',
    'CANCELLED',
    'ENDED',
  ].obs;

  // Form fields
  var challengeTitle = TextEditingController();
  var challengeDescription = TextEditingController();
  var challengeLocation = TextEditingController();
  var challengeCategory = TextEditingController();
  var targetValue = TextEditingController();
  var targetUnit = TextEditingController();

  // Observables for form
  var selectedFormat = RxnString();
  var selectedStatus = RxnString();
  var selectedCategory = RxnString();
  var selectedImage = Rxn<File>();
  var selectedImageName = ''.obs;
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();
  var isCreatingChallenge = false.obs;

  // Pagination
  var currentPage = 1.obs;
  var pageLimit = 10.obs;
  var isLoadingChallenges = false.obs;

  @override
  void onInit() {
    super.onInit();
    final networkClient = Get.find<NetworkClient>();
    challengeRepository = ChallengeRepository(networkClient: networkClient);
    selectedFormat.value = 'ONLINE'; // Default format
    selectedStatus.value = 'DRAFT'; // Default status
    selectedCategory.value = 'WORKOUT'; // Default category
    // Set user role from arguments if passed, default to trainer
    userRole.value = Get.arguments ?? UserRole.trainer;
    fetchChallenges();
  }

  Future<void> fetchChallenges({int page = 1, int limit = 10}) async {
    if (isLoadingChallenges.value) return;

    try {
      isLoadingChallenges.value = true;
      final fetchedChallenges = await challengeRepository.getChallenges(
        page: page,
        limit: limit,
      );
      challengeModels.value = fetchedChallenges;
      currentPage.value = page;
      print('Fetched ${fetchedChallenges.length} challenges');
    } catch (e) {
      print('Error fetching challenges: $e');
      Get.snackbar('Error', 'Failed to load challenges');
    } finally {
      isLoadingChallenges.value = false;
    }
  }

  void loadEvents() {
    events.value = [
      {"title": "10K Steps Daily for 30 Days"},
      {"title": "No Sugar Challenge for 7 Days"},
      {"title": "Plank 30 days for 2 Minutes"},
    ];
  }

  Future<void> pickCoverImage() async {
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

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      // Set time to 9:00 AM by default
      startDate.value = DateTime(picked.year, picked.month, picked.day, 9, 0);
      print('Start date set to: ${startDate.value}');

      // Auto-set end date to next day at 5:00 PM if not already set
      if (endDate.value == null) {
        endDate.value = DateTime(
          picked.year,
          picked.month,
          picked.day + 1,
          17,
          0,
        );
        print('End date auto-set to: ${endDate.value}');
      }
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate.value ?? (startDate.value ?? DateTime.now()),
      firstDate: startDate.value ?? DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      // Ensure end time is after start date
      if (startDate.value != null &&
          picked.year == startDate.value!.year &&
          picked.month == startDate.value!.month &&
          picked.day == startDate.value!.day) {
        // If same day, set end time to 5:00 PM
        endDate.value = DateTime(picked.year, picked.month, picked.day, 17, 0);
      } else {
        // If different day, set end time to 5:00 PM
        endDate.value = DateTime(picked.year, picked.month, picked.day, 17, 0);
      }
      print('End date set to: ${endDate.value}');
    }
  }

  Future<void> createChallenge() async {
    if (_validateForm()) {
      isCreatingChallenge.value = true;
      try {
        final format = selectedFormat.value == 'ONLINE'
            ? EventFormat.ONLINE
            : EventFormat.ONSITE;

        final response = await challengeRepository.createChallenge(
          title: challengeTitle.text.trim(),
          description: challengeDescription.text.trim(),
          format: format,
          startDate: startDate.value!,
          endDate: endDate.value!,
          location: challengeLocation.text.trim().isEmpty
              ? null
              : challengeLocation.text.trim(),
          coverImageFile: selectedImage.value,
          challengeCategory: selectedCategory.value?.isEmpty ?? true
              ? null
              : selectedCategory.value,
          targetValue: targetValue.text.trim().isEmpty
              ? null
              : int.tryParse(targetValue.text.trim()),
          targetUnit: targetUnit.text.trim().isEmpty
              ? null
              : targetUnit.text.trim(),
        );

        if (response != null && response.success && response.data != null) {
          _showSuccessDialog(response.data!);
          _clearForm();
        } else {
          Get.snackbar(
            'Error',
            response?.message ?? 'Failed to create challenge',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } catch (e) {
        print('Error creating challenge: $e');
        Get.snackbar(
          'Error',
          'Failed to create challenge: $e',
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        isCreatingChallenge.value = false;
      }
    }
  }

  bool _validateForm() {
    if (challengeTitle.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter challenge title');
      return false;
    }
    if (challengeDescription.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter challenge description');
      return false;
    }
    if (startDate.value == null) {
      Get.snackbar('Error', 'Please select start date');
      return false;
    }
    if (endDate.value == null) {
      Get.snackbar('Error', 'Please select end date');
      return false;
    }
    if (endDate.value!.isBefore(startDate.value!)) {
      Get.snackbar('Error', 'End date must be after start date');
      return false;
    }
    if (selectedFormat.value == null || selectedFormat.value!.isEmpty) {
      Get.snackbar('Error', 'Please select challenge format');
      return false;
    }
    if (selectedFormat.value == 'ONSITE' &&
        challengeLocation.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter location for onsite challenges');
      return false;
    }
    return true;
  }

  void _clearForm() {
    challengeTitle.clear();
    challengeDescription.clear();
    challengeLocation.clear();
    challengeCategory.clear();
    targetValue.clear();
    targetUnit.clear();
    selectedImage.value = null;
    selectedImageName.value = '';
    startDate.value = null;
    endDate.value = null;
    selectedFormat.value = 'ONLINE';
    selectedStatus.value = 'DRAFT';
    selectedCategory.value = null;
  }

  void _showSuccessDialog(EventModel challenge) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: SingleChildScrollView(
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
                  'Challenge Created Successfully!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Title', challenge.title),
                      SizedBox(height: 8),
                      _buildDetailRow(
                        'Format',
                        challenge.format.toString().split('.').last,
                      ),
                      SizedBox(height: 8),
                      if (challenge.location != null)
                        _buildDetailRow('Location', challenge.location!),
                      if (challenge.location != null) SizedBox(height: 8),
                      _buildDetailRow(
                        'Start Date',
                        _formatDateTime(challenge.startDate),
                      ),
                      SizedBox(height: 8),
                      _buildDetailRow(
                        'End Date',
                        _formatDateTime(challenge.endDate),
                      ),
                      SizedBox(height: 8),
                      _buildDetailRow(
                        'Status',
                        challenge.status.toString().split('.').last,
                      ),
                      if (challenge.challengeCategory != null) ...[
                        SizedBox(height: 8),
                        _buildDetailRow(
                          'Category',
                          challenge.challengeCategory!,
                        ),
                      ],
                      SizedBox(height: 8),
                      _buildDetailRow('Challenge ID', challenge.id),
                    ],
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
                      fetchChallenges(); // Refresh challenges list
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
      ),
      barrierDismissible: false,
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void clearImage() {
    selectedImage.value = null;
    selectedImageName.value = '';
  }

  @override
  void onClose() {
    challengeTitle.dispose();
    challengeDescription.dispose();
    challengeLocation.dispose();
    challengeCategory.dispose();
    targetValue.dispose();
    targetUnit.dispose();
    super.onClose();
  }
}
