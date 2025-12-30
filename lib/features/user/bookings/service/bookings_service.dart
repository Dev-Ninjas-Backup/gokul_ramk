import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';

class BookingsService {
  static Future<NetworkResponse> fetchBookings() async {
    try {
      final client = Get.find<NetworkClient>();
      final res = await client.getRequest(url: Urls.getBookings);
      return res;
    } catch (e) {
      print('fetchBookings error: $e');
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
        statusCode: -1,
      );
    }
  }

  /// Cancel a booking by id. Uses DELETE /bookings/{id}
  static Future<NetworkResponse> cancelBooking(String bookingId) async {
    try {
      final client = Get.find<NetworkClient>();
      final url = "${Urls.getBookings}/$bookingId";
      final res = await client.deleteRequest(url);
      return res;
    } catch (e) {
      print('cancelBooking error: $e');
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
        statusCode: -1,
      );
    }
  }
}
