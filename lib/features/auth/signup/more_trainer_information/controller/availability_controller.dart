// import 'package:flutter/material.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';

// // ---------------------------------------------------------
// // ADD THE ENUM HERE (inside the controller file)
// // ---------------------------------------------------------
// enum DayOfWeek {
//   monday,
//   tuesday,
//   wednesday,
//   thursday,
//   friday,
//   saturday,
//   sunday;

//   String get displayName =>
//       '${name[0].toUpperCase()}${name.substring(1).substring(0, 2)}';
// }

// // ---------------------------------------------------------
// // UI Controller
// // ---------------------------------------------------------
// class AvailabilityUiController {
//   final selectedDays = <DayOfWeek>{}.obs;
//   final startTime = const TimeOfDay(hour: 9, minute: 0).obs;
//   final endTime = const TimeOfDay(hour: 17, minute: 0).obs;

//   void toggleDay(DayOfWeek day) {
//     if (selectedDays.contains(day)) {
//       selectedDays.remove(day);
//     } else {
//       selectedDays.add(day);
//     }
//     selectedDays.refresh();
//   }

//   void setStartTime(TimeOfDay t) {
//     startTime.value = t;
//   }

//   void setEndTime(TimeOfDay t) {
//     endTime.value = t;
//   }

//   void clearDays() {
//     selectedDays.clear();
//     selectedDays.refresh();
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Enum for days of the week
enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  String get displayName =>
      '${name[0].toUpperCase()}${name.substring(1).substring(0, 2)}';
}

/// Model for one availability slot
class AvailabilitySlot {
  final Set<DayOfWeek> days;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  AvailabilitySlot({
    required this.days,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toApiJson({required DateTime sampleDate}) {
    final dateStr =
        "${sampleDate.year}-${sampleDate.month.toString().padLeft(2, '0')}-${sampleDate.day.toString().padLeft(2, '0')}";
    return {
      "day": days.first.name.toUpperCase(),
      "startDate": "$dateStr ${_timeToString(startTime)}:00.000Z",
      "endDate": "$dateStr ${_timeToString(endTime)}:00.000Z",
    };
  }

  String _timeToString(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
}

/// Main controller for availability (UI + data)
class AvailabilityController extends GetxController {
  // Reactive UI fields
  final selectedDays = <DayOfWeek>{}.obs;
  final startTime = const TimeOfDay(hour: 9, minute: 0).obs;
  final endTime = const TimeOfDay(hour: 17, minute: 0).obs;

  // List of slots
  final slots = <AvailabilitySlot>[].obs;

  /// Toggle selected day
  void toggleDay(DayOfWeek day) {
    if (selectedDays.contains(day)) {
      selectedDays.remove(day);
    } else {
      selectedDays.add(day);
    }
  }

  /// Set start time
  void setStartTime(TimeOfDay t) {
    startTime.value = t;
  }

  /// Set end time
  void setEndTime(TimeOfDay t) {
    endTime.value = t;
  }

  /// Clear selected days
  void clearDays() {
    selectedDays.clear();
  }

  /// Add a new slot or update overlapping ones
  void addOrUpdateSlot() {
    if (selectedDays.isEmpty) return;

    final slot = AvailabilitySlot(
      days: Set.from(selectedDays),
      startTime: startTime.value,
      endTime: endTime.value,
    );

    // Remove any slot with overlapping days
    slots.removeWhere(
      (s) => s.days.intersection(slot.days).isNotEmpty,
    );

    slots.add(slot);
    clearDays();
  }

  /// Remove slot by index
  void removeSlot(int index) {
    slots.removeAt(index);
  }

  /// Convert all slots to API-ready list (one entry per day)
  List<Map<String, dynamic>> toApiList() {
    final now = DateTime.now();
    final sampleDate = DateTime(now.year, now.month + 1, 1);
    final List<Map<String, dynamic>> result = [];

    for (final slot in slots) {
      for (final day in slot.days) {
        final tempSlot = AvailabilitySlot(
          days: {day},
          startTime: slot.startTime,
          endTime: slot.endTime,
        );
        result.add(tempSlot.toApiJson(sampleDate: sampleDate));
      }
    }
    return result;
  }
}
