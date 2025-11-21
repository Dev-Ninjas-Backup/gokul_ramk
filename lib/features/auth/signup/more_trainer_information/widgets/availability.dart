// import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../controller/availability_controller.dart';

// class AvailabilityScreen extends StatelessWidget {
//   AvailabilityScreen({super.key});

//   final controller = Get.put(AvailabilityController());

//   @override
//   Widget build(BuildContext context) {
//     final RenderBox? renderBox = context.findRenderObject() as RenderBox?;

//     return CupertinoPageScaffold(
//       child: SafeArea(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),

//             Align(

//             alignment: AlignmentGeometry.topLeft,
//             child: Text('Set Availability')),
//             SizedBox(height: 16,),

//             // Day chips
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Obx(
//                 () => Wrap(
//                   spacing: 10,
//                   runSpacing: 10,
//                   children: DayOfWeek.values.map((day) {
//                     final isSelected = controller.selectedDays.contains(day);
//                     return GestureDetector(
//                       onTap: () => controller.toggleDay(day),
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 200),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 10,
//                         ),
//                         decoration: BoxDecoration(
//                           color: isSelected
//                               ? CupertinoColors.activeBlue
//                               : CupertinoColors.tertiarySystemFill,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           day.displayName,
//                           style: TextStyle(
//                             color: isSelected
//                                 ? CupertinoColors.white
//                                 : CupertinoColors.label,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 30),

//             // Time pickers
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: _buildTimePicker(context, renderBox, isStart: true),
//                   ),
//                   const SizedBox(width: 20),
//                   Expanded(
//                     child: _buildTimePicker(context, renderBox, isStart: false),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 30),

//             // Add button
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Obx(
//                 () => CupertinoButton.filled(
//                   onPressed: controller.selectedDays.isEmpty
//                       ? null
//                       : controller.addOrUpdateSlot,
//                   child: const Text("Add Availability"),
//                 ),
//               ),
//             ),

//             //   Optional: Debug button (remove in production)
//             // CupertinoButton(
//             //   child: Text("Print API JSON"),
//             //   onPressed: controller.printApiPayload,
//             // ),
//             const SizedBox(height: 20),

//             // List of added slots
//             Expanded(
//               child: Obx(() {
//                 if (controller.slots.isEmpty) {
//                   return const Center(child: Text('No availability added yet'));
//                 }
//                 return ListView.builder(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: controller.slots.length,
//                   itemBuilder: (_, i) {
//                     final slot = controller.slots[i];
//                     final daysStr = slot.days
//                         .map((d) => d.displayName)
//                         .join(', ');

//                     return Card(
//                       margin: const EdgeInsets.only(bottom: 12),
//                       color: CupertinoColors.tertiarySystemBackground
//                           .resolveFrom(context),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: ListTile(
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 4,
//                         ),
//                         title: Text(
//                           daysStr,
//                           style: const TextStyle(fontWeight: FontWeight.w600),
//                         ),
//                         subtitle: Text(
//                           '${slot.startTime.format(context)} – ${slot.endTime.format(context)}',
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                         trailing: CupertinoButton(
//                           padding: EdgeInsets.zero,
//                           child: const Icon(
//                             CupertinoIcons.trash,
//                             color: CupertinoColors.destructiveRed,
//                           ),
//                           onPressed: () => controller.removeSlot(i),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTimePicker(
//     BuildContext context,
//     RenderBox? renderBox, {
//     required bool isStart,
//   }) {
//     return Obx(() {
//       final time = isStart
//           ? controller.startTime.value
//           : controller.endTime.value;
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             isStart ? "Start time" : "End time",
//             style: const TextStyle(fontSize: 14),
//           ),
//           const SizedBox(height: 8),
//           CupertinoButton(
//             padding: EdgeInsets.zero,
//             onPressed: () async {
//               final picked = await showCupertinoTimePicker(
//                 context,
//                 widgetRenderBox: renderBox,
//                 initialTime: time,
//               );
//               if (picked != null) {
//                 isStart
//                     ? controller.setStartTime(picked)
//                     : controller.setEndTime(picked);
//               }
//             },
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(vertical: 14),
//               decoration: BoxDecoration(
//                 border: Border.all(color: CupertinoColors.separator),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               alignment: Alignment.center,
//               child: Text(
//                 time.format(context),
//                 style: const TextStyle(fontSize: 18),
//               ),
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }

import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/availability_controller.dart';

class AvailabilityScreen extends StatelessWidget {
  AvailabilityScreen({super.key});
  final controller = Get.find<AvailabilityController>();

  @override
  Widget build(BuildContext context) {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Availability'),
        const SizedBox(height: 8),
        Obx(
          () => Wrap(
            spacing: 10,
            runSpacing: 8,
            children: DayOfWeek.values.map((d) {
              final selected = controller.selectedDays.contains(d);
              return GestureDetector(
                onTap: () => controller.toggleDay(d),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    d.displayName,
                    style: TextStyle(
                      color: selected ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _timePicker(context, renderBox, isStart: true)),
            const SizedBox(width: 16),
            Expanded(child: _timePicker(context, renderBox, isStart: false)),
          ],
        ),
        const SizedBox(height: 12),
        Obx(
          () => ElevatedButton(
            onPressed: controller.selectedDays.isEmpty
                ? null
                : controller.addOrUpdateSlot,
            child: const Text("Add Availability"),
          ),
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (controller.slots.isEmpty) {
            return const Text("No availability added yet");
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.slots.length,
            itemBuilder: (context, i) {
              final slot = controller.slots[i];
              final days = slot.days.map((d) => d.displayName).join(", ");
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  title: Text(days),
                  subtitle: Text(
                    '${slot.startTime.format(context)} – ${slot.endTime.format(context)}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => controller.removeSlotAt(i),
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _timePicker(
    BuildContext context,
    RenderBox? renderBox, {
    required bool isStart,
  }) {
    final controller = Get.find<AvailabilityController>();
    return Obx(() {
      final t = isStart ? controller.startTime.value : controller.endTime.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isStart ? 'Start time' : 'End time'),
          const SizedBox(height: 6),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              final picked = await showCupertinoTimePicker(
                context,
                widgetRenderBox: renderBox,
                initialTime: t,
              );
              if (picked != null) {
                isStart
                    ? controller.setStartTime(picked)
                    : controller.setEndTime(picked);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(t.format(context)),
            ),
          ),
        ],
      );
    });
  }
}
