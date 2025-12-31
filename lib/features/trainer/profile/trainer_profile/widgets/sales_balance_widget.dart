import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/controller/trainer_profile_controller.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/service/withdraw_service.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class SalesAndBalanceWidget extends StatelessWidget {
  final TrainerProfileController controller = Get.put(
    TrainerProfileController(),
  );

  SalesAndBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sales summary",
                style: getTextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              _dropdownFilter(),
            ],
          ),
        ),
        Obx(() {
          return _summaryCard(
            title:
                "Revenue: \$${controller.totalRevenue.value.toStringAsFixed(0)}",
            subtitle:
                "Total products sold: ${controller.totalProductsSold.value}",
            buttonText: "View Details",
            color: Color(0XFF60BF7B),
            background: Color(0XFFEFF9F2),
            onTap: () {
              Get.toNamed(AppRoute.productDetails);
            },
          );
        }),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Balance",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              // _dropdownFilter(),
            ],
          ),
        ),
        Obx(() {
          return _summaryCard(
            title: "Balance: \$${controller.balance.value.toStringAsFixed(2)}",
            subtitle: "",

            // "Total products sold: ${controller.totalProductsSold.value}",
            buttonText: "Request Payout",
            color: Color(0XFF148CBB),
            background: Color(0XFFE8F4F8),
            onTap: () async {
              final SharedPreferencesHelperController prefs = Get.find();
              final userId = await prefs.getUserId();
              if (userId == null) {
                Get.snackbar('Error', 'User not logged in');
                return;
              }

              final TextEditingController amountCtrl = TextEditingController();
              bool submitting = false;

              await showDialog<void>(
                // ignore: use_build_context_synchronously
                context: context,
                builder: (ctx) => StatefulBuilder(
                  builder: (ctx, setState) => AlertDialog(
                    title: const Text('Request Payout'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: amountCtrl,
                          keyboardType: TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Amount',
                            hintText: 'Enter amount to withdraw',
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Use local state from StatefulBuilder (submitting) instead of Obx
                        submitting
                            ? const CircularProgressIndicator()
                            : const SizedBox.shrink(),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          final txt = amountCtrl.text.trim();
                          final amt = double.tryParse(txt);
                          if (amt == null || amt <= 0) {
                            Get.snackbar('Invalid', 'Enter a valid amount');
                            return;
                          }
                          setState(() => submitting = true);
                          final res = await WithdrawService.requestWithdraw(
                            userId: userId,
                            amount: amt,
                          );
                          setState(() => submitting = false);
                          if (res.isSuccess) {
                            // update local balance
                            controller.balance.value =
                                (controller.balance.value - amt).clamp(
                                  0,
                                  double.infinity,
                                );
                            Get.back(); // close dialog
                            final message =
                                res.responseData != null &&
                                    res.responseData['message'] != null
                                ? res.responseData['message']
                                : 'Withdraw request created';
                            Get.snackbar('Success', message.toString());
                          } else {
                            final err = res.errorMessage ?? 'Request failed';
                            Get.snackbar('Error', err);
                          }
                        },
                        child: const Text('Send'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }

  Widget _dropdownFilter() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(
            "This Month",
            style: getTextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  Widget _summaryCard({
    required String title,
    required String subtitle,
    required String buttonText,
    required Color color,
    required Color background,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: background,
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Text(
              title,
              style: getTextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryFontColor,
              ),
            ),
            SizedBox(height: 4),
            Text(
              subtitle,
              style: getTextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    color: AppColors.background,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
