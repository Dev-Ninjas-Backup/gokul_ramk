import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/user/bookings/service/bookings_service.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/session_screen/service/session_service.dart';
import 'package:gokul_ramk/features/user/user_profile/service/user_profile_service.dart';

class HomeController extends GetxController {
  var pendingCount = 0.obs;
  // Active clients count = number of CONFIRMED bookings
  var confirmedCount = 0.obs;
  var isLoading = false.obs;
  // upcoming sessions (startDate matched to today or tomorrow)
  var upcomingSessionsCount = 0.obs;
  // store sessions list fetched from API
  var sessionsList = <Map<String, dynamic>>[].obs;
  // Available balance from user profile (earnedAmount)
  var availableBalance = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPendingCount();
    fetchUpcomingSessions();
    fetchAvailableBalance();
  }

  Timer? _refreshTimer;

  @override
  void onReady() {
    super.onReady();
    // start a periodic refresh so the dashboard auto-updates
    _refreshTimer ??= Timer.periodic(Duration(seconds: 60), (_) {
      _refreshAll();
    });
  }

  void _refreshAll() {
    // fire-and-forget refreshes; they each handle their own errors
    fetchPendingCount();
    fetchUpcomingSessions();
    fetchAvailableBalance();
  }

  Future<void> fetchPendingCount() async {
    try {
      isLoading.value = true;
      final res = await BookingsService.fetchBookings();
      if (res.isSuccess && res.responseData != null) {
        final data = res.responseData!['data'];
        if (data is List) {
          int pending = 0;
          int confirmed = 0;
          for (final e in data) {
            try {
              final status = (e as Map<String, dynamic>)['status']?.toString();
              if (status == 'PENDING') pending++;
              if (status == 'CONFIRMED') confirmed++;
            } catch (_) {
              // ignore malformed item
            }
          }
          pendingCount.value = pending;
          confirmedCount.value = confirmed;
        }
      }
    } catch (e) {
      if (kDebugMode) print('fetchPendingCount error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch sessions and count those with startDate equal to today or tomorrow.
  Future<void> fetchUpcomingSessions({int page = 1, int limit = 50}) async {
    try {
      isLoading.value = true;
      final fetched = await SessionService.fetchSessions(
        page: page,
        limit: limit,
      );
      // store sessions (normalize to Map)
      sessionsList.value = fetched.map((e) {
        if (e is Map<String, dynamic>) return e;
        return Map<String, dynamic>.from(e);
      }).toList();

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final tomorrow = today.add(Duration(days: 1));

      int count = 0;
      for (final item in fetched) {
        try {
          if (item is Map<String, dynamic>) {
            final sd = item['startDate'];
            if (sd == null) continue;
            final dt = DateTime.tryParse(sd.toString());
            if (dt == null) continue;
            final local = dt.toLocal();
            final dOnly = DateTime(local.year, local.month, local.day);
            if (dOnly == today || dOnly == tomorrow) count++;
          }
        } catch (_) {}
      }
      upcomingSessionsCount.value = count;
    } catch (e) {
      if (kDebugMode) print('fetchUpcomingSessions error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Return up to [limit] recent sessions sorted by startDate (ascending).
  /// If no sessions have a startDate, fall back to sorting by createdAt (desc).
  List<Map<String, dynamic>> recentSessions({int limit = 2}) {
    final withStart = sessionsList
        .where((s) => s['startDate'] != null)
        .toList();
    if (withStart.isNotEmpty) {
      withStart.sort((a, b) {
        final da =
            DateTime.tryParse(a['startDate'].toString()) ??
            DateTime.fromMillisecondsSinceEpoch(0);
        final db =
            DateTime.tryParse(b['startDate'].toString()) ??
            DateTime.fromMillisecondsSinceEpoch(0);
        return da.compareTo(db);
      });
      return withStart.take(limit).toList();
    }

    // If no sessions have a startDate, return an empty list (do not fallback to createdAt)
    return <Map<String, dynamic>>[];
  }

  /// Format session date string similar to existing UI: "Today, 10:00 AM" or "Tomorrow, 2:00 PM" or "MM/dd, h:mm AM"
  String formatSessionDate(Map<String, dynamic> session) {
    String? raw =
        session['startDate']?.toString() ?? session['createdAt']?.toString();
    if (raw == null) return '';
    final dt = DateTime.tryParse(raw);
    if (dt == null) return '';
    final local = dt.toLocal();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(Duration(days: 1));
    final dOnly = DateTime(local.year, local.month, local.day);
    final hour = local.hour % 12 == 0 ? 12 : local.hour % 12;
    final minute = local.minute.toString().padLeft(2, '0');
    final ampm = local.hour >= 12 ? 'PM' : 'AM';
    final timePart = '$hour:$minute $ampm';
    if (dOnly == today) return 'Today, $timePart';
    if (dOnly == tomorrow) return 'Tomorrow, $timePart';
    return '${local.month}/${local.day}, $timePart';
  }

  /// Fetch user profile and set availableBalance from earnedAmount
  Future<void> fetchAvailableBalance() async {
    try {
      isLoading.value = true;
      final res = await UserProfileService.fetchProfile();
      if (res.isSuccess && res.responseData != null) {
        final body = res.responseData!['data'] ?? res.responseData!;
        if (body is Map<String, dynamic>) {
          final earned = (body['earnedAmount'] as num?)?.toDouble();
          if (earned != null) availableBalance.value = earned;
        }
      }
    } catch (e) {
      if (kDebugMode) print('fetchAvailableBalance error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
    super.onClose();
  }
}
