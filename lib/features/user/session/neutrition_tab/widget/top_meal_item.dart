import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/model/nutition_model.dart';

class TopMealItem extends StatelessWidget {
  final TopMealNutritionModel topMeal;
  const TopMealItem({super.key, required this.topMeal});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 31,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: topMeal.image.isNotEmpty
                ? NetworkImage(topMeal.image)
                : null,
            child: topMeal.image.isEmpty
                ? Icon(
                    Icons.image_not_supported,
                    color: Colors.grey.shade400,
                    size: 32,
                  )
                : null,
          ),
          const SizedBox(height: 6),
          Text(
            textAlign: TextAlign.center,
            topMeal.name,
            style: getTextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
