import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/trainer/profile/my_products/model/product_model.dart';
import 'package:gokul_ramk/features/trainer/profile/my_products/service/product_request_service.dart';

class MyProductsController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = false.obs;
  var selectedStatus = 'Active'.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var totalCount = 0.obs;
  var hasMoreData = false.obs;

  final searchController = TextEditingController();
  final scrollController = ScrollController();

  static const int pageLimit = 10;
  static const List<String> availableStatuses = [
    'Active',
    'Low_Stock',
    'Out_of_Stock',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    searchController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  Future<void> fetchProducts({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage.value = 1;
      products.clear();
    }

    try {
      isLoading.value = true;

      final response = await ProductRequestService.fetchProducts(
        search: searchController.text.isNotEmpty ? searchController.text : null,
        status: selectedStatus.value,
        page: currentPage.value,
        limit: pageLimit,
      );

      if (response.isNotEmpty) {
        List<dynamic> data = [];

        // Handle different response structures
        if (response['data'] is List) {
          data = response['data'];
        } else if (response['data'] is Map &&
            response['data']['data'] is List) {
          data = response['data']['data'];
        }

        final newProducts = data
            .map((item) {
              try {
                return Product.fromJson(item as Map<String, dynamic>);
              } catch (e) {
                debugPrint('Error parsing product: $e');
                return null;
              }
            })
            .whereType<Product>()
            .toList();

        if (isRefresh) {
          products.value = newProducts;
        } else {
          products.addAll(newProducts);
        }

        // Update pagination info
        totalPages.value = response['totalPages'] ?? 1;
        totalCount.value = response['totalCount'] ?? newProducts.length;
        hasMoreData.value = currentPage.value < totalPages.value;

        debugPrint(
          '✅ Loaded ${newProducts.length} products. Total: ${totalCount.value}',
        );
      }
    } catch (e) {
      debugPrint('Error fetching products: $e');
      Get.snackbar('Error', 'Failed to load products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void changeStatus(String status) {
    selectedStatus.value = status;
    currentPage.value = 1;
    products.clear();
    fetchProducts();
  }

  void onSearchChanged(String query) {
    currentPage.value = 1;
    products.clear();
    fetchProducts();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 500) {
      if (hasMoreData.value && !isLoading.value) {
        currentPage.value++;
        fetchProducts();
      }
    }
  }

  void refreshProducts() {
    fetchProducts(isRefresh: true);
  }
}
