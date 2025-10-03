import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/trainer/profile/product_details/screen/product_details_screen.dart';

import '../controller/add_product_controller.dart';
import '../widgets/product_images_widget.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final controller = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Add New Product",
          style: getTextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Images Section
            ProductImagesSection(controller: controller),

            SizedBox(height: 30),

            /// Product Info
            Text(
              "Product Info",
              style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Product Name",
                style: getTextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(),
            ),
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Product Category",
                style: getTextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            Obx(
              () => DropdownButtonFormField<String>(
                // ignore: deprecated_member_use
                value: controller.selectedCategory.value,
                items: controller.categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) =>
                    controller.selectedCategory.value = value!,
              ),
            ),
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Price",
                style: getTextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            TextField(
              controller: controller.priceController,
              decoration: InputDecoration(),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Stock Quantity",
                style: getTextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            TextField(
              controller: controller.stockController,
              decoration: InputDecoration(),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Description",
                style: getTextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            TextField(
              controller: controller.descriptionController,
              decoration: InputDecoration(),
              maxLines: 3,
            ),
            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Delivery Info",
                style: getTextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            Obx(
              () => DropdownButtonFormField<String>(
                // ignore: deprecated_member_use
                value: controller.selectedDelivery.value,
                items: controller.deliveryOptions
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (value) =>
                    controller.selectedDelivery.value = value!,
              ),
            ),

            SizedBox(height: 50),

            /// Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => ProductDetailsScreen());
                },
                child: Text(
                  "Submit for Review",
                  style: getTextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),
            Text(
              "Your product will be reviewed by our team before it appears in the store. "
              "A commission fee applies per sale.",
              style: getTextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
