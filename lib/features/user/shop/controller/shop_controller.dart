import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/user/shop/model/produt_categories_model.dart';
import 'package:gokul_ramk/features/user/shop/model/shop_product_model.dart';
import 'package:gokul_ramk/features/user/shop/service/shop_service.dart';
import 'package:gokul_ramk/features/user/shop/strip_checkout_helter/strip_helper.dart';

class ShopController extends GetxController {
  final ShopService service = ShopService(
    client: NetworkClient(
      onUnAuthorize: () {
        if (kDebugMode) {
          print("unauthorized");
        }
      },
    ),
  );

  final TextEditingController categorySearchController =
      TextEditingController();

  final TextEditingController shippingFullNameController =
      TextEditingController();
  final TextEditingController shippingAddressController =
      TextEditingController();
  final TextEditingController shippingCityController = TextEditingController();
  final TextEditingController shippingStateController = TextEditingController();
  final TextEditingController shippingZipController = TextEditingController();
  final TextEditingController shippingCountryController =
      TextEditingController();

  String shippingPhone = '';

  final TextEditingController deliveryFullNameController =
      TextEditingController();
  final TextEditingController deliveryAddressController =
      TextEditingController();
  final TextEditingController deliveryCityController = TextEditingController();
  final TextEditingController deliveryStateController = TextEditingController();
  final TextEditingController deliveryZipController = TextEditingController();
  final TextEditingController deliveryCountryController =
      TextEditingController();

  String deliveryPhone = '';

  RxBool saveShipingInfo = true.obs;
  RxBool standardDelivery = true.obs;

  var quantity = 1.obs;

  void increase() => quantity.value++;
  void decrease() {
    if (quantity.value > 1) quantity.value--;
  }

  var productcategoriesList = <ProductCategoryModel>[].obs;

  @override
  void onInit() {
    fetchProductCategoriesMethod();
    fetchProductMethod();

    super.onInit();
  }

  var isLoading = false.obs;

  void fetchProductCategoriesMethod() async {
    isLoading(true);
    try {
      final productcategories = await service.fetchProductCategories();
      productcategoriesList.assignAll(productcategories);
      if (kDebugMode) {
        print("productcategoriesList fetched: ${productcategoriesList.length}");
      }
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    } finally {
      isLoading(false);
    }
  }

  var products = <ShopProductModel>[].obs;

  void fetchProductMethod() async {
    isLoading(true);
    try {
      final productList = await service.fetchShopProduct();
      if (productList.isNotEmpty) {
        products.assignAll(productList);
      }
      if (kDebugMode) {
        print("Products fetched: ${products.length}");
      }
    } catch (e) {
      debugPrint("Error fetching products: $e");
    } finally {
      isLoading(false);
    }
  }

  // Future<void> addToCartMethod(String productId) async {
  //   try {
  //     isLoading.value = true;

  //     bool success = await service.addToCart(
  //       productId: productId,
  //       quantity: quantity.value,
  //     );

  //     if (success) {

  //       EasyLoading.show(status: "Success Added to cart");
  //     } else {
  //       EasyLoading.showError("Error" "Failed to add to cart");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Exception", e.toString());
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> addToCartMethod(String productId) async {
    try {
      isLoading.value = true;

      // Call service (returns void)
      await service.addToCart(productId: productId, quantity: quantity.value);

      // Show success message (assume service throws on error)
      EasyLoading.showSuccess("Added to cart successfully");
    } catch (e) {
      // Show error if service fails
      EasyLoading.showError("Failed to add to cart");
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> createOrder(String cartId) async {
    try {
      isLoading(true);

      final requestBody = {
        "shippingInfo": {
          "fullName": shippingFullNameController.text,
          "address": shippingAddressController.text,
          "city": shippingCityController.text,
          "postalCode": shippingZipController.text,
          "country": shippingCountryController.text,
          "phone": shippingPhone,
        },
        "deliveryInfo": {
          "fullName": shippingFullNameController.text,
          "address": shippingAddressController.text,
          "city": shippingCityController.text,
          "postalCode": shippingZipController.text,
          "country": shippingCountryController.text,
          "phone": shippingPhone,
        },
        "deliveryMethod": standardDelivery.value ? "STANDARD" : "EXPRESS",
        "cartId": cartId,
      };

      final result = await service.createCartOrder(body: requestBody);

      final String checkoutUrl = result['data'];

      await openStripeCheckout(checkoutUrl);
    } catch (e) {
      EasyLoading.showError("Order failed");
    } finally {
      isLoading(false);
    }
  }
}
