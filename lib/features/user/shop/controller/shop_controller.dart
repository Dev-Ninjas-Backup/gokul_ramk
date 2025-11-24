import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/user/shop/model/produt_categories_model.dart';
import 'package:gokul_ramk/features/user/shop/model/shop_product_model.dart';
import 'package:gokul_ramk/features/user/shop/service/shop_service.dart';

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

    super.onInit();
  }

  var isLoading = false.obs;

  void fetchProductCategoriesMethod() async {
    isLoading(true);
    try {
      final productcategories = await service.fetchProductCategories();
      productcategoriesList.assignAll(productcategories);
      if (productcategoriesList.isNotEmpty) {
        return;
      }
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    } finally {
      isLoading(false);
    }
  }

  var products = <ShopProductModel>[
    ShopProductModel(
      title: "Whey Protein Isolate (2lbs)",
      description: "Vanilla, 25g protein per scoop.",
      price: 39.99,
      image:
          "https://www.teamcp.co.nz/wp-content/uploads/2021/07/protiencpowder-600x433.png",
      rating: 4.8,
      reviews: 320,
    ),
    ShopProductModel(
      title: "Whey Protein Isolate (2lbs)",
      description: "Vanilla, 25g protein per scoop.",
      price: 39.99,
      image:
          "https://www.teamcp.co.nz/wp-content/uploads/2021/07/protiencpowder-600x433.png",
      rating: 4.8,
      reviews: 320,
    ),
  ].obs;
}
