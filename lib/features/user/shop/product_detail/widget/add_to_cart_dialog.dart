import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToCartDialog {
  static void show({
    required VoidCallback onTapContinue,
    required VoidCallback onTapViewCart,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ✅ Circle with shop
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),

              // title
              const Text(
                "Item Added to Your Cart ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),

              // subtitle
              const Text(
                "Your product has been successfully added. You can review it in your cart or keep shopping for more essentials.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // Go to Homepage button
              Column(
                spacing: 12,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: onTapViewCart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.withValues(alpha: 0.1),
                        foregroundColor: Colors.green,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 12,
                        children: [
                          Icon(Icons.shopify_rounded),
                          Text('View Cart'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: onTapContinue,
                      child: const Text(
                        "Continue Shopping",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
