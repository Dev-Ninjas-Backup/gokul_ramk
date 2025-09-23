import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/user/session/controller/session_controller.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/model/comunity_food_model.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/model/nutition_model.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/model/nutrition_goal_food_model.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/widget/community_food_widget.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/widget/nutrition_goal_food_item.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/widget/top_meal_item.dart';
import 'package:gokul_ramk/features/user/user_home/widget/neutrition_card.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class NutritionTab extends StatelessWidget {
  NutritionTab({super.key});
  final SessionController controller = Get.find<SessionController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NeutritionCard(),

        const SizedBox(height: 12),

        /// Top Trainers Section
        Text(
          "Top Meals Picked by Our Nutritionists",
          style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.topMealNutrition.length,
            separatorBuilder: (_, __) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              final TopMealNutritionModel model =
                  controller.topMealNutrition[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    AppRoute.getMealDetailScreen(),
                    arguments: model.name,
                  );
                },
                child: TopMealItem(topMeal: controller.topMealNutrition[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 10),

        /// Top Trainers Section
        Text(
          "Goal-Based Collections",
          style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          itemCount: controller.neutritionGoalCollection.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final NutritionGoalFoodModel model =
                controller.neutritionGoalCollection[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: NutritionGoalFoodItem(
                onTap: () => Get.toNamed(
                  AppRoute.planDetailScreen,
                  arguments: model.title,
                ),
                foodModel: controller.neutritionGoalCollection[index],
              ),
            );
          },
        ),

        const SizedBox(height: 10),

        /// Top Trainers Section
        Text(
          "Community Recipes & Challenges",
          style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ListView.builder(
          itemCount: controller.communityFoodList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final ComunityFoodModel model = controller.communityFoodList[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: CommunityFood(
                title: model.title,
                image: model.image,
                buttonText: model.buttonText,
              ),
            );
          },
        ),
      ],
    );
  }
}
