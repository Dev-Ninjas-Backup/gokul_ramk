// // controller/program_controller.dart


// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gokul_ramk/features/trainer/program/model/categories_model.dart';
// import 'package:gokul_ramk/features/trainer/program/services/program_services.dart';
// import 'package:image_picker/image_picker.dart';
// import '../model/program_model.dart';

// class ProgramController extends GetxController {
//   final ProgramService service = ProgramService();

//   // ----------------------------------------------------
//   // TEXT CONTROLLERS
//   // ----------------------------------------------------
//   final nameC = TextEditingController();
//   final descriptionC = TextEditingController();
//   final durationC = TextEditingController();
//   final sessionsPerWeekC = TextEditingController();
//   final priceC = TextEditingController();
//   final maxParticipantsC = TextEditingController();

//   final dayNumberC = TextEditingController();
//   final setsC = TextEditingController();
//   final repsC = TextEditingController();
//   final workoutDurationC = TextEditingController();
//   final exerciseIdC = TextEditingController();

//   // ----------------------------------------------------
//   // FILE URLs
//   // ----------------------------------------------------
//   var thumbnailUrl = "".obs;
//   var videoUrl = "".obs;

//   // ----------------------------------------------------
//   // STATE
//   // ----------------------------------------------------
//   var isLoading = false.obs;

//   // Categories
//   var categories = <CategoryModel>[].obs;
//   var selectedCategoryId = Rxn<String>();
//   @override
//   void onInit() {
//     fetchCategories();
//     super.onInit();
//   }

//   // ----------------------------------------------------
//   // FETCH CATEGORIES
//   // ----------------------------------------------------
//   Future<void> fetchCategories() async {
//     isLoading(true);

//     categories.value = await ProgramService.fetchCategories();

//     /// Auto-select first category
//     if (categories.isNotEmpty) {
//       selectedCategoryId.value = categories.first.id;
//     }

//     isLoading(false);
//   }

//   // ----------------------------------------------------
//   // SUBMIT PROGRAM
//   // ----------------------------------------------------
//   Future<void> submitProgram() async {
//     if (selectedCategoryId.value == null) {
//       Get.snackbar("Error", "Please select a category");
//       return;
//     }

//     isLoading(true);

//     final body = {
//       "name": nameC.text,
//       "description": descriptionC.text,
//       "categoryId": selectedCategoryId.value,
//       "duration": int.tryParse(durationC.text) ?? 0,
//       "sessionsPerWeek": int.tryParse(sessionsPerWeekC.text) ?? 0,
//       "thumbnailUrl": thumbnailUrl.value,
//       "videoUrl": videoUrl.value,
//       "price": double.tryParse(priceC.text) ?? 0,
//       "maxParticipants": int.tryParse(maxParticipantsC.text) ?? 0,
//       "workoutDays": [
//         {
//           "dayNumber": int.tryParse(dayNumberC.text) ?? 1,
//           "sets": int.tryParse(setsC.text) ?? 0,
//           "reps": int.tryParse(repsC.text) ?? 0,
//           "duration": int.tryParse(workoutDurationC.text) ?? 0,
//           "exerciseId": exerciseIdC.text,
//           "description": "Workout Description",
//         },
//       ],
//     };

//     final success = await service.createProgram(body);

//     isLoading(false);

//     if (success) {
//       Get.snackbar("Success", "Program created successfully");
//       Get.back();
//     } else {
//       Get.snackbar("Error", "Failed to create program");
//     }
//   }

//   @override
//   void onClose() {
//     nameC.dispose();
//     descriptionC.dispose();
//     durationC.dispose();
//     sessionsPerWeekC.dispose();
//     priceC.dispose();
//     maxParticipantsC.dispose();
//     dayNumberC.dispose();
//     setsC.dispose();
//     repsC.dispose();
//     workoutDurationC.dispose();
//     exerciseIdC.dispose();
//     super.onClose();
//   }

//   //

//   //washifurs code

//   //

//   //


//   final Rx<XFile?> thumbnailImage = Rx<XFile?>(null);

//   Future<void> pickFromGallery() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       thumbnailImage.value = image;
//     }
//   }


//   void removeThumbnail() {
//     thumbnailImage.value = null;
//   }

//   // void createProgram({
//   //   required String name,
//   //   required String duration,
//   //   required String category,
//   //   required String description,
//   //   String? thumbnail,
//   // }) {
//   //   currentProgram.value = WorkoutProgram(
//   //     name: name,
//   //     duration: duration,
//   //     category: category,
//   //     description: description,
//   //     thumbnail: thumbnail,
//   //     sessions: [],
//   //   );
//   // }

