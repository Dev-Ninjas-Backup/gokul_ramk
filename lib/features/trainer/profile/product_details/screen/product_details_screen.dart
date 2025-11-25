import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../my_products/model/product_model.dart';
import '../widgets/statbox.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the product from arguments
    final Product? product = Get.arguments as Product?;

    if (product == null) {
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
        body: Center(child: Text("No product data available")),
      );
    }

    String imageThumbnail = product.thumbnail.isNotEmpty
        ? product.thumbnail[0]
        : '';
    bool isValidImageUrl =
        imageThumbnail.isNotEmpty && imageThumbnail.trim() != " ";

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
            if (isValidImageUrl)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageThumbnail,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.image_not_supported),
                    );
                  },
                ),
              )
            else
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.image_not_supported),
              ),
            SizedBox(height: 20),

            /// Product title
            Text(
              product.name,
              style: getTextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            Row(
              children: [
                Text(
                  "Price: \$${product.price.toStringAsFixed(0)}",
                  style: getTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 61, 137, 65),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: product.verified == "Pending"
                        ? Colors.orange.shade100
                        : Colors.green.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    product.verified,
                    style: getTextStyle(
                      color: product.verified == "Pending"
                          ? Colors.orange
                          : Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            /// Description
            Text(
              "Description",
              style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              product.description,
              style: getTextStyle(fontSize: 14, color: Colors.grey[700]!),
            ),
            SizedBox(height: 20),

            /// Stats
            Row(
              children: [
                Expanded(
                  child: StatBox(
                    title: "Stock",
                    value: "${product.stock}",
                    isCentered: true,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: StatBox(
                    title: "Rating",
                    value: "${product.rating}",
                    isCentered: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            /// Ingredients/Benefits
            if (product.keyBenefits.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Key Benefits",
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: product.keyBenefits
                        .map(
                          (benefit) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    benefit,
                                    style: getTextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(height: 20),
                ],
              ),

            /// Ingredients Info
            if (product.ingredients.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nutritional Info",
                    style: getTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Column(
                    children: product.ingredients.entries.map((entry) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              entry.key.capitalize ?? entry.key,
                              style: getTextStyle(fontSize: 14),
                            ),
                            Text(
                              "${entry.value}",
                              style: getTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                ],
              ),

            /// Category & Owner Info
            if (product.category != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category: ${product.category!.name}",
                    style: getTextStyle(fontSize: 14, color: Colors.grey[600]!),
                  ),
                  SizedBox(height: 8),
                ],
              ),

            if (product.owner != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Owner: ${product.owner!.fullname}",
                    style: getTextStyle(fontSize: 14, color: Colors.grey[600]!),
                  ),
                  Text(
                    "Email: ${product.owner!.email}",
                    style: getTextStyle(fontSize: 14, color: Colors.grey[600]!),
                  ),
                  SizedBox(height: 20),
                ],
              ),

            /// Buttons
            Row(
              children: [
                if (product.verified != "Approved")
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue[50],
                      ),
                      child: Text(
                        "Edit Product",
                        style: getTextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                if (product.verified != "Approved") SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFE3E0),
                    ),
                    child: Text(
                      "Remove Product",
                      style: getTextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.redAccent,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
