import 'package:get/get.dart';

class UserEventsController extends GetxController {
  var events = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadEvents();
  }

  void loadEvents() {
    events.value = [
      {
        "title": "Virtual Zumba Party",
        "date": "Sat, Sep 7 - 7:00PM",
        "isOnline": true,
        "location": "",
        "organizedBy":"Gokul Ram"
      },
      {
        "title": "HIIT with Coach Gokul",
        "date": "Mon, Sep 9 - 6:00AM",
        "isOnline": false,
        "location": "Dubai, UAE",
        "organizedBy": "Gokul Ram"
      },
      {
        "title": "Healthy Meal Prep Workshop",
        "date": "Sep 12 - Online",
        "isOnline": true,
        "location": "",
        "organizedBy": "Gokul Ram"
      },
    ];
  }
}
