// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/bookings/my_bookings/model/booking_session_model.dart';
import 'package:gokul_ramk/features/trainer/bookings/repository/booking_repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookingDetailsController extends GetxController {
  late BookingRepository bookingRepository;
  late NetworkClient networkClient;
  var booking = Rxn<BookingSessionModel>();
  var userProfileImage = Rxn<String>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    networkClient = Get.find<NetworkClient>();
    bookingRepository = BookingRepository(networkClient: networkClient);
  }

  Future<void> fetchBookingDetails(String bookingId) async {
    try {
      isLoading.value = true;
      final fetchedBooking = await bookingRepository.getBookingById(bookingId);
      if (fetchedBooking != null) {
        booking.value = fetchedBooking;
        print('Fetched booking details: ${fetchedBooking.id}');

        // Fetch user profile image
        await fetchUserProfileImage(fetchedBooking.user.id);
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

  /// Fetch user profile to get their profile image
  Future<void> fetchUserProfileImage(String userId) async {
    try {
      final token = await networkClient.sharedPreferencesHelper
          .getAccessToken();
      final response = await http.get(
        Uri.parse(Urls.getUserProfile(userId)),
        headers: {
          'Authorization': token ?? '',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        if (decodedData is Map && decodedData['data'] != null) {
          final userData = decodedData['data'] as Map<String, dynamic>;
          final images = userData['images'] as String?;
          if (images != null && images.isNotEmpty) {
            userProfileImage.value = images;
            print('Fetched user profile image: $images');
          }
        }
      }
    } catch (e) {
      print('Error fetching user profile image: $e');
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
