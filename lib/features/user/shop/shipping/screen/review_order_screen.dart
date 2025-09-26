import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/common/widgets/custom_label_textfield.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/user/shop/cart/controller/cart_controller.dart';
import 'package:gokul_ramk/features/user/shop/cart/widget/order_summary_tile.dart';
import 'package:gokul_ramk/features/user/shop/controller/shop_controller.dart';
import 'package:gokul_ramk/routes/app_routes.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ReviewOrderScreen extends StatelessWidget {
  ReviewOrderScreen({super.key});

  final ShopController controller = Get.put(ShopController());
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                CustomAppBarTitle(title: 'Review Your Order'),
                const SizedBox(height: 10),

                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    spacing: 16,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                          image: DecorationImage(
                            image: AssetImage(Imagepath.proteinBottle),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12,
                          children: [
                            Text(
                              'Whey Protein Isolate',
                              style: getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$49',
                                  style: getTextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('01'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 4),

                Center(
                  child: Text(
                    'Order Summary',
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                OrderSummaryTile(
                  title: "Subtotal",
                  value: "\$${cartController.subtotal.toStringAsFixed(0)}",
                ),
                OrderSummaryTile(
                  title: "Shipping Cost",
                  value: "\$${cartController.shippingCost.toStringAsFixed(0)}",
                ),
                Obx(
                  () => OrderSummaryTile(
                    title: "Discount",
                    value:
                        "(-) ${cartController.promoDiscount.value.toStringAsFixed(0)}",
                  ),
                ),
                const Divider(),
                OrderSummaryTile(
                  title: "Total",
                  value: "\$${cartController.total.toStringAsFixed(0)}",
                  isTotal: true,
                ),

                Center(
                  child: Text(
                    'Delivery Address',
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                CustomLabelTextField(
                  label: 'Full Name',
                  editingController: controller.shippingFullNameController,
                  hintText: 'John Doe',
                ),

                const SizedBox(height: 4),
                Text('Phone Number'),

                IntlPhoneField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  languageCode: "en",
                  onChanged: (phone) {
                    debugPrint(controller.shippingPhone);
                    controller.shippingPhone = phone.completeNumber;
                  },
                ),
                CustomLabelTextField(
                  label: 'Delivery Address',
                  editingController: controller.shippingAddressController,
                  hintText: 'NY, USA',
                ),
                const SizedBox(height: 4),

                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: CustomLabelTextField(
                        label: 'City',
                        editingController: controller.shippingCityController,
                        hintText: 'NY, USA',
                      ),
                    ),
                    Expanded(
                      child: CustomLabelTextField(
                        label: 'State/Province',
                        editingController: controller.shippingStateController,
                        hintText: 'NY, USA',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: CustomLabelTextField(
                        label: 'ZIP/Postal Code',
                        editingController: controller.shippingZipController,
                        hintText: 'NY, USA',
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Country'),
                          TextField(
                            readOnly: true,
                            controller: controller.shippingCountryController,
                            decoration: InputDecoration(
                              hintText: 'USA',
                              suffixIcon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                              ),
                            ),
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode:
                                    true, // optional. Shows phone code before the country name.
                                onSelect: (Country country) {
                                  debugPrint(
                                    'Select country: ${country.displayName}',
                                  );
                                  controller.shippingCountryController.text =
                                      country.displayNameNoCountryCode;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                Center(
                  child: Text(
                    'Payment Method',
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(left: 8),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple.shade100),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.purpleAccent.withValues(alpha: 0.08),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      height: 60,
                      child: Image.asset(IconPath.stripeIcon),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoute.getOrderConfirmationScreen());
                  },
                  child: Text('Place Order'),
                ),
                const SizedBox(height: 26),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
