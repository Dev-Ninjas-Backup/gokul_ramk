import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/controller/tell_about_youselt_controller.dart';
import 'package:gokul_ramk/routes/app_routes.dart';
import 'package:http/http.dart' as http;

class TellAboutYouseltService {
  SharedPreferencesHelperController pref = SharedPreferencesHelperController();

  Future<void> submitOnboarding(TellAboutYouseltController controller) async {
    const String apiUrl = Urls.tellAboutOnboarding;

    final String? token = await pref.getAccessToken();

    if (token == null || token.isEmpty) {
      EasyLoading.showError(
        "Error ,Missing or invalid token. Please login again.",
      );
      return;
    }

    final selectedGoals = controller.goals
        .where((g) => g.isSelected)
        .map((g) => g.title.replaceAll(' ', '_'))
        .toList();

    String trainingDays = "";
    final selectedTraining = controller.trainingDays.firstWhereOrNull(
      (t) => t.isSelected,
    );
    if (selectedTraining != null) {
      if (selectedTraining.title.contains("1-2")) {
        trainingDays = "One_To_Two_Days";
      } else if (selectedTraining.title.contains("2-3")) {
        trainingDays = "Two_To_Three_Days";
      } else {
        trainingDays = "Daily";
      }
    }

    final body = {
      "nationality": controller.nationality.text,
      "city": controller.city.text,
      "gender": controller.selectedGender.value ?? '',
      "age": int.tryParse(controller.age.text) ?? 0,
      "height": int.tryParse(controller.height.text) ?? 0,
      "weight": int.tryParse(controller.weight.text) ?? 0,
      "heartCondition": controller.heartCondition.value,
      "chestPain": controller.chestPain.value,
      "medication": controller.medication.value,
      "hasInjuries": controller.hasInjuries.value,
      "hasDizziness": controller.hasDizziness.value,
      "hasSurgery": controller.hasSurgery.value,
      "goals": selectedGoals,
      "trainingDays": trainingDays,
      "signature": controller.signature.text,
      "date": controller.date.text,
    };

    try {
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json", "Authorization": token},
        body: jsonEncode(body),
      );

      final data = jsonDecode(response.body);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          data["success"] == true) {
        EasyLoading.showSuccess(data["message"]);

        Get.offAllNamed(AppRoute.bookTrainerScreen);
      } else {
        EasyLoading.showError(data["message"] ?? "Update failed");
      }
    } catch (e) {
      EasyLoading.showError("Error ==============, ${e.toString()}");
    }
  }
}
