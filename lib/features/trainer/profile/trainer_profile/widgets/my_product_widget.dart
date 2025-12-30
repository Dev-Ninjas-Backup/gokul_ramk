import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/controller/trainer_profile_controller.dart';
import 'package:gokul_ramk/features/trainer/profile/my_products/model/product_model.dart';
import 'package:gokul_ramk/features/trainer/profile/my_products/screen/my_products_screen.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class MyProductsWidget extends StatelessWidget {
  final TrainerProfileController controller =
      Get.isRegistered<TrainerProfileController>()
      ? Get.find<TrainerProfileController>()
      : Get.put(TrainerProfileController());

  MyProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Products",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => MyProductsScreen());
                },
                child: Text("See all"),
              ),
            ],
          ),
        ),
        Obx(() {
          if (controller.products.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  "No products yet",
                  style: getTextStyle(color: Colors.grey),
                ),
              ),
            );
          }
          return Column(
            children: controller.products
                .map((product) => _productCard(product, context))
                .toList(),
          );
        }),
        SizedBox(height: 12),
        _addProductCard(),
      ],
    );
  }

  Widget _productCard(Product p, BuildContext context) {
    String imageThumbnail = p.thumbnail.isNotEmpty ? p.thumbnail[0] : '';
    bool isValidImageUrl =
        imageThumbnail.isNotEmpty && imageThumbnail.trim() != " ";

    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.productDetails, arguments: p);
      },
      child: Card(
        color: AppColors.background,
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: isValidImageUrl
                    ? Image.network(
                        imageThumbnail,
                        width: 80,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 80,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.image_not_supported),
                          );
                        },
                      )
                    : Container(
                        width: 80,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.image_not_supported),
                      ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.name,
                      style: getTextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text("Stock: ${p.stock}", style: getTextStyle()),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: p.verified == "Pending"
                            ? Colors.orange.shade50
                            : Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        p.verified,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: p.verified == "Pending"
                              ? Colors.orange
                              : Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              Text(
                "\$${p.price.toStringAsFixed(0)}",
                style: getTextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addProductCard() {
    return Card(
      elevation: 1,
      color: AppColors.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Submit your product to sell in the marketplace. Admin will review before approval.",
              textAlign: TextAlign.center,
              style: getTextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                Get.toNamed(AppRoute.addProducts);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text(
                  "Add Product",
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.background,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
