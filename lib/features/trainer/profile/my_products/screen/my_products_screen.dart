import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/profile/my_products/controller/my_products_controller.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class MyProductsScreen extends StatelessWidget {
  MyProductsScreen({super.key});

  final controller = Get.put(MyProductsController());

  /// Helper method to check if image URL is valid
  bool _isValidImageUrl(String? url) {
    return url != null && url.trim().isNotEmpty && url.trim() != " ";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller.scrollController,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),
            CustomAppBarTitle(title: 'My Products'),
            const SizedBox(height: 20),

            /// Search Field
            TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
              onChanged: (value) {
                controller.onSearchChanged(value);
              },
            ),
            SizedBox(height: 20),

            /// Status Filter
            Text(
              'Filter by Status',
              style: getTextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Obx(
              () => Wrap(
                spacing: 8,
                children: MyProductsController.availableStatuses.map((status) {
                  return FilterChip(
                    label: Text(status.replaceAll('_', ' ')),
                    selected: controller.selectedStatus.value == status,
                    onSelected: (selected) {
                      if (selected) {
                        controller.changeStatus(status);
                      }
                    },
                    selectedColor: AppColors.primaryColor,
                    labelStyle: TextStyle(
                      color: controller.selectedStatus.value == status
                          ? Colors.white
                          : Colors.black,
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),

            /// Products List
            Obx(() {
              if (controller.isLoading.value && controller.products.isEmpty) {
                return SizedBox(
                  height: 300,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (controller.products.isEmpty) {
                return SizedBox(
                  height: 300,
                  child: Center(
                    child: Text(
                      'No products found',
                      style: getTextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  ...controller.products.map((product) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          AppRoute.productDetails,
                          arguments: product,
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.only(bottom: 12),
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Product Image
                              if (product.thumbnail.isNotEmpty &&
                                  _isValidImageUrl(product.thumbnail[0]))
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    product.thumbnail[0],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Icon(Icons.image_not_supported),
                                      );
                                    },
                                  ),
                                )
                              else
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(Icons.image_not_supported),
                                ),
                              SizedBox(width: 12),

                              /// Product Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: getTextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    if (product.category != null)
                                      Text(
                                        product.category!.name,
                                        style: getTextStyle(
                                          fontSize: 11,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    SizedBox(height: 4),
                                    Text(
                                      '\$${product.price.toStringAsFixed(2)}',
                                      style: getTextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Stock: ${product.stock}',
                                          style: getTextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getStatusColor(
                                              product.status,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          child: Text(
                                            product.status,
                                            style: getTextStyle(
                                              fontSize: 11,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _getVerifiedColor(
                                          product.verified,
                                        ),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        'Verification: ${product.verified}',
                                        style: getTextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  if (controller.isLoading.value)
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                ],
              );
            }),

            /// Total Count Info
            SizedBox(height: 20),
            Obx(
              () => Text(
                'Total Products: ${controller.totalCount.value}',
                style: getTextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Low_Stock':
        return Colors.orange;
      case 'Out_of_Stock':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  Color _getVerifiedColor(String verified) {
    switch (verified) {
      case 'Approved':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
