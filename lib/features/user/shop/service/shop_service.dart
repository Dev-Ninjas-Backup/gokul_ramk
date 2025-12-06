import 'package:flutter/foundation.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
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
        final List<ShopProductModel> productList= data.map((json) => ShopProductModel.fromJson(json)).toList();
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


  //cart add
//  Future<void> addToCart({
//     required String productId,
//     required int quantity,
//   }) async {
//    // final String url = Urls.addCart;

//     try {
//       final response = await client.postRequest(
//         url: "https://wellfitsync.com/cart/add",
//         body: {
//           "productId": productId,
//           "quantity": quantity,
//         },
//       );

//       if (response.isSuccess &&
//           (response.statusCode == 200 || response.statusCode == 201)) {
//         return true;
//       }

//       return false;
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error addToCart: $e");
//       }
//       return false;
//     }
//   }


Future<void> addToCart({
  required String productId,
  required int quantity,
}) async {
  try {
    final response = await client.postRequest(
      url: "https://wellfitsync.com/cart/add",
      body: {
        "productId": productId,
        "quantity": quantity,
      },
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

  
}
