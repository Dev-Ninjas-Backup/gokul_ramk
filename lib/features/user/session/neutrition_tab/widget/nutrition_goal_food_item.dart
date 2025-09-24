import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/model/nutrition_goal_food_model.dart';

// ignore: must_be_immutable
class NutritionGoalFoodItem extends StatelessWidget {
  final NutritionGoalFoodModel foodModel;
  VoidCallback? onTap;
  NutritionGoalFoodItem({super.key, required this.foodModel,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 3,
            color: Colors.grey.shade100,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              foodModel.imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodModel.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  foodModel.subTitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text(
                    foodModel.buttonText,
                    style: getTextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
