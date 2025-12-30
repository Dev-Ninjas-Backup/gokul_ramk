import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookTrainerController extends GetxController {
  // Observable selected value
  var selectedTrainingDays = 1.obs;
  RxBool trainingDayForMonthSelected = false.obs;

  // Options for dropdown
  final List<int> trainingDaysOptions = [1, 2, 3, 4, 5, 6];

  var selectedDates = <DateTime>[].obs;

  // Booking mode: ONLINE, ONSITE, OFFSIDE
  var mode = 'ONLINE'.obs;

  void onDateSelected(DateTime date) {
    if (selectedDates.any(
      (d) => d.year == date.year && d.month == date.month && d.day == date.day,
    )) {
      selectedDates.removeWhere(
        (d) =>
            d.year == date.year && d.month == date.month && d.day == date.day,
      );
    } else {
      selectedDates.add(date);
    }
  }

  String get selectedDatesText {
    if (selectedDates.isEmpty) return "";
    final formatter = DateFormat("E, MMM d"); // Example: Sat, Mar 16
    return selectedDates.map((d) => formatter.format(d)).join(", ");
  }

  /// Return first selected date formatted as yyyy-MM-dd for booking payload
  String get scheduledDate {
    if (selectedDates.isEmpty) return '';
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(selectedDates.first);
  }

  /// 👇 Make startTime reactive
  var startTime = <Map<String, dynamic>>[
    {'time': '09:00 AM', 'isSelected': true},
    {'time': '10:00 AM', 'isSelected': false},
    {'time': '12:00 PM', 'isSelected': false},
  ].obs;

  /// Getter for selected start time
  String get selectedStartTime {
    final selected = startTime.firstWhere(
      (item) => item['isSelected'] == true,
      orElse: () => {'time': ''},
    );
    return selected['time'] ?? '';
  }

  var duration = 3.obs;

  void incrementDuration() => duration.value++;
  void decrementDuration() {
    if (duration.value > 1) duration.value--;
  }
}
