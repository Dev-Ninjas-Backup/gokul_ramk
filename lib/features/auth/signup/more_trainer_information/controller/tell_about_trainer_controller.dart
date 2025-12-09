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
    }

    fullNameController.text = fullName.value;
    bioController.text = currentBio.value;

    // get or create availability controller
    availabilityController = Get.put(AvailabilityController());
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

    final finalImageUrl = selectedImage.value != null
        // ? Urls.baseUrl + imageUrl.value
                ?imageUrl.value

        : " ";

    return {
      "fullname": fullnameVal,
      "nationality": country.text.trim(),
      "images": finalImageUrl,
      "city": city.text.trim(),
      "areaOfService": areaOfServiceController.text.trim(),
      "bio": bioVal,
      "specializations": specializationsList.toList(),
      "sessionType": sessionType.value ?? "Online",
      "hourlyRate": 0,
      "currency": "USD",
      "availability": availabilityController.toApiList(),
    };
  }

  /// Submit profile: uploads image (if selected) then posts the payload
  Future<void> submitProfile() async {
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
          if (data is Map && data['file']['url'] != null) {
            imageUrl.value = data['file']['url'];
          }
        } else {
          EasyLoading.showError(
            uploadRes.errorMessage ?? 'Image upload failed',
          );
          return;
        }
      }

      // call trainer profile service endpoint
      final payload = buildPayload();
      final res = await networkClient.patchRequest(
        url: "https://wellfitsync.com/trainer/profile",
        body: payload,
      );

      if (res.isSuccess) {
        EasyLoading.showSuccess("Profile submitted");
        // navigate or update state as needed
      } else {
        EasyLoading.showError(res.errorMessage ?? 'Submission failed');
      }
    } catch (e) {
      EasyLoading.showError('An error occurred');
    } finally {
      EasyLoading.dismiss();
    }
  }
}
