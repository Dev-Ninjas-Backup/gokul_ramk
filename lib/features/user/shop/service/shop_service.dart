import 'package:flutter/foundation.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/user/shop/model/order_response_model.dart';
import 'package:gokul_ramk/features/user/shop/model/shop_product_model.dart';

import '../model/produt_categories_model.dart';

class ShopService {
  final NetworkClient client;

  ShopService({required this.client});

  Future<List<ProductCategoryModel>> fetchProductCategories() async {
    const String url = Urls.productcategories;

    final response = await client.getRequest(url: url);

    if (response.isSuccess &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      final List data = response.responseData!['data']['data'];

      return data.map((json) => ProductCategoryModel.fromJson(json)).toList();
    } else {
      throw response.errorMessage ?? "Failed to load categories";
    }
  }

  //shop product
  Future<List<ShopProductModel>> fetchShopProduct() async {
    // final String url = Urls.products;
    try {
      final String url = Urls.products;
      final response = await client.getRequest(url: url);
      if (kDebugMode) {
        print("=========reerfdsafdfaewsdv rg========${response.responseData}");
      }

      if (response.isSuccess &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        final List data = response.responseData!['data']['data'];
        final List<ShopProductModel> productList = data
            .map((json) => ShopProductModel.fromJson(json))
            .toList();
        if (kDebugMode) {
          print("Parsing product: ${productList.length}");
        }

        return productList;
      } else {
        throw response.errorMessage ?? " Faild to Load Product";
      }
    } catch (e) {
      debugPrint("Error111: $e");
      return [];
    }
  }

  Future<void> addToCart({
    required String productId,
    required int quantity,
  }) async {
    try {
      final response = await client.postRequest(
        url: "https://wellfitsync.com/cart/add",
        body: {"productId": productId, "quantity": quantity},
      );

      if (response.isSuccess &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        if (kDebugMode) {
          print("Cart added successfully");
        }
      } else {
        if (kDebugMode) {
          print("Failed to add to cart");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error addToCart: $e");
      }
    }
  }

  Future<Map<String, dynamic>> createCartOrder({
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await client.postRequest(
        url: "${Urls.baseUrl}/order/create-cart-order",
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.responseData; // already Map<String, dynamic>
      } else {
        throw Exception("Order creation failed");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<OrderResponseModel> fetchMyOrders() async {
    const String url = "${Urls.baseUrl}/order/my";

    final response = await client.getRequest(url: url);

    if (response.isSuccess &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      return OrderResponseModel.fromJson(response.responseData);
    } else {
      throw response.errorMessage ?? "Failed to load categories";
    }
  }

  // Future<void> createCartOrder({required Map<String, dynamic> body}) async {
  //   try {
  //     final response = await client.postRequest(
  //       url: "${Urls.baseUrl}/order/create-cart-order",
  //       body: body,
  //     );

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       if (kDebugMode) {
  //         print("Cart order successfully");
  //       }
  //     } else {
  //       if (kDebugMode) {
  //         print("Failed to add to order");
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  //all cart
  //  Future<List<CartItemModel>> getCartItems() async {
  //     final response = await client.getRequest(
  //       url: "https://wellfitsync.com/cart",
  //     );

  //     if (response.isSuccess &&
  //         (response.statusCode == 200 || response.statusCode == 201)) {
  //       final data = response.responseData!['data'] as List;
  //       return data.map((e) => CartItemModel.fromJson(e)).toList();
  //     } else {
  //       throw Exception(response.errorMessage ?? "Failed to fetch cart items");
  //     }
  //   }

  // Future<CartItemModel> getCartItems() async {
  //   final response = await client.getRequest(
  //     url: "https://wellfitsync.com/cart",
  //   );

  //   if (response.isSuccess &&
  //       (response.statusCode == 200 || response.statusCode == 201)) {
  //     final data = response.responseData as Map<String, dynamic>;
  //     return CartItemModel.fromJson(data);
  //   } else {
  //     throw Exception(response.errorMessage ?? "Failed to fetch cart items");
  //   }
  // }
}
