import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/user/shop/cart/model/cart_item_model.dart';
import 'package:gokul_ramk/features/user/shop/service/shop_service.dart';

class CartController extends GetxController {
  final ShopService service = ShopService(
    client: NetworkClient(
      onUnAuthorize: () {
        if (kDebugMode) print("unauthorized");
      },
    ),
  );

  var isLoading = false.obs;

  RxList<CartItem2> cartList = <CartItem2>[].obs;
  Future<void> getcart() async {
    final response = await service.client.getRequest(
      url: Urls.getCart,
    );

    if (response.isSuccess &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      final data = response.responseData as Map<String, dynamic>;
      final List list = data['items'];
      for (var json in list) {
        CartItem2 item = CartItem2.fromJson(json);
        cartList.add(item);
      }
      if (kDebugMode) {
        print("======cart list=======${cartList.length}");
      }
    } else {
      throw Exception(response.errorMessage ?? "Failed to fetch cart items");
    }
  }

  var promoDiscount = 0.0.obs;
  final shippingCost = 5.0.obs;

  /// Calculate subtotal: sum of all items' price * quantity
  double get subtotal {
    double sum = 0.0;
    for (var item in cartList) {
      sum += (item.product?.price ?? 0) * (item.quantity ?? 0);
    }
    return sum;
  }

  /// Total after discount and shipping
  double get total => subtotal + shippingCost.value - promoDiscount.value;

  /// Increase quantity of a specific item
  void increaseItemQty(CartItem2 item) {
    item.quantity = (item.quantity ?? 0) + 1;
    cartList.refresh();
  }

  /// Decrease quantity of a specific item
  void decreaseItemQty(CartItem2 item) {
    if ((item.quantity ?? 0) > 1) {
      item.quantity = item.quantity! - 1;
      cartList.refresh();
    }
  }

  /// Remove a specific item from cart
  // void removeItem(CartItem2 item) {
  //   cartList.remove(item);
  //   cartList.refresh();
  // }

  /// Apply promo code
  void applyPromoCode(String code) {
    if (code.trim().toUpperCase() == "DISCOUNT10") {
      promoDiscount.value = 10.0;
    } else {
      promoDiscount.value = 0.0;
    }
  }
}
