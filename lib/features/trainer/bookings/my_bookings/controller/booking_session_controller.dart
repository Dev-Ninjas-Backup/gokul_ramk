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

  void markComplete(int index) {
    if (index >= 0 && index < sessions.length) {
      final session = sessions[index];
      // Update only the UI status
      sessions[index] = BookingSessionModel(
        id: session.id,
        userId: session.userId,
        trainerId: session.trainerId,
        mode: session.mode,
        duration: session.duration,
        scheduledDate: session.scheduledDate,
        scheduledTime: session.scheduledTime,
        endTime: session.endTime,
        location: session.location,
        notes: session.notes,
        status: 'COMPLETED',
        price: session.price,
        currency: session.currency,
        advancePayment: session.advancePayment,
        assignedProgram: session.assignedProgram,
        cancelledAt: session.cancelledAt,
        cancelledBy: session.cancelledBy,
        cancellationReason: session.cancellationReason,
        completedAt: DateTime.now(),
        createdAt: session.createdAt,
        updatedAt: DateTime.now(),
        user: session.user,
        trainer: session.trainer,
        payment: session.payment,
      );
    }
  }
}
