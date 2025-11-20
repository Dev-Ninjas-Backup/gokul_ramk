import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TellAboutTrainerController extends GetxController {
  late final String imageUrl;
  late final String fullName;
  late final String currentBio;
  var specializationsList = <String>[].obs;

  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  final specializeController = TextEditingController();
  final availabialityController = TextEditingController();
  final areaOfServiceController = TextEditingController();
  TextEditingController get bioController =>
      TextEditingController(text: currentBio);
  TextEditingController get fullNameController =>
      TextEditingController(text: fullName);

  var sessionType = RxnString();

  //image picker

  final ImagePicker _picker = ImagePicker();
  final Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
      }
    } catch (e) {
      EasyLoading.showError("Error: Failed to pick image: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as List<dynamic>;
    fullName = args[0] as String;

    imageUrl = args[1] as String;
    currentBio = args[2] as String;
  }

  //specialixation

  void addSpecialization() {
    final text = specializeController.text.trim();
    if (text.isNotEmpty) {
      if (!specializationsList.contains(text)) {
        specializationsList.add(text);




      }
      specializeController.clear();
    }

     debugPrint("Specializations List: $specializationsList");
  }

  

  void removeSpecialization(int index) {
    specializationsList.removeAt(index);
  }

  @override
  void onClose() {
    specializeController.dispose();
    super.onClose();
  }
}
