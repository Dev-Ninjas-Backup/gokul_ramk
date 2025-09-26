import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../add_product/controller/add_product_controller.dart';
import '../../add_product/widgets/product_images_widget.dart';
import '../widgets/statbox.dart';

class ProductDetailScreen extends StatelessWidget {
  final AddProductController controller = Get.find<AddProductController>();

  ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Details",
          style: getTextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Images Section
            ProductImagesSection(controller: controller),
            SizedBox(height: 20),

            /// Product title
            Text(
              "Whey Protein - Chocolate 1kg",
              style: getTextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            Row(
              children: [
                Text(
                  "Price: \$40/hr",
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 61, 137, 65),
                  ),
                ),
                SizedBox(width: 200),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Rejected",
                    style: getTextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            /// Stats
            Row(
              children: [
                Expanded(
                  child: StatBox(
                    title: "Units Sold",
                    value: "32",
                    isCentered: true,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: StatBox(
                    title: "Earnings",
                    value: "\$640",
                    isCentered: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),

            /// Full-width + centered
            StatBox(
              title: "After commission",
              value: "\$575",
              isCentered: true,
            ),

            SizedBox(height: 50),

            /// Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue[50],
                    ),
                    child: Text(
                      "Edit Product",
                      style: getTextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFE3E0),
                    ),
                    child: Text(
                      "Remove Product",
                      style: getTextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
