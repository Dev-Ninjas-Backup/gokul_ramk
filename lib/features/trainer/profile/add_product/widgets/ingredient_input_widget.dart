// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/profile/add_product/controller/add_product_controller.dart';

class IngredientsInputWidget extends StatelessWidget {
  final AddProductController controller = Get.put(AddProductController());

  IngredientsInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          ...controller.ingredients.asMap().entries.map((entry) {
            int index = entry.key;
            var item = entry.value;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                children: [
                  // Label field
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Label (e.g. Protein)',
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      onChanged: (val) =>
                          controller.updateIngredient(index, "label", val),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Value field
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Value (e.g. 25g)',
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      onChanged: (val) =>
                          controller.updateIngredient(index, "value", val),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Delete button
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () => controller.removeIngredient(index),
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
              onPressed: controller.addIngredient,
              icon: const Icon(Icons.add, color: AppColors.primaryButtonColor),
              label: const Text(
                "Add Ingredient",
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
          ),
        ],
      );
    });
  }
}
