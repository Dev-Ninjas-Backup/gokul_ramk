import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/model/goal_model.dart';
import 'package:gokul_ramk/features/auth/signup/more_user_information_screen/model/trining_days_model.dart';
import 'package:intl/intl.dart';

class TellAboutYouseltController extends GetxController {
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  final heartConditionController = TextEditingController();
  final chestPainController = TextEditingController();
  final medicationController = TextEditingController();
  final injuryController = TextEditingController();
  final dizzyController = TextEditingController();
  final pastSurgeryController = TextEditingController();
  final signatureController = TextEditingController();
  final dateController = TextEditingController();

  var selectedGender = RxnString();

  var goals = <Goal>[
    Goal(title: "Lose Weight", emoji: "⚡"),
    Goal(title: "Build Muscle", emoji: "💪"),
    Goal(title: "Improve Endurance", emoji: "🏃"),
    Goal(title: "Gain Flexibility", emoji: "🧘"),
    Goal(title: "Improve Overall Health", emoji: "🌱"),
  ].obs;

  void toggleGoal(int index) {
    goals[index].isSelected = !goals[index].isSelected;
    goals.refresh();
  }

  var traingDays = <TrainingDays>[
    TrainingDays(title: "Want to train 1-2 days in a week"),
    TrainingDays(title: "Want to train 2-3 days in a week"),
    TrainingDays(title: "Want to train daily"),
  ].obs;

  void toggleTrainingDays(int index) {
    traingDays[index].isSelected = !traingDays[index].isSelected;
    traingDays.refresh();
  }

  var selectedDate = Rxn<DateTime>();
  Future<void> pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate == null) {
      return;
    } else {
      selectedDate.value = pickedDate;
      dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
    }
  }

}
