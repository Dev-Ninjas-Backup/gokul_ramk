import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/trainer/bookings/my_bookings/model/booking_session_model.dart';

class BookingSessionController extends GetxController {
  var sessions = <BookingSessionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSessions();
  }

  void fetchSessions() {
    sessions.value = [
      BookingSessionModel(
        name: "Alex Carter",
        imageUrl: Imagepath.trainer,
        sessionType: "Personal Training",
        dateTime: DateTime(2025, 9, 4, 18, 30),
        status: SessionStatus.upcoming,
      ),
      BookingSessionModel(
        name: "Alex Carter",
        imageUrl: Imagepath.trainer,
        sessionType: "Yoga Class",
        dateTime: DateTime(2025, 9, 5, 18, 30),
        status: SessionStatus.upcoming,
      ),
      BookingSessionModel(
        name: "Alex Carter",
        imageUrl: Imagepath.trainer,
        sessionType: "Nutrition Coaching",
        dateTime: DateTime(2025, 9, 6, 20, 0),
        status: SessionStatus.cancelled,
      ),
    ];
  }

  void markComplete(int index) {
    sessions[index] = BookingSessionModel(
      name: sessions[index].name,
      imageUrl: sessions[index].imageUrl,
      sessionType: sessions[index].sessionType,
      dateTime: sessions[index].dateTime,
      status: SessionStatus.completed,
    );
  }
}
