// booking_service.dart
// Service to create a booking
// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';

class BookingService {
  static Future<NetworkResponse> createBooking(
    Map<String, dynamic> body,
  ) async {
    try {
      final client = Get.find<NetworkClient>();
      final url = Urls.getBookings;
      final res = await client.postRequest(url: url, body: body);
      return res;
    } catch (e) {
      print('createBooking error: $e');
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
        statusCode: -1,
      );
    }
  }
}
