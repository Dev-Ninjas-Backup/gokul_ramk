import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/auth/signup/more_trainer_information/controller/availability_controller.dart';

class AvailabilityScreen extends StatelessWidget {
  AvailabilityScreen({super.key});

  final availabilityController = Get.put(AvailabilityController());

  @override
  Widget build(BuildContext context) {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;

    return CupertinoPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          Text('Set Availability'),

          const SizedBox(height: 10),

          Obx(
            () => Wrap(
              spacing: 10,
              children: DayOfWeek.values.map((day) {
                final selected = availabilityController.selectedDays.contains(
                  day,
                );

                return GestureDetector(
                  onTap: () => availabilityController.toggleDay(day),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? CupertinoColors.activeBlue
                          : CupertinoColors.tertiarySystemFill,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      day.displayName,
                      style: TextStyle(
                        color: selected
                            ? CupertinoColors.white
                            : CupertinoColors.label,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 15),

          // Time pickers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Start time
              Obx(
                () => _timePicker(
                  label: "Start time",
                  timeText: availabilityController.startTime.value.format(
                    context,
                  ),
                  onTap: () async {
                    final time = await showCupertinoTimePicker(
                      widgetRenderBox: renderBox,
                      context,
                      initialTime: availabilityController.startTime.value,
                      onTimeChanged: (t) =>
                          availabilityController.setStartTime(t),
                    );
                    if (time != null) {
                      availabilityController.setStartTime(time);
                    }
                  },
                ),
              ),

              // End time
              Obx(
                () => _timePicker(
                  label: "End time",
                  timeText: availabilityController.endTime.value.format(
                    context,
                  ),
                  onTap: () async {
                    final time = await showCupertinoTimePicker(
                      widgetRenderBox: renderBox,
                      context,
                      initialTime: availabilityController.endTime.value,
                      onTimeChanged: (t) =>
                          availabilityController.setEndTime(t),
                    );
                    if (time != null) {
                      availabilityController.setEndTime(time);
                    }
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Add Availability Button
          // Obx(
          //   () =>

          //   CupertinoButton.filled(
          //     onPressed: availabilityController.selectedDays.isEmpty
          //         ? null
          //         : () {
          //             // final slot = AvailabilitySlot(
          //             //   days: Set.from(availabilityController.selectedDays),
          //             //   startTime: availabilityController.startTime.value,
          //             //   endTime: availabilityController.endTime.value,
          //             // );
          //             availabilityController.addOrUpdateSlot();
          //             availabilityController.clearDays();
          //           },
          //     child: const Text("Add Availability"),
          //   ),
          // ),
          GestureDetector(
            onTap: availabilityController.selectedDays.isEmpty
                ? null
                : () {
                    final slot = AvailabilitySlot(
                      days: Set.from(availabilityController.selectedDays),
                      startTime: availabilityController.startTime.value,
                      endTime: availabilityController.endTime.value,
                    );
                    availabilityController.addOrUpdateSlot();
                    availabilityController.clearDays();
                    if (kDebugMode) {
                      print("==========================Slot=============$slot");
                    }
                  },
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 54, 115, 164),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "Add Availability",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Availability list
          Expanded(
            child: Obx(() {
              final slots = availabilityController.slots;
              if (slots.isEmpty) {
                return const Center(child: Text('No availability added yet'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: slots.length,
                itemBuilder: (context, i) {
                  final slot = slots[i];
                  final daysStr = slot.days
                      .map((d) => d.displayName)
                      .join(", ");

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: CupertinoColors.tertiarySystemBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                daysStr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${slot.startTime.format(context)} – ${slot.endTime.format(context)}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Icon(
                            CupertinoIcons.trash,
                            color: Colors.black,
                          ),
                          onPressed: () => availabilityController.removeSlot(i),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _timePicker({
    required String label,
    required String timeText,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: CupertinoColors.separator),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(timeText),
          ),
        ),
      ],
    );
  }
}
