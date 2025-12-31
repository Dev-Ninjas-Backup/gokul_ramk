import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

extension DayOfWeekExt on DayOfWeek {
  String get displayName =>
      '${name[0].toUpperCase()}${name.substring(1, 3)}'; // Mon, Tue...
  String get apiName => name.toUpperCase();
  DateTime toDateInUpcomingWeek() {
    final now = DateTime.now();
    final targetWeekday = index + 1; // monday index 0 -> weekday 1
    final todayWeekday = now.weekday;
    int daysToAdd = targetWeekday - todayWeekday;
    if (daysToAdd <= 0) daysToAdd += 7;
    return DateTime(now.year, now.month, now.day + daysToAdd);
  }
}

class AvailabilitySlot {
  final Set<DayOfWeek> days;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  AvailabilitySlot({
    required this.days,
    required this.startTime,
    required this.endTime,
  });

  String formatTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

class AvailabilityController extends GetxController {
  final selectedDays = <DayOfWeek>{}.obs;
  final startTime = const TimeOfDay(hour: 9, minute: 0).obs;
  final endTime = const TimeOfDay(hour: 17, minute: 0).obs;
  final slots = <AvailabilitySlot>[].obs;

  void toggleDay(DayOfWeek day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
  }

  void setStartTime(TimeOfDay t) => startTime.value = t;
  void setEndTime(TimeOfDay t) => endTime.value = t;
  void clearSelectedDays() => selectedDays.clear();

  void addOrUpdateSlot() {
    if (selectedDays.isEmpty) return;
    final newSlot = AvailabilitySlot(
      days: Set.from(selectedDays),
      startTime: startTime.value,
      endTime: endTime.value,
    );

    // Remove slots that share days with the new one (replace)
    slots.removeWhere((s) => s.days.intersection(newSlot.days).isNotEmpty);
    slots.add(newSlot);
    clearSelectedDays();
  }

  void removeSlotAt(int index) => slots.removeAt(index);

  /// Build API payload (one object per day with ISO datetimes)
  List<Map<String, dynamic>> toApiList() {
    final List<Map<String, dynamic>> result = [];
    for (final slot in slots) {
      for (final d in slot.days) {
        final date = d.toDateInUpcomingWeek();

        // Create DateTime with local time
        final startDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          slot.startTime.hour,
          slot.startTime.minute,
        );
        final endDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          slot.endTime.hour,
          slot.endTime.minute,
        );

        result.add({
          "day": d.apiName,
          "startDate": startDateTime.toUtc().toIso8601String(),
          "endDate": endDateTime.toUtc().toIso8601String(),
        });
      }
    }
    return result;
  }

}
