import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/user/shop/controller/shop_controller.dart';

class MyOrdersScreen extends StatelessWidget {
  MyOrdersScreen({super.key});

  final controller = Get.find<ShopController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Orders"),
        backgroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.orders.isEmpty) {
          return const Center(child: Text("No orders found"));
        }

        return ListView.builder(
          itemCount: controller.orders.length,
          itemBuilder: (context, orderIndex) {
            final order = controller.orders[orderIndex];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ORDER INFO
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "Status: ${order.status ?? "N/A"} | "
                    "Total: ৳${order.totalAmount ?? 0}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "Date: ${order.createdAt?.split('T').first ?? "N/A"}",
                  ),
                ),

                const SizedBox(height: 8),

                /// ORDER ITEMS
                ...(order.items ?? []).map((item) {
                  return ListTile(
                    leading: item.product?.thumbnail?.isNotEmpty == true
                        ? Image.network(
                            item.product!.thumbnail!.first,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_not_supported),

                    title: Text(item.product?.name ?? "Unknown Product"),

                    subtitle: Text("Quantity: ${item.quantity ?? 0}"),

                    trailing: Text(
                      "৳${item.price ?? 0}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),

                const Divider(thickness: 1),
              ],
            );
          },
        );
      }),
    );
  }
}
