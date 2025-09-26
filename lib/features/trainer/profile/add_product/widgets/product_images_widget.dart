import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/add_product_controller.dart';

class ProductImagesSection extends StatelessWidget {
  final AddProductController controller;

  const ProductImagesSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Main product image
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade200,
          ),
          clipBehavior: Clip.hardEdge,
          child: Obx(
            () => controller.images.isNotEmpty
                ? Image.asset(controller.images.first, fit: BoxFit.cover)
                : Center(
                    child: Icon(Icons.image, size: 50, color: Colors.grey),
                  ),
          ),
        ),
        SizedBox(height: 10),

        /// Thumbnails + Add button
        SizedBox(
          height: 80,
          child: Obx(
            () => ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.images.length + 1,
              separatorBuilder: (_, __) => SizedBox(width: 10),
              itemBuilder: (context, index) {
                if (index < controller.images.length) {
                  return Container(
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade200,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      controller.images[index],
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  /// Add new image button
                  return GestureDetector(
                    onTap: controller.addImage,
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: Icon(Icons.add, size: 30, color: Colors.grey),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
