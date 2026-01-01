import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/user/bookings/service/bookings_service.dart';
// session service no longer required here; HomeController reads metadata from sessions endpoint via NetworkClient
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/features/user/user_profile/service/user_profile_service.dart';

class HomeController extends GetxController {
  var pendingCount = 0.obs;
  // Active clients count = number of CONFIRMED bookings
  var confirmedCount = 0.obs;
  var isLoading = false.obs;
  // total sessions count returned by sessions endpoint
  var totalSessionsCount = 0.obs;
  // Available balance from user profile (earnedAmount)
  var availableBalance = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPendingCount();
    fetchTotalSessions();
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
    fetchTotalSessions();
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
  /// Fetch sessions endpoint metadata and set total sessions count.
  /// Uses the same sessions endpoint but reads the `total` field from the response payload.
  Future<void> fetchTotalSessions({int page = 1, int limit = 10}) async {
    try {
      isLoading.value = true;
      final client = Get.find<NetworkClient>();
      final url = '${Urls.createSession}?page=$page&limit=$limit';
      final res = await client.getRequest(url: url);

      if (res.isSuccess && res.responseData != null) {
        final dataObj = res.responseData!['data'];
        if (dataObj is Map && dataObj['total'] != null) {
          try {
            final t = (dataObj['total'] as num).toInt();
            totalSessionsCount.value = t;
          } catch (_) {
            // fallback: if total is string
            totalSessionsCount.value =
                int.tryParse(dataObj['total']?.toString() ?? '') ?? 0;
          }
        } else if (dataObj is List) {
          totalSessionsCount.value = dataObj.length;
        }
      }
    } catch (e) {
      if (kDebugMode) print('fetchTotalSessions error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Return up to [limit] recent sessions sorted by startDate (ascending).
  /// If no sessions have a startDate, fall back to sorting by createdAt (desc).
  // Removed upcoming session helpers: we now rely on API 'total' to show total sessions.

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
