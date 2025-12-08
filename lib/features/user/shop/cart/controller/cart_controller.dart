// ignore_for_file: avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

  @override
  void onInit() {
    fetchCoupons();
    super.onInit();
  }

  /// LOADING STATE
  var isLoading = false.obs;

  /// CART LIST
  RxList<CartItem2> cartList = <CartItem2>[].obs;

  /// FETCH CART ITEMS
  Future<void> getCart() async {
    try {
      isLoading.value = true;

      final response = await service.client.getRequest(url: Urls.getCart);

      if (response.isSuccess &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        final data = response.responseData as Map<String, dynamic>;
        final List list = data['items'];

        cartList.clear(); // Prevent duplicates
        cartList.addAll(list.map((e) => CartItem2.fromJson(e)));

        if (kDebugMode) {
          print("Cart fetched = ${cartList.length}");
        }
      } else {
        throw Exception(response.errorMessage ?? "Failed to fetch cart items");
      }
    } catch (e) {
      EasyLoading.showError("Error fetching cart: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// UPDATE ITEM QUANTITY ON SERVER
  Future<void> updateCart(String id, int quantity) async {
    final body = {"quantity": quantity};

    try {
      final response = await service.client.patchRequest(
        url: "https://wellfitsync.com/cart/$id",
        body: body,
      );

      if (response.isSuccess &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        print("Cart updated successfully");
      } else {
        EasyLoading.showError(
          "Failed to update cart: ${response.errorMessage}",
        );
      }
    } catch (e) {
      EasyLoading.showError("Error updating cart: $e");
    }
  }

  //delete product cart
  Future<void> deteleCart(String id) async {
    // final body = {"quantity": quantity};

    try {
      final response = await service.client.deleteRequest(
        "https://wellfitsync.com/cart/$id",
      );

      if (response.isSuccess &&
          (response.statusCode == 200 || response.statusCode == 201)) {
        EasyLoading.showInfo("Cart detete successfully");
      } else {
        EasyLoading.showError(
          "Failed to delete cart: ${response.errorMessage}",
        );
      }
    } catch (e) {
      EasyLoading.showError("Error delete cart: $e");
    }
  }

  /// APPLY PROMO CODE
  var promoDiscount = 0.0.obs;
  final shippingCost = 5.0.obs;

  /// SUBTOTAL = sum(price * qty)
  double get subtotal {
    return cartList.fold(
      0.0,
      (sum, item) => sum + ((item.product?.price ?? 0) * (item.quantity ?? 0)),
    );
  }

  /// TOTAL = subtotal + shipping - discount
  double get total => subtotal + shippingCost.value - promoDiscount.value;

  /// INCREASE ITEM QUANTITY (API + UI)
  void increaseItemQty(CartItem2 item) async {
    final newQty = (item.quantity ?? 0) + 1;

    await updateCart(item.product!.id.toString(), newQty);

    item.quantity = newQty;
    cartList.refresh();
  }

  /// DECREASE ITEM QUANTITY (API + UI)
  void decreaseItemQty(CartItem2 item) async {
    if ((item.quantity ?? 0) > 1) {
      final newQty = item.quantity! - 1;

      await updateCart(item.product!.id.toString(), newQty);

      item.quantity = newQty;
      cartList.refresh();
    }
  }

  //get copun

  RxList<Map<String, dynamic>> coupons = <Map<String, dynamic>>[].obs;
  Future<void> fetchCoupons() async {
    final response = await service.client.getRequest(url: Urls.coupon);

    if (response.isSuccess &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      coupons.value = List<Map<String, dynamic>>.from(
        response.responseData!['data'],
      );
      print("=============================number of code = ${coupons.length}");
    }
  }

  //apply promo code

  void applyPromoCode(String code) {
    code = code.trim().toUpperCase();

    // find coupon
    final coupon = coupons.firstWhere(
      (c) => c['coupon'].toString().toUpperCase() == code,
      orElse: () => {},
    );

    // if not exists
    if (coupon.isEmpty) {
      promoDiscount.value = 0.0;
      EasyLoading.showError("Please Enter a Valid Coupon");

      return;
    }

    // check expiration
    final expireDate = DateTime.parse(coupon['expireAt']);
    if (expireDate.isBefore(DateTime.now())) {
      promoDiscount.value = 0.0;
      EasyLoading.showError("Expired Coupon");
      return;
    }

    // apply rate
    promoDiscount.value = (coupon['rate'] as num).toDouble();
    EasyLoading.showInfo("Discount Added");
  }
}
