// import 'dart:io';
// import 'package:get/get.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:gokul_ramk/features/trainer/home/home_screen/meal_screen/model/meal_model.dart';
// import 'package:gokul_ramk/features/trainer/home/home_screen/meal_screen/service/meal_service.dart';
// import 'package:image_picker/image_picker.dart';

// class MealController extends GetxController {
//   final MealService service = MealService();

//   RxBool isLoading = false.obs;

//   var title = ''.obs;
//   var description = ''.obs;
//   var image = ''.obs;

//   var calories = 0.obs;
//   var protein = 0.obs;
//   var carbs = 0.obs;
//   var fat = 0.obs;

//   Rx<File?> pickedImage = Rx<File?>(null);
//   final ImagePicker picker = ImagePicker();

//   Future<void> pickImage() async {
//     final XFile? file = await picker.pickImage(source: ImageSource.gallery);

//     if (file != null) {
//       pickedImage.value = File(file.path);
//       image.value = file.path;
//     }
//   }

//   RxList<String> vitamins = <String>[].obs;
//   RxList<String> ingredients = <String>[].obs;
//   RxList<String> preparation = <String>[].obs;

//   Future<void> createMeal() async {
//     EasyLoading.show(status: "Creating meal...");
//     isLoading(true);

//     final request = MealCreateRequest(
//       title: title.value,
//       description: description.value,
//       image: image.value,
//       calories: calories.value,
//       protein: protein.value,
//       carbs: carbs.value,
//       fat: fat.value,
//       vitamins: vitamins,
//       ingredients: ingredients,
//       preparation: preparation,
//     );

//     final response = await service.createMeal(request);

//     isLoading(false);
//     EasyLoading.dismiss();

//     if (response["success"]) {
//       EasyLoading.showSuccess(response["message"]);
//     } else {
//       EasyLoading.showError(response["message"]);
//     }
//   }
// }

// ignore_for_file: avoid_print

import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/meal_screen/model/meal_model.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/meal_screen/service/meal_service.dart';
import 'package:image_picker/image_picker.dart';

class MealController extends GetxController {
  final NetworkClient client = NetworkClient(
    onUnAuthorize: () {
      EasyLoading.showToast("Unauthorized");
    },
  );

  RxBool isLoading = false.obs;

  var title = ''.obs;
  var description = ''.obs;
  var image = ''.obs;

  var calories = 0.obs;
  var protein = 0.obs;
  var carbs = 0.obs;
  var fat = 0.obs;

  Rx<File?> pickedImage = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();

  RxList<String> vitamins = <String>[].obs;
  RxList<String> ingredients = <String>[].obs;
  RxList<String> preparation = <String>[].obs;

  Future<void> pickImage() async {
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      pickedImage.value = File(file.path);
    }
  }

  Future<void> createMeal() async {
    if (pickedImage.value == null) {
      EasyLoading.showError("Please select an image first!");
      return;
    }

    EasyLoading.show(status: "Uploading image...");
    isLoading(true);

    final uploadResponse = await client.uploadFile(
      url: Urls.uploadFile,
      file: pickedImage.value!,
      fieldName: "file",
    );

    if (!uploadResponse.isSuccess) {
      EasyLoading.dismiss();
      isLoading(false);
      EasyLoading.showError(
        uploadResponse.errorMessage ?? "Image upload failed",
      );
      return;
    }

    final imageUrl = uploadResponse.responseData!["file"]["url"] ?? "";
    final finalImageUrl = Urls.baseUrl + imageUrl;
    print("Uploaded Image URL: $imageUrl");

    final request = MealCreateRequest(
      title: title.value,
      description: description.value,
      image: finalImageUrl,
      calories: calories.value,
      protein: protein.value,
      carbs: carbs.value,
      fat: fat.value,
      vitamins: vitamins,
      ingredients: ingredients,
      preparation: preparation,
    );

    EasyLoading.show(status: "Creating meal...");
    final response = await MealService().createMeal(request);

    isLoading(false);
    EasyLoading.dismiss();

    if (response["success"]) {
      EasyLoading.showSuccess(response["message"]);
    } else {
      EasyLoading.showError(response["message"]);
    }
  }
}
