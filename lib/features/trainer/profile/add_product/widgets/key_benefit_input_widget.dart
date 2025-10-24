import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/profile/add_product/controller/add_product_controller.dart';

class KeyBenefitsInputWidget extends StatelessWidget {
  final AddProductController controller = Get.put(AddProductController());

  KeyBenefitsInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...controller.keyBenefits.asMap().entries.map((entry) {
            int index = entry.key;
            String value = entry.value;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Benefit ${index + 1}',
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      onChanged: (val) => controller.updateBenefit(index, val),
                      controller: TextEditingController(text: value)
                        ..selection = TextSelection.fromPosition(
                          TextPosition(offset: value.length),
                        ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => controller.removeBenefit(index),
                  ),
                ],
              ),
            );
          }),

          // Add button
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextButton.icon(
              onPressed: controller.addBenefit,
              icon: const Icon(Icons.add, color: AppColors.primaryButtonColor),
              label: const Text(
                "Add Key Benefit",
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
          ),
        ],
      );
    });
  }
}
