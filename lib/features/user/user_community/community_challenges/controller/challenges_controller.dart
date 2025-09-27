import 'package:get/get.dart';

class UserChallengesController extends GetxController {
  var events = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadEvents();
  }

  void loadEvents() {
    events.value = [
      {"title": "10K Steps Daily for 30 Days", 'joined': true, 'progress': 70.0},
      {
        "title": "No Sugar Challenge for 7 Days",
        'joined': false,
        'progress': 0.0,
      },
      {"title": "Plank 30 days for 2 Minutes", 'joined': false, 'progress': 0.0},
      {"title": "10K Steps Daily for 30 Days", 'joined': true, 'progress': 30.0},
      {"title": "10K Steps Daily for 30 Days", 'joined': true, 'progress': 90.0},
    ];
  }
}
