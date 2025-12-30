// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/bookings/my_bookings/model/booking_session_model.dart';
import 'package:gokul_ramk/features/trainer/bookings/repository/booking_repository.dart';

class BookingDetailsController extends GetxController {
  late BookingRepository bookingRepository;
  var booking = Rxn<BookingSessionModel>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final networkClient = Get.find<NetworkClient>();
    bookingRepository = BookingRepository(networkClient: networkClient);
  }

  Future<void> fetchBookingDetails(String bookingId) async {
    try {
      isLoading.value = true;
      final fetchedBooking = await bookingRepository.getBookingById(bookingId);
      if (fetchedBooking != null) {
        booking.value = fetchedBooking;
        print('Fetched booking details: ${fetchedBooking.id}');
      } else {
        Get.snackbar('Error', 'Failed to load booking details');
      }
    } catch (e) {
      print('Error fetching booking details: $e');
      Get.snackbar('Error', 'An error occurred while loading booking details');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markComplete(String bookingId) async {
    try {
      final result = await bookingRepository.markBookingComplete(bookingId);
      final success = result['success'] as bool;
      final message = result['message'] as String;

      if (success) {
        Get.snackbar('Success', message);
        Future.delayed(Duration(seconds: 1), () {
          Get.back();
        });
      } else {
        Get.snackbar('Error', message);
      }
    } catch (e) {
      print('Error marking complete: $e');
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  void reschedule(String bookingId) {
    // Implement reschedule logic
    print('Rescheduling booking $bookingId');
  }
}
