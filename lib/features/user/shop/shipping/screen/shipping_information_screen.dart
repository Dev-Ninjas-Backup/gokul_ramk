import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/common/widgets/custom_label_textfield.dart';
import 'package:gokul_ramk/features/user/shop/controller/shop_controller.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ShippingInformationScreen extends StatelessWidget {
  ShippingInformationScreen({super.key});

  final ShopController controller = Get.put(ShopController());

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
                CustomAppBarTitle(title: 'Shipping Details'),
                const SizedBox(height: 10),
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

                Obx(
                  () => SwitchListTile(
                    activeThumbColor: Colors.green,
                    title: Text(
                      'Save this address for future orders',
                      style: getTextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: controller.saveShipingInfo.value,
                    onChanged: (bool value) {
                      controller.saveShipingInfo.value = value;
                    },
                  ),
                ),

                Center(
                  child: Text(
                    'Delivery Method',
                    style: getTextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.standardDelivery.value =
                          !controller.standardDelivery.value;
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: controller.standardDelivery.value
                            ? Colors.green.withValues(alpha: 0.1)
                            : Colors.grey.shade100,
                        border: Border.all(
                          color: controller.standardDelivery.value
                              ? Colors.green
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Standard Delivery'),
                                Text('Free (5-7 Days)'),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: controller.standardDelivery.value
                                ? Colors.green
                                : Colors.grey,
                            radius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Obx(
                  () => GestureDetector(
                    onTap: () {
                      controller.standardDelivery.value =
                          !controller.standardDelivery.value;
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: controller.standardDelivery.value
                            ? Colors.grey.shade100
                            : Colors.green.withValues(alpha: 0.1),
                        border: Border.all(
                          color: controller.standardDelivery.value
                              ? Colors.grey
                              : Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Express Delivery'),
                                Text('\$9.99 (2-3 Days))'),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: controller.standardDelivery.value
                                ? Colors.grey
                                : Colors.green,
                            radius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Continue to Payment'),
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
