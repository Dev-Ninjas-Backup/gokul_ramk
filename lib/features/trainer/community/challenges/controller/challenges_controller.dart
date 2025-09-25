import 'package:get/get.dart';

class ChallengesController extends GetxController {
  var events = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadEvents();
  }

  void loadEvents() {
    events.value = [
      {"title": "10K Steps Daily for 30 Days"},
      {"title": "No Sugar Challenge for 7 Days"},
      {"title": "Plank 30 days for 2 Minutes"},
    ];
  }
}
