import 'package:get/get.dart';

class EventsController extends GetxController {
  var events = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadEvents();
  }

  void loadEvents() {
    events.value = [
      {"title": "Virtual Zumba Party", "date": "Sat, Sep 7 – 7:00PM"},
      {"title": "HIIT with Coach Gokul", "date": "Mon, Sep 9 – 6:00AM"},
      {"title": "Healthy Meal Prep Workshop", "date": "Sep 12 – Online"},
    ];
  }
}
