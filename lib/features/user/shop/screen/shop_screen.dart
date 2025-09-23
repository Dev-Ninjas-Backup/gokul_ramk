import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';
import 'package:gokul_ramk/features/user/shop/widget/categories_item_widget.dart';
import 'package:gokul_ramk/features/user/shop/widget/shop_banner_widget.dart';
import 'package:gokul_ramk/features/user/shop/widget/shop_product_widget.dart';
import '../controller/shop_controller.dart';

class ShopScreen extends StatelessWidget {
  ShopScreen({super.key});

  final ShopController controller = Get.put(ShopController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shop",
                    style: getTextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(IconPath.shopIcon),
                  ),
                ],
              ),
              ShopBannerWidget(),
              const SizedBox(height: 16),
              Text(
                "Categories",
                style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: controller.categories
                        .map(
                          (cat) => CategoriesItemWidget(
                            icon: cat["icon"]!,
                            title: cat["title"]!,
                            onTap: () {},
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Featured Products",
                style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Obx(
                () => Column(
                  children: controller.products
                      .map(
                        (product) => ShopProductWidget(
                          product: product,
                          onAddToCart: () {},
                          onBuyNow: () {},
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
