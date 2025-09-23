import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/meal_detail/controller/meal_detail_controller.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/meal_detail/widget/ingredient_item_widget.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/meal_detail/widget/meal_tag_widget.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/meal_detail/widget/nutrition_info_card.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/meal_detail/widget/similar_meal_widget.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/meal_detail/widget/step_item_widget.dart';

class MealDetailScreen extends StatelessWidget {
  final MealDetailController controller = Get.put(MealDetailController());

  MealDetailScreen({super.key});

  final String name = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final meal = controller.meal.value;
        return SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBarTitle(title: name),
                  const SizedBox(height: 20),
                  // Image
                  Container(
                    width: double.maxFinite,
                    height: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(meal.image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: meal.tags
                              .map((t) => MealTagWidget(text: t))
                              .toList(),
                        ),
                        const SizedBox(height: 20),

                        // Nutrition Section
                        Column(
                          spacing: 16,
                          children: [
                            Row(
                              spacing: 12,
                              children: [
                                Expanded(
                                  child: NutritionInfoCard(
                                    label: "Calories",
                                    value: "${meal.calories} kcal",
                                  ),
                                ),
                                Expanded(
                                  child: NutritionInfoCard(
                                    label: "Protein",
                                    value: "${meal.protein}g",
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: NutritionInfoCard(
                                    label: "Vitamins",
                                    value: meal.vitamins,
                                    highlight: true,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 12,
                              children: [
                                Expanded(
                                  child: NutritionInfoCard(
                                    label: "Carbs",
                                    value: "${meal.carbs}g",
                                  ),
                                ),
                                Expanded(
                                  child: NutritionInfoCard(
                                    label: "Fats",
                                    value: "${meal.fats}g",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Ingredients
                        const Text(
                          "Ingredients List-",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: meal.ingredients
                              .map((i) => IngredientItemWidget(text: i))
                              .toList(),
                        ),
                        const SizedBox(height: 20),

                        // Steps
                        Text(
                          "Preparation Steps-",
                          style: getTextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: meal.steps
                              .asMap()
                              .entries
                              .map(
                                (e) =>
                                    StepItemWidget(index: e.key, text: e.value),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 20),

                        // Buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.withValues(
                                    alpha: 0.1,
                                  ),
                                  foregroundColor: Colors.green.shade700,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                                child: const Text("Add to Meal Plan"),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                ),
                                child: Text("Share with Trainer"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // Similar Meals
                        Text(
                          "Similar Meals You May Like",
                          style: getTextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 270,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: controller.similarMeals
                                  .map(
                                    (m) => SimilarMealWidget(
                                      title: m["title"]!,
                                      image: m["image"]!,
                                      desc: m["desc"]!,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
