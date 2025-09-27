import 'package:get/get.dart';

class ProgressFilterController extends GetxController {
  var selectedFilter = "This Week".obs;

  final filters = ["This Week", "Last Week", "This Month"];

  final Map<String, Map<String, dynamic>> progressData = {
    "This Week": {
      "goalPercent": 65,
      "circlePercent": 0.60,
      "program covered": "120/180mins",
      "workoutTime": "32 min",
      "calories": "420/1000 kcal",
    },
    "Last Week": {
      "goalPercent": 50,
      "circlePercent": 0.45,
      "program covered": "80/180mins",
      "workoutTime": "25 min",
      "calories": "350/1000 kcal",
    },
    "This Month": {
      "goalPercent": 72,
      "circlePercent": 0.70,
      "program covered": "180/180mins",
      "workoutTime": "2 hr",
      "calories": "980/1000kcal",
    },
  };

  void updateFilter(String value) {
    selectedFilter.value = value;
  }

  Map<String, dynamic> get currentData => progressData[selectedFilter.value]!;
}
