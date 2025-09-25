import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/user/shop/controller/shop_controller.dart';

class ProductQuantitySelector extends StatelessWidget {
  final ShopController controller = Get.put(ShopController());

  ProductQuantitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6,
          children: [
            CircleAvatar(
              backgroundColor: Colors.green.withValues(alpha: 0.1),
              child: IconButton(
                onPressed: controller.decrease,
                icon: const Icon(Icons.remove),
              ),
            ),
            Text(
              controller.quantity.value.toString(),
              style: getTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CircleAvatar(
              backgroundColor: Colors.green.withValues(alpha: 0.1),
              child: IconButton(
                onPressed: controller.increase,
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
