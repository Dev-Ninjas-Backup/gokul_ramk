import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';
import 'package:gokul_ramk/features/user/shop/cart/controller/cart_controller.dart';
import 'package:gokul_ramk/features/user/shop/cart/widget/cart_item_tile.dart';
import 'package:gokul_ramk/features/user/shop/cart/widget/order_summary_tile.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final CartController controller = Get.put(CartController());
  final promoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: CustomAppBarTitle(title: 'My Cart')),
                    Image.asset(IconPath.shopIcon),
                  ],
                ),
                const SizedBox(height: 20),

                Obx(
                  () => ListView.builder(
                    itemCount: controller.cartList.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CartItemTile(index: index);
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // PROMO CODE
                Text(
                  "Have a Promo Code?",
                  style: getTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),

                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black38),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: promoController,
                          decoration: InputDecoration(
                            hintText: "Enter your discount code here",
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.applyPromoCode(promoController.text);
                        },
                        child: Text(
                          'Apply',
                          style: getTextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // ORDER SUMMARY
                Text(
                  "Order Summary",
                  style: getTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => OrderSummaryTile(
                    title: "Subtotal",
                    value: "\$${controller.subtotal.toStringAsFixed(2)}",
                  ),
                ),
                Obx(
                  () => OrderSummaryTile(
                    title: "Shipping Cost",
                    value: "\$${controller.shippingCost.toStringAsFixed(2)}",
                  ),
                ),
                Obx(
                  () => OrderSummaryTile(
                    title: "Discount",
                    value:
                        "(-) ${controller.promoDiscount.value.toStringAsFixed(2)} %",
                  ),
                ),
                const Divider(),
                Obx(
                  () => OrderSummaryTile(
                    title: "Total",
                    value: "\$${controller.total.toStringAsFixed(2)}",
                    isTotal: true,
                  ),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoute.getShippingInformationScreen());
                  },
                  child: Text('Proceed to Checkout'),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
