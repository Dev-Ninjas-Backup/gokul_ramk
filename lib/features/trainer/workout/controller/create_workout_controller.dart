// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:url_launcher/url_launcher.dart';
import '../model/category_model.dart';
import '../model/workout_model.dart';

class CreatePackageController extends GetxController {
  final nameController = TextEditingController();
  final durationController = TextEditingController();
  final descriptionController = TextEditingController();

  var isLoading = false.obs;
  var categoryList = <CategoryItem>[].obs;
  var selectedDurationInMinutes = 0.obs;

  // Template state
  var templateFound = false.obs;
  var templateData = Rxn<Map<String, dynamic>>();
  var sessionId = Rxn<String>();
  var sessionTitle = Rxn<String>();
  var sessionsList = <Map<String, dynamic>>[].obs;
  var selectedSessionId = Rxn<String>();

  // Update mode
  var isUpdateMode = false.obs;
  var workoutToUpdate = Rxn<Workout>();

  // Dropdown selections
  var selectedDifficulty = 'INTERMEDIATE'.obs;
  var selectedStatus = 'INACTIVE'.obs;
  var selectedWorkoutType = 'ONSITE'.obs;
  var selectedCategoryId = Rxn<String>();

  // Image Picker
  final ImagePicker _picker = ImagePicker();
  var pickedImage = Rxn<File>();

  final List<String> difficultyOptions = [
    'BEGINNER',
    'INTERMEDIATE',
    'ADVANCED',
  ];
  final List<String> statusOptions = ['ACTIVE', 'INACTIVE'];
  final List<String> workoutTypeOptions = [
    'ONLINE',
    'IN_PERSON',
    'ONSITE',
    'HYBRID',
  ];

  @override
  void onInit() {
    super.onInit();
    // Check if this is update mode
    if (workoutToUpdate.value != null) {
      isUpdateMode.value = true;
      _populateUpdateFields(workoutToUpdate.value!);
    } else {
      checkTemplate();
      getSession();
      getCategories();
    }
  }

  void _populateUpdateFields(Workout workout) {
    nameController.text = workout.name ?? "";
    descriptionController.text = workout.description ?? "";
    selectedDifficulty.value = workout.difficulty ?? "INTERMEDIATE";
    selectedDurationInMinutes.value = workout.duration ?? 0;
    _updateDurationText();
    print("Update mode: Prefilled fields from workout ${workout.id}");
  }

  void populateUpdateFields(Workout workout) {
    _populateUpdateFields(workout);
  }

  Future<void> checkTemplate() async {
    try {
      final SharedPreferencesHelperController sharedPreference = Get.put(
        SharedPreferencesHelperController(),
      );
      String? token = await sharedPreference.getAccessToken();

      final response = await GetConnect().get(
        Urls.workoutTemplate,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );

      print("Template Check Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = response.body;
        if (responseData['data'] != null) {
          templateFound.value = true;
          templateData.value = responseData['data'];
          _populateFieldsFromTemplate(responseData['data']);
          print("Template found and fields populated");
        }
      } else if (response.statusCode == 404) {
        templateFound.value = false;
        print("No template found");
      }
    } catch (e) {
      print("Error checking template: $e");
      templateFound.value = false;
    }
  }

  void _populateFieldsFromTemplate(Map<String, dynamic> template) {
    // Don't pre-fill fields, just mark template as found
    print("Template found, ready for workout creation");
  }

  Future<void> getSession() async {
    try {
      final SharedPreferencesHelperController sharedPreference = Get.put(
        SharedPreferencesHelperController(),
      );
      String? token = await sharedPreference.getAccessToken();

      final response = await GetConnect().get(
        Urls.session,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );

      print("Session API Response: ${response.statusCode}");

      if (response.statusCode == 200) {
        final responseData = response.body;
        if (responseData['data'] != null &&
            responseData['data']['data'] is List) {
          final sessions = responseData['data']['data'] as List;
          sessionsList.value = List<Map<String, dynamic>>.from(
            sessions.map((s) => Map<String, dynamic>.from(s as Map)),
          );

          if (sessionsList.isNotEmpty) {
            selectedSessionId.value = sessionsList[0]['id'];
            print("Sessions loaded: ${sessionsList.length} sessions available");
          }
        } else if (responseData['id'] != null) {
          sessionId.value = responseData['id'];
          sessionTitle.value = responseData['title'] ?? "Session";
          selectedSessionId.value = responseData['id'];
          print("Session ID retrieved: ${sessionId.value}");
        }
      }
    } catch (e) {
      print("Error fetching session: $e");
    }
  }

