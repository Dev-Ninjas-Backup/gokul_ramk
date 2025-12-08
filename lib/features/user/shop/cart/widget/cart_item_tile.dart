import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/user/shop/cart/controller/cart_controller.dart';

class CartItemTile extends StatelessWidget {
  final int index;

  CartItemTile({super.key, required this.index});

  final CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final item = controller.cartList[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                controller.cartList.isNotEmpty == true
                    ? item.product!.thumbnail!.first
                    : 'https://via.placeholder.com/150',
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.broken_image_outlined, size: 70),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name & Delete Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.product?.name ?? '',
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await controller.deteleCart(
                            item.product!.id.toString(),
                          );
                          await controller.getCart();
                        },
                        // onPressed: () => controller.removeItem(item),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Price & Quantity Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${item.product?.price ?? 0}",
                        style: getTextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => controller.decreaseItemQty(item),
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text(
                            '${item.quantity ?? 0}',
                            style: getTextStyle(fontSize: 16),
                          ),
                          IconButton(
                            onPressed: () => controller.increaseItemQty(item),
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