//   // void addSession(WorkoutSession session) {
//   //   if (currentProgram.value != null) {
//   //     final updatedSessions = [...currentProgram.value!.sessions, session];
//   //     currentProgram.value = currentProgram.value!.copyWith(
//   //       sessions: updatedSessions,
//   //     );
//   //   }
//   // }

//     var selectedDay = 0.obs;


//   void changeDay(int day) {
//     selectedDay.value = day;
//   }
// }













// features/trainer/program/controller/program_controller.dart
// features/trainer/program/controller/program_controller.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../model/categories_model.dart';
import '../services/program_services.dart';

class ProgramController extends GetxController {
  final ProgramService service = ProgramService();

  // Text Controllers
  final nameC = TextEditingController();
  final descriptionC = TextEditingController();
  final durationC = TextEditingController();
  final sessionsPerWeekC = TextEditingController();
  final priceC = TextEditingController();
  final maxParticipantsC = TextEditingController();

  // Workout Day Fields
  final exerciseIdC = TextEditingController();
  final setsC = TextEditingController();
  final repsC = TextEditingController();
  final workoutDurationC = TextEditingController();

  // Files
  var thumbnailFile = Rxn<File>();
  var introVideoFile = Rxn<File>();

  // URLs after upload
  var thumbnailUrl = "".obs;
  var videoUrl = "".obs;

  // State
  var isLoading = false.obs;
  var selectedDay = 0.obs;

  // Categories
  var categories = <CategoryModel>[].obs;
  var selectedCategoryId = Rxn<String>();

  final picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    isLoading(true);
    final list = await ProgramService.fetchCategories();
    categories.assignAll(list);
    if (categories.isNotEmpty) selectedCategoryId.value = categories.first.id;
    isLoading(false);
  }

  // Pick Thumbnail
  Future<void> pickThumbnail() async {
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (picked != null) thumbnailFile.value = File(picked.path);
  }

  // Pick Intro Video
  Future<void> pickIntroVideo() async {
    final picked = await picker.pickVideo(source: ImageSource.gallery);
    if (picked != null) introVideoFile.value = File(picked.path);
  }

  void removeThumbnail() => thumbnailFile.value = null;
  void removeIntroVideo() => introVideoFile.value = null;
  void changeDay(int day) => selectedDay.value = day;

  // FINAL SUBMIT
  Future<void> submitProgram() async {
    if (thumbnailFile.value == null) return debugPrint("Required" "Add thumbnail image");
    if (introVideoFile.value == null) return debugPrint("Required" "Add intro video");

    isLoading(true);
    Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);

    try {
      // Upload thumbnail
      final thumb = await service.uploadFile(thumbnailFile.value!);
      if (thumb == null) return;
      thumbnailUrl.value = thumb;

      // Upload intro video
      final vid = await service.uploadFile(introVideoFile.value!);
      if (vid == null) return;
      videoUrl.value = vid;

      // Create program
      final body = {
        "name": nameC.text.trim(),
        "description": descriptionC.text.trim(),
        "categoryId": selectedCategoryId.value,
        "duration": int.tryParse(durationC.text) ?? 4,
        "sessionsPerWeek": int.tryParse(sessionsPerWeekC.text) ?? 3,
        "thumbnailUrl": thumbnailUrl.value,
        "videoUrl": videoUrl.value,
        "price": double.tryParse(priceC.text) ?? 0.0,
        "maxParticipants": int.tryParse(maxParticipantsC.text) ?? 100,
        "workoutDays": [
          {
            "dayNumber": selectedDay.value + 1,
            "sets": int.tryParse(setsC.text) ?? 3,
            "reps": int.tryParse(repsC.text) ?? 12,
            "duration": int.tryParse(workoutDurationC.text) ?? 30,
            "exerciseId": exerciseIdC.text.isEmpty ? "cmi2aqu6p0000qt01m7jd1nzk" : exerciseIdC.text,
            "description": "Day ${selectedDay.value + 1} workout"
          }
        ]
      };

      final success = await service.createProgram(body);
      if (success) {
        Get.back(); // close dialog
        Get.snackbar("Success! 🎉", "Program created!", backgroundColor: Colors.green);
       // Get.offAllNamed('/trainer-dashboard'); // or wherever you want
      }
    } finally {
      isLoading(false);
      if (Get.isDialogOpen == true) Get.back();
    }
  }

  @override
  void onClose() {
    nameC.dispose();
    descriptionC.dispose();
    durationC.dispose();
    sessionsPerWeekC.dispose();
    priceC.dispose();
    maxParticipantsC.dispose();
    exerciseIdC.dispose();
    setsC.dispose();
    repsC.dispose();
    workoutDurationC.dispose();
    super.onClose();
  }
}