  void pickDuration(BuildContext context) {
    Duration tempDuration = Duration(minutes: selectedDurationInMinutes.value);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 250,
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoButton(
                    child: Text('Done'),
                    onPressed: () {
                      selectedDurationInMinutes.value = tempDuration.inMinutes;
                      _updateDurationText();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hm,
                  initialTimerDuration: tempDuration,
                  onTimerDurationChanged: (Duration changedTimer) {
                    tempDuration = changedTimer;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateDurationText() {
    final minutes = selectedDurationInMinutes.value;
    final h = minutes ~/ 60;
    final m = minutes % 60;
    String text = "";
    if (h > 0) text += "$h hr ";
    if (m > 0) text += "$m min";
    if (text.isEmpty) text = "0 min";
    durationController.text = text.trim();
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage.value = File(image.path);
    }
  }

  Future<void> getCategories() async {
    isLoading.value = true;
    try {
      final SharedPreferencesHelperController sharedPreference = Get.put(
        SharedPreferencesHelperController(),
      );
      String? token = await sharedPreference.getAccessToken();

      final response = await GetConnect().get(
        Urls.categories,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );

      print("API Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final result = CategoryResponse.fromJson(response.body);
        if (result.success == true && result.data?.data != null) {
          categoryList.assignAll(result.data!.data!);
          if (categoryList.isNotEmpty && selectedCategoryId.value == null) {
            selectedCategoryId.value = categoryList.first.id;
          }
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to fetch categories: ${response.statusText}",
        );
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createPackage() async {
    if (isUpdateMode.value) {
      // Update mode
      await _updateWorkout();
    } else if (templateFound.value) {
      // Create workout mode
      await _createWorkout();
    } else {
      // Request template mode
      await _requestTemplate();
    }
  }

  Future<void> _updateWorkout() async {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter a workout name");
      return;
    }

    if (descriptionController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter a description");
      return;
    }

    isLoading.value = true;
    try {
      final SharedPreferencesHelperController sharedPreference = Get.put(
        SharedPreferencesHelperController(),
      );
      String? token = await sharedPreference.getAccessToken();
      String coverImageUrl = workoutToUpdate.value?.coverImage ?? "";

      // If user picked a new image, upload it
      if (pickedImage.value != null) {
        var request = http.MultipartRequest('POST', Uri.parse(Urls.uploadFile));
        request.headers['Authorization'] = token ?? '';

        final file = pickedImage.value!;
        final ext = path.extension(file.path).toLowerCase();
        String mimeType = 'jpeg';
        if (ext == '.png') {
          mimeType = 'png';
        }

        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            file.path,
            contentType: MediaType('image', mimeType),
          ),
        );

        print("Uploading new image for workout update...");
        var streamedResponse = await request.send();
        var uploadResponse = await http.Response.fromStream(streamedResponse);

        if (uploadResponse.statusCode != 200 &&
            uploadResponse.statusCode != 201) {
          Get.snackbar(
            "Error",
            "Image upload failed: ${uploadResponse.statusCode}",
          );
          isLoading.value = false;
          return;
        }

        final responseData = jsonDecode(uploadResponse.body);
        if (responseData is Map<String, dynamic>) {
          if (responseData['url'] != null) {
            coverImageUrl = responseData['url'];
          } else if (responseData['file'] != null &&
              responseData['file']['url'] != null) {
            coverImageUrl = responseData['file']['url'];
          }
        }
      }

      // Update workout
      final body = {
        "name": nameController.text,
        "difficulty": selectedDifficulty.value,
        "duration": selectedDurationInMinutes.value,
        "description": descriptionController.text,
        "coverImage": coverImageUrl,
      };

      print("Updating workout ${workoutToUpdate.value?.id}: $body");
      final response = await GetConnect().patch(
        Urls.updateWorkout(workoutToUpdate.value?.id ?? ''),
        body,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );

      print("Update Workout Response: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Workout updated successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
        Future.delayed(Duration(seconds: 2), () {
          Get.offNamedUntil('/workout-list', (route) => false);
        });
      } else {
        Get.snackbar(
          "Error",
          "Failed to update workout: ${response.statusText}",
        );
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _createWorkout() async {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter a workout name");
      return;
    }

    if (descriptionController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter a description");
      return;
    }

    if (pickedImage.value == null) {
      Get.snackbar("Error", "Please select a cover image");
      return;
    }

    isLoading.value = true;
    try {
      final SharedPreferencesHelperController sharedPreference = Get.put(
        SharedPreferencesHelperController(),
      );
      String? token = await sharedPreference.getAccessToken();
      String coverImageUrl = "";

      // 1. Upload Image
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://wellfitsync.com/upload'),
      );
      request.headers['Authorization'] = token ?? '';

      final file = pickedImage.value!;
      final ext = path.extension(file.path).toLowerCase();
      String mimeType = 'jpeg';
      if (ext == '.png') {
        mimeType = 'png';
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.path,
          contentType: MediaType('image', mimeType),
        ),
      );

      print("Uploading image for workout creation...");
      var streamedResponse = await request.send();
      var uploadResponse = await http.Response.fromStream(streamedResponse);

      print("Upload Response: ${uploadResponse.statusCode}");
      print("Upload Response Body: ${uploadResponse.body}");

      if (uploadResponse.statusCode != 200 &&
          uploadResponse.statusCode != 201) {
        Get.snackbar(
          "Error",
          "Image upload failed: ${uploadResponse.statusCode}",
        );
        isLoading.value = false;
        return;
      }

      final responseData = jsonDecode(uploadResponse.body);
      if (responseData is Map<String, dynamic>) {
        if (responseData['url'] != null) {
          coverImageUrl = responseData['url'];
        } else if (responseData['file'] != null &&
            responseData['file'] is Map &&
            responseData['file']['url'] != null) {
          coverImageUrl = responseData['file']['url'];
        }
      }

      if (coverImageUrl.isEmpty) {
        Get.snackbar("Error", "Failed to retrieve image URL from server");
        isLoading.value = false;
        return;
      }

      print("Image uploaded successfully. URL: $coverImageUrl");

      // 2. Create workout with the new schema
      final body = {
        "name": nameController.text,
        "difficulty": selectedDifficulty.value,
        "duration": selectedDurationInMinutes.value,
        "description": descriptionController.text,
        "coverImage": coverImageUrl,
        "sessionId": selectedSessionId.value ?? "",
      };

      print("Creating workout: $body");
      final response = await GetConnect().post(
        Urls.createWorkout,
        body,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );

      print("Create Workout Response: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Workout created successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
        Future.delayed(Duration(seconds: 2), () {
          Get.offNamedUntil('/workout-list', (route) => false);
        });
      } else {
        Get.snackbar(
          "Error",
          "Failed to create workout: ${response.statusText}",
        );
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _requestTemplate() async {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter a workout name");
      return;
    }

    if (descriptionController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter a description");
      return;
    }

    if (pickedImage.value == null) {
      Get.snackbar("Error", "Please select a cover image");
      return;
    }

    if (selectedCategoryId.value == null) {
      Get.snackbar("Error", "Please select a category");
      return;
    }

    if (selectedWorkoutType.value == 'ONLINE' &&
        selectedDurationInMinutes.value == 0) {
      Get.snackbar("Error", "Please select a duration for online workouts");
      return;
    }

    isLoading.value = true;
    try {
      final SharedPreferencesHelperController sharedPreference = Get.put(
        SharedPreferencesHelperController(),
      );
      String? token = await sharedPreference.getAccessToken();

      // 1. Validate request template API first (without image)
      // This ensures the API is ready before uploading the image
      final validationBody = {
        "name": nameController.text,
        "difficulty": selectedDifficulty.value,
        "duration": selectedDurationInMinutes.value,
        "description": descriptionController.text,
        "status": selectedStatus.value,
        "coverImage": "", // Placeholder for validation
        "workoutType": selectedWorkoutType.value,
        "categoryId": selectedCategoryId.value,
      };

      print("Validating request template API...");
      final validationResponse = await GetConnect().post(
        Urls.requestTemplate,
        validationBody,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );

      print(
        "Validation Response Status Code: ${validationResponse.statusCode}",
      );
      print("Validation Response Body: ${validationResponse.body}");

      // Check if API validation passed
      if (validationResponse.statusCode != 200 &&
          validationResponse.statusCode != 201) {
        String errorMessage = "Failed to create package";
        final responseBody = validationResponse.body;

        // Extract detailed error message from response
        if (responseBody is Map<String, dynamic>) {
          if (responseBody['message'] != null) {
            errorMessage = responseBody['message'];
          } else if (responseBody['error'] != null) {
            errorMessage = responseBody['error'];
          } else if (responseBody['errors'] != null) {
            // Handle validation errors array
            final errors = responseBody['errors'];
            if (errors is List && errors.isNotEmpty) {
              errorMessage = errors
                  .map((e) => e is String ? e : e['message'] ?? e.toString())
                  .join(', ');
            }
          }
        }

        _showErrorDialog(
          title: "Template Request Failed",
          message: errorMessage,
        );
        isLoading.value = false;
        return;
      }

      final validationData = validationResponse.body;
      if (validationData['success'] != true) {
        String? redirectUrl;
        if (validationData['data'] != null &&
            validationData['data'].toString().startsWith('http')) {
          redirectUrl = validationData['data'];
        } else if (validationData['message'] != null &&
            validationData['message'].toString().startsWith('http')) {
          redirectUrl = validationData['message'];
        }

        if (redirectUrl != null) {
          _showStripeDialog(redirectUrl);
        } else {
          Get.snackbar(
            "Error",
            validationData['message'] ?? "Failed to create package",
          );
        }
        isLoading.value = false;
        return;
      }

      // 2. API validation passed, now upload image
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://wellfitsync.com/upload'),
      );
      request.headers['Authorization'] = token ?? '';

      final file = pickedImage.value!;
      final ext = path.extension(file.path).toLowerCase();
      String mimeType = 'jpeg';
      if (ext == '.png') {
        mimeType = 'png';
      }

      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          file.path,
          contentType: MediaType('image', mimeType),
        ),
      );

      print("Sending upload request to https://wellfitsync.com/upload");
      var streamedResponse = await request.send();
      var uploadResponse = await http.Response.fromStream(streamedResponse);

      print("Upload Response Body: ${uploadResponse.body}");

      if (uploadResponse.statusCode != 200 &&
          uploadResponse.statusCode != 201) {
        Get.snackbar(
          "Error",
          "Image upload failed: ${uploadResponse.statusCode}",
        );
        isLoading.value = false;
        return;
      }

      String coverImageUrl = "";
      final responseData = jsonDecode(uploadResponse.body);
      if (responseData is Map<String, dynamic>) {
        if (responseData['url'] != null) {
          coverImageUrl = responseData['url'];
        } else if (responseData['file'] != null &&
            responseData['file']['url'] != null) {
          coverImageUrl = responseData['file']['url'];
        }
      }

      if (coverImageUrl.isEmpty) {
        Get.snackbar("Error", "Failed to retrieve image URL from server");
        isLoading.value = false;
        return;
      }

      // 3. Now send final request with image URL
      final finalBody = {
        "name": nameController.text,
        "difficulty": selectedDifficulty.value,
        "duration": selectedDurationInMinutes.value,
        "description": descriptionController.text,
        "status": selectedStatus.value,
        "coverImage": coverImageUrl,
        "workoutType": selectedWorkoutType.value,
        "categoryId": selectedCategoryId.value,
      };

      final finalResponse = await GetConnect().post(
        Urls.requestTemplate,
        finalBody,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token ?? '',
        },
      );

      print("Final POST: ${Urls.requestTemplate}");
      print("Status Code: ${finalResponse.statusCode}");
      print("Response Body: ${finalResponse.body}");

      if (finalResponse.statusCode == 200 || finalResponse.statusCode == 201) {
        final responseData = finalResponse.body;
        if (responseData['success'] == true) {
          Get.snackbar(
            "Success",
            "Workout template created successfully",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
          Future.delayed(Duration(seconds: 2), () {
            Get.offNamedUntil('/workout-list', (route) => false);
          });
        } else {
          String errorMessage =
              responseData['message'] ?? "Failed to create package";
          _showErrorDialog(
            title: "Template Request Failed",
            message: errorMessage,
          );
        }
      } else {
        String errorMessage = "Failed to create package";
        final responseBody = finalResponse.body;

        // Extract detailed error message from response
        if (responseBody is Map<String, dynamic>) {
          if (responseBody['message'] != null) {
            errorMessage = responseBody['message'];
          } else if (responseBody['error'] != null) {
            errorMessage = responseBody['error'];
          } else if (responseBody['errors'] != null) {
            // Handle validation errors array
            final errors = responseBody['errors'];
            if (errors is List && errors.isNotEmpty) {
              errorMessage = errors
                  .map((e) => e is String ? e : e['message'] ?? e.toString())
                  .join(', ');
            }
          }
        }

        _showErrorDialog(
          title: "Template Request Failed",
          message: errorMessage,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void _showStripeDialog(String url) {
    Get.defaultDialog(
      title: "Action Required",
      middleText:
          "Please complete your Stripe payment setup to create packages.",
      textConfirm: "Setup Now",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        Get.back();
        try {
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(
              Uri.parse(url),
              mode: LaunchMode.externalApplication,
            );
          } else {
            Get.snackbar("Error", "Could not launch URL");
          }
        } catch (e) {
          Get.snackbar("Error", "Failed to open URL: $e");
        }
      },
    );
  }

  void _showErrorDialog({required String title, required String message}) {
    Get.defaultDialog(
      title: title,
      middleText: message,
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back();
      },
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    durationController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
