// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/bookings/my_bookings/model/booking_session_model.dart';
import 'package:gokul_ramk/features/trainer/bookings/repository/booking_repository.dart';

class BookingSessionController extends GetxController {
  late BookingRepository bookingRepository;
  var sessions = <BookingSessionModel>[].obs;
  var isLoadingSessions = false.obs;
  var currentPage = 1.obs;
  var pageLimit = 10.obs;
  var hasMoreSessions = true.obs;

  @override
  void onInit() {
    super.onInit();
    final networkClient = Get.find<NetworkClient>();
    bookingRepository = BookingRepository(networkClient: networkClient);
    fetchSessions();
  }

  Future<void> fetchSessions({int page = 1, int limit = 10}) async {
    if (isLoadingSessions.value) return;

    try {
      isLoadingSessions.value = true;
      final fetchedSessions = await bookingRepository.getBookings(
        page: page,
        limit: limit,
      );

      if (page == 1) {
        sessions.value = fetchedSessions;
      } else {
        sessions.addAll(fetchedSessions);
      }

      currentPage.value = page;
      hasMoreSessions.value = fetchedSessions.length >= limit;
      print('Fetched ${fetchedSessions.length} bookings');
    } catch (e) {
      print('Error fetching bookings: $e');
      Get.snackbar('Error', 'Failed to load bookings');
    } finally {
      isLoadingSessions.value = false;
    }
  }

  Future<void> loadMoreSessions() async {
    if (!hasMoreSessions.value || isLoadingSessions.value) return;
    await fetchSessions(page: currentPage.value + 1, limit: pageLimit.value);
  }

  Future<void> refreshSessions() async {
    currentPage.value = 1;
    hasMoreSessions.value = true;
    sessions.clear();
    await fetchSessions();
  }

  Future<void> markComplete(int index) async {
    if (index >= 0 && index < sessions.length) {
      final session = sessions[index];
      try {
        final result = await bookingRepository.markBookingComplete(session.id);
        final success = result['success'] as bool;
        final message = result['message'] as String;

        if (success) {
          Get.snackbar('Success', message);
          // Refresh the sessions list
          await refreshSessions();
        } else {
          Get.snackbar('Error', message);
        }
      } catch (e) {
        print('Error marking complete: $e');
        Get.snackbar('Error', 'An error occurred: $e');
      }
    }
  }

  Future<void> markConfirm(String bookingId) async {
    try {
      final result = await bookingRepository.markBookingConfirm(bookingId);
      final success = result['success'] as bool;
      final message = result['message'] as String;

      if (success) {
        Get.snackbar('Success', message);
        // Refresh the sessions list
        await refreshSessions();
      } else {
        Get.snackbar('Error', message);
      }
    } catch (e) {
      print('Error marking confirm: $e');
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
