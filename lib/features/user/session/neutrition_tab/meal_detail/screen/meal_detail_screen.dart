import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/meal_detail/controller/meal_detail_controller.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/meal_detail/widget/ingredient_item_widget.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/meal_detail/widget/nutrition_info_card.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/meal_detail/widget/similar_meal_widget.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/meal_detail/widget/step_item_widget.dart';

class MealDetailScreen extends StatelessWidget {
  final MealDetailController controller = Get.put(MealDetailController());

  MealDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Error: ${controller.errorMessage.value}',
                  style: getTextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: Text('Go Back'),
                ),
              ],
            ),
          );
        }

        if (controller.meal.value == null) {
          return Center(child: Text('No meal data available'));
        }

        final meal = controller.meal.value!;
        return SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBarTitle(title: meal.title),
                  const SizedBox(height: 20),
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: meal.image.isNotEmpty
                        ? Image.network(
                            meal.image,
                            width: double.maxFinite,
                            height: 180,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.maxFinite,
                                height: 180,
                                color: Colors.grey.shade200,
                                child: Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey.shade400,
                                    size: 64,
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            width: double.maxFinite,
                            height: 180,
                            color: Colors.grey.shade200,
                            child: Center(
                              child: Icon(
                                Icons.image,
                                color: Colors.grey.shade400,
                                size: 64,
                              ),
                            ),
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
                                    value: meal.vitamins.join(", "),
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

                        // Preparation Steps
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
                          children: meal.preparation
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
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Obx(
                        //         () => ElevatedButton(
                        //           onPressed: controller.isCreatingMealPlan.value
                        //               ? null
                        //               : () => controller.createMealPlan(),
                        //           style: ElevatedButton.styleFrom(
                        //             backgroundColor: Colors.green.withValues(
                        //               alpha: 0.1,
                        //             ),
                        //             foregroundColor: Colors.green.shade700,
                        //             padding: const EdgeInsets.symmetric(
                        //               vertical: 14,
                        //             ),
                        //           ),
                        //           child: controller.isCreatingMealPlan.value
                        //               ? SizedBox(
                        //                   height: 20,
                        //                   width: 20,
                        //                   child: CircularProgressIndicator(
                        //                     strokeWidth: 2,
                        //                     valueColor:
                        //                         AlwaysStoppedAnimation<Color>(
                        //                           Colors.green,
                        //                         ),
                        //                   ),
                        //                 )
                        //               : Text(
                        //                   "Add to Meal Plan",
                        //                   style: getTextStyle(
                        //                     fontSize: 16,
                        //                     color: Colors.green,
                        //                     fontWeight: FontWeight.w600,
                        //                   ),
                        //                 ),
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(width: 12),
                        //     Expanded(
                        //       child: ElevatedButton(
                        //         onPressed: () {},
                        //         style: ElevatedButton.styleFrom(
                        //           backgroundColor: Colors.green,
                        //           padding: const EdgeInsets.symmetric(
                        //             vertical: 14,
                        //           ),
                        //         ),
                        //         child: Text(
                        //           "Share with Trainer",
                        //           style: getTextStyle(
                        //             fontSize: 16,
                        //             color: Colors.white,
                        //             fontWeight: FontWeight.w600,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(height: 30),

                        // Similar Meals
                        Text(
                          "Similar Meals You May Like",
                          style: getTextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Obx(() {
                          if (controller.isLoadingSimilarMeals.value) {
                            return SizedBox(
                              height: 290,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          if (controller.similarMeals.isEmpty) {
                            return SizedBox(
                              height: 290,
                              child: Center(
                                child: Text('No similar meals available'),
                              ),
                            );
                          }
                          return SizedBox(
                            height: 290,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.similarMeals.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(width: 12),
                                itemBuilder: (context, index) {
                                  final similarMeal =
                                      controller.similarMeals[index];
                                  return GestureDetector(
                                    onTap: () async {
                                      await controller.fetchMealDetail(
                                        similarMeal.id,
                                      );
                                      await controller.fetchSimilarMeals();
                                    },
                                    child: SimilarMealWidget(
                                      title: similarMeal.title,
                                      image: similarMeal.image,
                                      desc: similarMeal.description,
                                      onViewDetails: () async {
                                        await controller.fetchMealDetail(
                                          similarMeal.id,
                                        );
                                        await controller.fetchSimilarMeals();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }),
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
