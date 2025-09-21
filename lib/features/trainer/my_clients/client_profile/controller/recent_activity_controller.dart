import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';

class RecentActivityController extends GetxController {
  var activities = <Map<String, dynamic>>[].obs;
  var showAll = false.obs;

  @override
  void onInit() {
    super.onInit();

    activities.value = [
      {
        "title": "HIIT Training",
        "subtitle": "Today, 9:30 AM",
        "value": "45 min",
        "color": 0xFFE3F2FD,
        "icon": Image.asset(IconPath.hiitTraining),
      },
      {
        "title": "Logged Breakfast",
        "subtitle": "Today, 8:15 AM",
        "value": "320 Cal",
        "color": 0xFFE8F5E9,
        "icon": Image.asset(IconPath.loggedBreakfast),
      },
      {
        "title": "Weekly Check-in",
        "subtitle": "Yesterday, 6:00 PM",
        "value": "Completed",
        "color": 0xFFE3F2FD,
        "icon": Image.asset(IconPath.weeklyCheckIn),
      },
      {
        "title": "Yoga Session",
        "subtitle": "Yesterday, 7:00 AM",
        "value": "30 min",
        "color": 0xFFFFF3E0,
        "icon": Image.asset(IconPath.loggedBreakfast),
      },
      {
        "title": "Logged Lunch",
        "subtitle": "Yesterday, 1:00 PM",
        "value": "450 Cal",
        "color": 0xFFF1F8E9,
        "icon": Image.asset(IconPath.weeklyCheckIn),
      },
    ];
  }
}
