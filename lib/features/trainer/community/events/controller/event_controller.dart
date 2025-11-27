import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/community/events/model/event_model.dart';
import 'package:gokul_ramk/features/trainer/community/events/repository/event_repository.dart';

class EventsController extends GetxController {
  late EventRepository eventRepository;
  final ImagePicker _imagePicker = ImagePicker();

  var events = <Map<String, dynamic>>[].obs;
  var options = ['ONLINE', 'ONSITE'].obs;
  var statusOptions = [
    'DRAFT',
    'UPCOMING',
    'ACTIVE',
    'COMPLETED',
    'CANCELLED',
    'ENDED',
  ].obs;

  // Form fields
  var eventTitle = TextEditingController();
  var eventDescription = TextEditingController();
  var eventLocation = TextEditingController();

  // Observables for form
  var selectedFormat = RxnString();
  var selectedStatus = RxnString();
  var selectedImage = Rxn<File>();
  var selectedImageName = ''.obs;
  var startDate = Rxn<DateTime>();
  var endDate = Rxn<DateTime>();
  var isCreatingEvent = false.obs;

  @override
  void onInit() {
    super.onInit();
    final networkClient = Get.find<NetworkClient>();
    eventRepository = EventRepository(networkClient: networkClient);
    selectedFormat.value = 'ONLINE'; // Default format
    selectedStatus.value = 'DRAFT'; // Default status
    loadEvents();
  }

  void loadEvents() {
    events.value = [
      {
        "title": "Virtual Zumba Party",
        "date": "Sat, Sep 7 - 7:00PM",
        "isOnline": true,
        "location": "",
        "organizedBy": "Gokul Ram",
      },
      {
        "title": "HIIT with Coach Gokul",
        "date": "Mon, Sep 9 - 6:00AM",
        "isOnline": false,
        "location": "Dubai, UAE",
        "organizedBy": "Gokul Ram",
      },
      {
        "title": "Healthy Meal Prep Workshop",
        "date": "Sep 12 - Online",
        "isOnline": true,
        "location": "",
        "organizedBy": "Gokul Ram",
      },
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
      startDate.value = picked;
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
      endDate.value = picked;
    }
  }

  Future<void> createEvent() async {
    if (_validateForm()) {
      isCreatingEvent.value = true;
      try {
        final format = selectedFormat.value == 'ONLINE'
            ? EventFormat.ONLINE
            : EventFormat.ONSITE;

        final response = await eventRepository.createEvent(
          title: eventTitle.text.trim(),
          description: eventDescription.text.trim(),
          type: EventType.EVENT,
          format: format,
          startDate: startDate.value!,
          endDate: endDate.value!,
          location: eventLocation.text.trim().isEmpty
              ? null
              : eventLocation.text.trim(),
          coverImageFile: selectedImage.value,
        );

        if (response != null && response.success) {
          _showSuccessDialog();
          _clearForm();
        } else {
          Get.snackbar('Error', response?.message ?? 'Failed to create event');
        }
      } catch (e) {
        print('Error creating event: $e');
        Get.snackbar('Error', 'Failed to create event: $e');
      } finally {
        isCreatingEvent.value = false;
      }
    }
  }

  bool _validateForm() {
    if (eventTitle.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter event title');
      return false;
    }
    if (eventDescription.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter event description');
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
      Get.snackbar('Error', 'Please select event format');
      return false;
    }
    if (selectedFormat.value == 'ONSITE' && eventLocation.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please enter location for onsite events');
      return false;
    }
    return true;
  }

  void _clearForm() {
    eventTitle.clear();
    eventDescription.clear();
    eventLocation.clear();
    selectedImage.value = null;
    selectedImageName.value = '';
    startDate.value = null;
    endDate.value = null;
    selectedFormat.value = 'ONLINE';
    selectedStatus.value = 'DRAFT';
  }

  void _showSuccessDialog() {
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
                'Event Created Successfully!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Your event has been created and is ready.',
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

  @override
  void onClose() {
    eventTitle.dispose();
    eventDescription.dispose();
    eventLocation.dispose();
    super.onClose();
  }
}
