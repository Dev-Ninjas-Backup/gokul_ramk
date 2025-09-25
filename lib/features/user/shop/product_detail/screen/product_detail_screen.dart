import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/user/session/neutrition_tab/meal_detail/widget/nutrition_info_card.dart';
import 'package:gokul_ramk/features/user/shop/categories/widget/shop_category_widget.dart';
import 'package:gokul_ramk/features/user/shop/controller/shop_controller.dart';
import 'package:gokul_ramk/features/user/shop/product_detail/widget/add_to_cart_dialog.dart';
import 'package:gokul_ramk/features/user/shop/product_detail/widget/key_benefit_item.dart';
import 'package:gokul_ramk/features/user/shop/product_detail/widget/product_quantity_selector.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key});

  final ShopController controller = Get.put(ShopController());
  final String title = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBarTitle(title: title),
              const SizedBox(height: 20),

              Image.asset(Imagepath.proteinBottle),
              const SizedBox(height: 10),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Text('4.8', style: getTextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Price & Quantity Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$49.99",
                    style: getTextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ProductQuantitySelector(),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                "Description:",
                style: getTextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 6),
              Text(
                "Fuel your workouts with premium quality Whey Protein Isolate. Each serving delivers 25g of fast-absorbing protein...",
                style: getTextStyle(color: Colors.black87),
              ),
              const SizedBox(height: 16),

              // Key Benefits
              Text(
                "Key Benefits-",
                style: getTextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              KeyBenefitItem(icon: "💪", text: "Promotes lean muscle growth"),
              KeyBenefitItem(
                icon: "⚡",
                text: "Fast-digesting for quick recovery",
              ),
              KeyBenefitItem(icon: "🍫", text: "Delicious chocolate flavor"),
              KeyBenefitItem(icon: "🚫", text: "Zero added sugar, gluten-free"),
              const SizedBox(height: 20),

              // Ingredients Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      "Ingredients",
                      style: getTextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Whey Protein Isolate, Cocoa Powder,\nNatural Flavors, Stevia",
                      textAlign: TextAlign.center,
                      style: getTextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Nutrition Info
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: NutritionInfoCard(label: "Protein", value: "25g"),
                  ),
                  Expanded(
                    child: NutritionInfoCard(label: "Carbs", value: "2g"),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: NutritionInfoCard(label: "Fat", value: "1g"),
                  ),
                  Expanded(
                    child: NutritionInfoCard(label: "Calories", value: "120"),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              TwoButtonWidget(),
              const SizedBox(height: 26),
              Text(
                'Recommended For You',
                style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

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
    );
  }
}

class TwoButtonWidget extends StatelessWidget {
  const TwoButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () => AddToCartDialog.show(
              onTapContinue: () {
                Get.back();
              },
              onTapViewCart: () {
                Get.toNamed(AppRoute.getUserCartScreen());
              },
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.withValues(alpha: 0.1),
            ),
            child: Text(
              "Add to Cart",
              style: getTextStyle(
                color: Colors.blue,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text(
              "Buy Now",
              style: getTextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
