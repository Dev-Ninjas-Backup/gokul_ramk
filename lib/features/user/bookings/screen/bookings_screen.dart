import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/bookings_controller.dart';
import '../model/booking_model.dart';

class BookingsScreen extends StatelessWidget {
  BookingsScreen({super.key});

  final BookingsController controller = Get.put(BookingsController());

  final List<String> statuses = [
    'ALL',
    'PENDING',
    'CONFIRMED',
    'CANCELLED',
    'COMPLETED',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Obx(() {
              return Row(
                children: [
                  const Text('Filter:'),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButton<String>(
                      value: controller.filterStatus.value,
                      isExpanded: true,
                      items: statuses
                          .map(
                            (s) => DropdownMenuItem(value: s, child: Text(s)),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v != null) controller.filterStatus.value = v;
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              final list = controller.filteredBookings;
              if (list.isEmpty) {
                return const Center(child: Text('No bookings found'));
              }
              return ListView.separated(
                itemCount: list.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final BookingModel b = list[index];
                  final bool canCancel =
                      b.status == 'PENDING' || b.status == 'CONFIRMED';
                  return ListTile(
                    title: Text(
                      b.trainerName.isNotEmpty
                          ? b.trainerName
                          : 'Unknown Trainer',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text('Duration: ${b.duration} mins'),
                        const SizedBox(height: 4),
                        Text('Location: ${b.location ?? 'N/A'}'),
                        const SizedBox(height: 4),
                        if (b.scheduledDate != null)
                          Text(
                            'Date: ${b.scheduledDate} ${b.scheduledTime ?? ''}',
                          ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Chip(
                          label: Text(b.status),
                          backgroundColor: _statusColor(b.status),
                        ),
                        if (canCancel) ...[
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            tooltip: 'Cancel booking',
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text('Cancel booking'),
                                  content: const Text(
                                    'Are you sure you want to cancel this booking?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(false),
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(ctx).pop(true),
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                ),
                              );
                              if (confirm == true) {
                                final ok = await controller.cancelBooking(b.id);
                                if (ok) {
                                  Get.snackbar(
                                    'Cancelled',
                                    'Booking cancelled successfully',
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ],
                    ),
                    onTap: () {
                      // Future: open booking details
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'PENDING':
        return Colors.orange.shade200;
      case 'CONFIRMED':
        return Colors.blue.shade200;
      case 'CANCELLED':
        return Colors.red.shade200;
      case 'COMPLETED':
        return Colors.green.shade200;
      default:
        return Colors.grey.shade200;
    }
  }
}
