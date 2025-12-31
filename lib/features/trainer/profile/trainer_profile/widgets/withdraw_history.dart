import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/controller/trainer_profile_controller.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/model/withdraw_model.dart';

class WithdrawHistoryScreen extends StatelessWidget {
  final TrainerProfileController controller = Get.put(
    TrainerProfileController(),
  );

  WithdrawHistoryScreen({super.key});

  final RxString _selected = 'ALL'.obs;

  List<String> get _statuses => ['ALL', 'PENDING', 'APPROVED', 'REJECTED'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Withdraw History')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Obx(() {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _statuses.map((s) {
                    final selected = _selected.value == s;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: ChoiceChip(
                        label: Text(s),
                        selected: selected,
                        onSelected: (_) {
                          _selected.value = s;
                          // refetch with status filter (except ALL)
                          controller.fetchWithdrawHistory(
                            page: controller.withdrawPage.value,
                            limit: controller.withdrawLimit.value,
                            status: s == 'ALL' ? null : s,
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
            const SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                final items = controller.withdrawHistory
                    .where(
                      (w) => _selected.value == 'ALL'
                          ? true
                          : w.status == _selected.value,
                    )
                    .toList();

                if (items.isEmpty) {
                  return const Center(
                    child: Text('No withdraw history available.'),
                  );
                }

                return ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final WithdrawModel withdraw = items[index];
                    final dateStr =
                        withdraw.createdAt !=
                            DateTime.fromMillisecondsSinceEpoch(0)
                        ? withdraw.createdAt
                              .toLocal()
                              .toString()
                              .split('.')
                              .first
                        : '';
                    return ListTile(
                      title: Text('\$${withdraw.amount.toStringAsFixed(2)}'),
                      subtitle: Text('Date: $dateStr'),
                      trailing: Text(withdraw.status),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
