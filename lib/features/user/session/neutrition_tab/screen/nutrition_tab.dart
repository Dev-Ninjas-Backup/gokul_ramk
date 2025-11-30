import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/user/session/controller/session_controller.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/model/nutition_model.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/model/nutrition_goal_food_model.dart';
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

        /// Top Meals Section
        Text(
          "Top Meals Picked by Our Nutritionists",
          style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (controller.isLoadingMeals.value) {
            return SizedBox(
              height: 150,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (controller.mealError.value.isNotEmpty) {
            return SizedBox(
              height: 150,
              child: Center(
                child: Text(
                  'Error: ${controller.mealError.value}',
                  style: getTextStyle(color: Colors.red),
                ),
              ),
            );
          }
          if (controller.meals.isEmpty) {
            return SizedBox(
              height: 150,
              child: Center(child: Text('No meals available')),
            );
          }
          return SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.meals.length,
              separatorBuilder: (_, __) => const SizedBox(width: 20),
              itemBuilder: (context, index) {
                final meal = controller.meals[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      AppRoute.getMealDetailScreen(),
                      arguments: meal.id,
                    );
                  },
                  child: TopMealItem(
                    topMeal: TopMealNutritionModel(
                      name: meal.title,
                      image: meal.image,
                    ),
                  ),
                );
              },
            ),
          );
        }),
        const SizedBox(height: 10),

        /// Goal-Based Collections Section
        Text(
          "Goal-Based Collections",
          style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Obx(() {
          if (controller.isLoadingMealPlans.value) {
            return SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (controller.mealPlanError.value.isNotEmpty) {
            return SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  'Error: ${controller.mealPlanError.value}',
                  style: getTextStyle(color: Colors.red),
                ),
              ),
            );
          }
          if (controller.mealPlans.isEmpty) {
            return SizedBox(
              height: 200,
              child: Center(child: Text('No meal plans available')),
            );
          }
          return ListView.builder(
            itemCount: controller.mealPlans.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final mealPlan = controller.mealPlans[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: NutritionGoalFoodItem(
                  onTap: () => Get.toNamed(
                    AppRoute.planDetailScreen,
                    arguments: mealPlan.id,
                  ),
                  foodModel: NutritionGoalFoodModel(
                    title: mealPlan.title,
                    subTitle: mealPlan.goal,
                    imageUrl: mealPlan.image,
                    buttonText: 'Explore Plan',
                  ),
                ),
              );
            },
          );
        }),
        const SizedBox(height: 10),

        /// Top Trainers Section
        // Text(
        //   "Community Recipes & Challenges",
        //   style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        // ),
        // const SizedBox(height: 12),
        // ListView.builder(
        //   itemCount: controller.communityFoodList.length,
        //   shrinkWrap: true,
        //   physics: NeverScrollableScrollPhysics(),
        //   itemBuilder: (context, index) {
        //     final ComunityFoodModel model = controller.communityFoodList[index];
        //     return Padding(
        //       padding: const EdgeInsets.only(bottom: 16),
        //       child: CommunityFood(
        //         title: model.title,
        //         image: model.image,
        //         buttonText: model.buttonText,
        //       ),
        //     );
        //   },
        // ),
      ],
    );
  }
}
