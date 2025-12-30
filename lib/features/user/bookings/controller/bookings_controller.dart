import 'package:get/get.dart';
import '../model/booking_model.dart';
import '../service/bookings_service.dart';

class BookingsController extends GetxController {
  var bookings = <BookingModel>[].obs;
  var isLoading = false.obs;
  var filterStatus = 'ALL'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    try {
      isLoading.value = true;
      final res = await BookingsService.fetchBookings();
      if (res.isSuccess && res.responseData != null) {
        final data = res.responseData!['data'];
        if (data is List) {
          bookings.value = data
              .map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      }
    } catch (e) {
      print('fetchBookings controller error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> cancelBooking(String bookingId) async {
    try {
      isLoading.value = true;
      final res = await BookingsService.cancelBooking(bookingId);
      if (res.isSuccess) {
        // remove from local list or mark as cancelled
        bookings.removeWhere((b) => b.id == bookingId);
        return true;
      } else {
        Get.snackbar(
          'Cancel Failed',
          res.errorMessage ?? 'Could not cancel booking',
        );
        return false;
      }
    } catch (e) {
      print('cancelBooking controller error: $e');
      Get.snackbar('Error', e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  List<BookingModel> get filteredBookings {
    if (filterStatus.value == 'ALL') return bookings;
    return bookings.where((b) => b.status == filterStatus.value).toList();
  }
}
