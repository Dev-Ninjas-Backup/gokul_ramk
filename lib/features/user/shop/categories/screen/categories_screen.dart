import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/features/user/shop/categories/widget/shop_category_widget.dart';
import 'package:gokul_ramk/features/user/shop/controller/shop_controller.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  final String title = Get.arguments;

  final ShopController controller = Get.put(ShopController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              spacing: 16,
              children: [
                CustomAppBarTitle(title: title),
                const SizedBox(height: 20),
                CategoryTextField(controller: controller),

                const SizedBox(height: 10),

                TitleOntapSeeAllWidget(
                  title: '🔥 Best Sellers',
                  onTapSeeAll: () {},
                ),

                SizedBox(
                  height: 380,
                  child: ListView.builder(
                    itemCount: controller.products.length > 4
                        ? 4
                        : controller.products.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final product = controller.products[index];
                      return ShopCategoryWidget(
                        product: product,
                        onAddToCart: () {},
                        onBuyNow: () {},
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                TitleOntapSeeAllWidget(
                  title: '💪 For Muscle Growth',
                  onTapSeeAll: () {},
                ),

                SizedBox(
                  height: 380,
                  child: ListView.builder(
                    itemCount: controller.products.length > 4
                        ? 4
                        : controller.products.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final product = controller.products[index];
                      return ShopCategoryWidget(
                        product: product,
                        onAddToCart: () {},
                        onBuyNow: () {},
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),

                TitleOntapSeeAllWidget(
                  title: '🌿 Vitamins & Wellness',
                  onTapSeeAll: () {},
                ),

                SizedBox(
                  height: 380,
                  child: ListView.builder(
                    itemCount: controller.products.length > 4
                        ? 4
                        : controller.products.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final product = controller.products[index];
                      return ShopCategoryWidget(
                        product: product,
                        onAddToCart: () {},
                        onBuyNow: () {},
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TitleOntapSeeAllWidget extends StatelessWidget {
  TitleOntapSeeAllWidget({super.key, required this.title, this.onTapSeeAll});

  final String title;
  VoidCallback? onTapSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: getTextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        GestureDetector(
          onTap: onTapSeeAll,
          child: Text('See all', style: getTextStyle(color: Colors.blueAccent)),
        ),
      ],
    );
  }
}

class CategoryTextField extends StatelessWidget {
  const CategoryTextField({super.key, required this.controller});

  final ShopController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller.categorySearchController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        hintText: 'Search Protein, Pre-Workout, Recovery, Vitamins',
        hintStyle: TextStyle(fontSize: 12),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.all(12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}
