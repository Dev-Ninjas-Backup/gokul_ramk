import 'package:get/get.dart';

class ProgressFilterController extends GetxController {
  var selectedFilter = "This Week".obs;

  final filters = ["This Week", "Last Week", "This Month"];

  final Map<String, Map<String, dynamic>> progressData = {
    "This Week": {
      "goalPercent": 65,
      "circlePercent": 0.60,
      "steps": "5,320 / 8,000",
      "workoutTime": "32 min",
      "calories": "420 kcal",
    },
    "Last Week": {
      "goalPercent": 50,
      "circlePercent": 0.45,
      "steps": "4,200 / 8,000",
      "workoutTime": "25 min",
      "calories": "350 kcal",
    },
    "This Month": {
      "goalPercent": 72,
      "circlePercent": 0.70,
      "steps": "22,500 / 32,000",
      "workoutTime": "2 hr",
      "calories": "1680 kcal",
    },
  };

  void updateFilter(String value) {
    selectedFilter.value = value;
    Get.back();
  }

  Map<String, dynamic> get currentData => progressData[selectedFilter.value]!;
}
