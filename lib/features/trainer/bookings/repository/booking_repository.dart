// ignore_for_file: avoid_print, unnecessary_cast

import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/bookings/my_bookings/model/booking_session_model.dart';

class BookingRepository {
  final NetworkClient networkClient;

  BookingRepository({required this.networkClient});

  Future<List<BookingSessionModel>> getBookings({
    required int page,
    required int limit,
  }) async {
    try {
      final url = '${Urls.getBookings}?page=$page&limit=$limit';
      final response = await networkClient.getRequest(url: url);

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData;
        List<dynamic> bookingsList = [];

        if (data is List) {
          bookingsList = data as List<dynamic>;
        } else if (data is Map<String, dynamic>) {
          if (data.containsKey('data')) {
            final dataField = data['data'];
            if (dataField is List) {
              bookingsList = dataField;
            }
          }
        }

        final validBookingMaps = bookingsList
            .whereType<Map<String, dynamic>>()
            .toList();
        return validBookingMaps
            .map((booking) => BookingSessionModel.fromJson(booking))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error fetching bookings: $e');
      return [];
    }
  }

  Future<BookingSessionModel?> getBookingById(String bookingId) async {
    try {
      final url = '${Urls.getBookings}/$bookingId';
      final response = await networkClient.getRequest(url: url);

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData;
        if (data is Map<String, dynamic>) {
          // Check if response has a 'data' wrapper
          if (data.containsKey('data')) {
            return BookingSessionModel.fromJson(
              data['data'] as Map<String, dynamic>,
            );
          } else {
            return BookingSessionModel.fromJson(data);
          }
        }
      }
      return null;
    } catch (e) {
      print('Error fetching booking: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> markBookingComplete(String bookingId) async {
    try {
      final url = Urls.completeBooking(bookingId);
      final response = await networkClient.patchRequest(url: url, body: {});
      return {
        'success': response.isSuccess,
        'message': response.errorMessage ?? 'Booking marked as completed',
      };
    } catch (e) {
      print('Error marking booking complete: $e');
      return {'success': false, 'message': e.toString()};
    }
  }
}
