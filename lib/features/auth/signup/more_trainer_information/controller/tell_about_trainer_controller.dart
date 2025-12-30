import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'availability_controller.dart';

class TellAboutTrainerController extends GetxController {
  // initial values provided via arguments in onInit
  final imageUrl = ''.obs;
  final fullName = ''.obs;
  final currentBio = ''.obs;

  // text controllers (initialized once)
  final country = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  final specializeController = TextEditingController();
  final areaOfServiceController = TextEditingController();
  final bioController = TextEditingController();
  final fullNameController = TextEditingController();

  var specializationsList = <String>[].obs;
  var sessionType = RxnString();

  // image picker
  final ImagePicker _picker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);

  // dependency: availability controller (Get.put earlier in UI)
  late final AvailabilityController availabilityController;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is List && args.length >= 3) {
      fullName.value = args[0] as String? ?? '';
      imageUrl.value = args[1] as String? ?? '';
      currentBio.value = args[2] as String? ?? '';
      if (args.length > 3 && args[3] is List) {
        specializationsList.assignAll(List<String>.from(args[3]));
      }
    }

    fullNameController.text = fullName.value;
    bioController.text = currentBio.value;

    // get or create availability controller
    availabilityController = Get.put(AvailabilityController());
    getTrainerProfile();
  }

  @override
  void onClose() {
    country.dispose();
    state.dispose();
    city.dispose();
    specializeController.dispose();
    areaOfServiceController.dispose();
    bioController.dispose();
    fullNameController.dispose();
    super.onClose();
  }

  Future<void> getTrainerProfile() async {
    try {
      final networkClient = Get.find<NetworkClient>();
      final response = await networkClient.getRequest(
        url: "https://wellfitsync.com/trainer",
      );

      if (response.isSuccess) {
        final body = response.responseData;
        if (body['success'] == true && body['data'] != null) {
          final data = body['data'];

          fullName.value = data['fullname'] ?? '';
          fullNameController.text = fullName.value;

          imageUrl.value = data['images'] ?? '';
          currentBio.value = data['bio'] ?? '';
          bioController.text = currentBio.value;

          country.text = data['nationality'] ?? '';
          city.text = data['city'] ?? '';
          areaOfServiceController.text = data['areaOfService'] ?? '';

          if (data['sessionType'] != null) {
            String sType = data['sessionType'].toString();
            if (sType.toUpperCase() == 'ONLINE') {
              sessionType.value = 'Online';
            } else if (sType.toUpperCase() == 'ONSITE') {
              sessionType.value = 'Onsite';
            } else {
              sessionType.value = sType;
            }
          }

          if (data['specializations'] != null) {
            specializationsList.assignAll(
              List<String>.from(data['specializations']),
            );
          }

          if (data['availabilities'] != null) {
            var availData = data['availabilities'];
            List<dynamic> list = [];
            if (availData is Map) list.add(availData);
            if (availData is List) list = availData;

            availabilityController.slots.clear();
            for (var item in list) {
              try {
                String dayStr = item['day']?.toString().toLowerCase() ?? '';
                DayOfWeek? dayEnum;
                for (var d in DayOfWeek.values) {
                  if (d.name == dayStr) {
                    dayEnum = d;
                    break;
                  }
                }

                if (dayEnum != null &&
                    item['startDate'] != null &&
                    item['endDate'] != null) {
                  DateTime start = DateTime.parse(item['startDate']).toLocal();
                  DateTime end = DateTime.parse(item['endDate']).toLocal();
                  availabilityController.slots.add(
                    AvailabilitySlot(
                      days: {dayEnum},
                      startTime: TimeOfDay.fromDateTime(start),
                      endTime: TimeOfDay.fromDateTime(end),
                    ),
                  );
                }
              } catch (e) {
                if (kDebugMode) print("Error parsing availability: $e");
              }
            }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching profile: $e");
      }
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (picked != null) selectedImage.value = File(picked.path);

      if (kDebugMode) {
        print("==============================$selectedImage");
      }
    } catch (e) {
      EasyLoading.showError("Failed to pick image");
    }
  }

  void addSpecialization() {
    final text = specializeController.text.trim();
    if (text.isNotEmpty && !specializationsList.contains(text)) {
      specializationsList.add(text);
    }
    specializeController.clear();
  }

  void removeSpecializationAt(int index) {
    specializationsList.removeAt(index);
  }

  /// Build final payload for API
  Map<String, dynamic> buildPayload() {
    // Take values from controllers or fallback to initial obs values
    final fullnameVal = fullNameController.text.trim().isEmpty
        ? fullName.value
        : fullNameController.text.trim();

    final bioVal = bioController.text.trim().isEmpty
        ? currentBio.value
        : bioController.text.trim();

    final finalImageUrl = imageUrl.value;

    // Ensure sessionType matches API enum values: ONLINE, ONSITE, OFFSIDE
    final session = (sessionType.value ?? 'ONLINE').toString().toUpperCase();

    // Build availability list and attach required fields (location, isBooked)
    final List<Map<String, dynamic>> rawAvail = availabilityController
        .toApiList();

    String locationVal = areaOfServiceController.text.trim();
    if (locationVal.isEmpty) {
      locationVal = city.text.trim();
    }
    // Fallback if both are empty to satisfy API validation
    if (locationVal.isEmpty) locationVal = "Online";

    final List<Map<String, dynamic>> availabilityWithLocation = rawAvail.map((
      entry,
    ) {
      return {
        'day': entry['day'],
        'startDate': entry['startDate'],
        'endDate': entry['endDate'],
        'location': locationVal,
        'isBooked': false,
      };
    }).toList();

    return {
      "fullname": fullnameVal,
      "nationality": country.text.trim(),
      "images": finalImageUrl,
      "city": city.text.trim(),
      "areaOfService": areaOfServiceController.text.trim(),
      "bio": bioVal,
      "specializations": specializationsList.toList(),
      // API expects uppercase enum values
      "sessionType": session,
      "hourlyRate": 0,
      "currency": "USD",
      // send availability as a list of objects with required fields
      "availability": availabilityWithLocation,
    };
  }

  /// Submit profile: uploads image (if selected) then posts the payload
  Future<bool> submitProfile() async {
    try {
      EasyLoading.show(status: "Please wait...");

      final networkClient = Get.find<NetworkClient>();
      // if user picked a new local image, upload it first and set images URL
      if (selectedImage.value != null) {
        final uploadRes = await networkClient.uploadFile(
          url: "https://wellfitsync.com/upload",
          file: selectedImage.value!,
          fieldName: 'file',
          extraFields: null,
        );
        if (uploadRes.isSuccess) {
          // assume upload returns { "url": "https://..." }
          final data = uploadRes.responseData;
          if (data is Map) {
            if (data['url'] != null) {
              imageUrl.value = data['url'];
            } else if (data['file'] is Map && data['file']['url'] != null) {
              imageUrl.value = data['file']['url'];
            }
          }
        } else {
          EasyLoading.showError(
            uploadRes.errorMessage ?? 'Image upload failed',
          );
          return false;
        }
      }

      // call trainer profile service endpoint
      final payload = buildPayload();
      if (kDebugMode) {
        print("Sending PATCH Payload: $payload");
      }

      final res = await networkClient.patchRequest(
        url: "https://wellfitsync.com/trainer/profile",
        body: payload,
      );

      if (kDebugMode) {
        print("PATCH Response: ${res.responseData}");
      }

      if (res.isSuccess) {
        EasyLoading.showSuccess("Profile updated successfully");

        // Update local observables
        fullName.value = fullNameController.text;
        currentBio.value = bioController.text;
        return true;
      } else {
        if (kDebugMode) {
          print("Error Response Body: ${res.responseData}");
        }
        EasyLoading.showError(res.errorMessage ?? 'Submission failed');
        return false;
      }
    } catch (e) {
      EasyLoading.showError('An error occurred');
      return false;
    }
  }
}
