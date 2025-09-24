import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/user/shop/cart/model/cart_item_model.dart';

class CartController extends GetxController {
  var cartItems = <CartItemModel>[
    CartItemModel(
      image: Imagepath.proteinBottle,
      name: 'Whey Protein Isolate',
      price: 49,
    ),
    CartItemModel(
      image: Imagepath.proteinBottle,
      name: 'Whey Protein Isolate',
      price: 49,
    ),
    CartItemModel(
      image: Imagepath.proteinBottle,
      name: 'Whey Protein Isolate',
      price: 49,
    ),
  ].obs;

  var promoDiscount = 0.0.obs;
  final shippingCost = 5.0;

  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  double get total => subtotal + shippingCost - promoDiscount.value;

  void increaseQty(int index) {
    cartItems[index].quantity++;
    cartItems.refresh();
  }

  void decreaseQty(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      cartItems.refresh();
    }
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
  }

  void applyPromoCode(String code) {
    if (code == "DISCOUNT10") {
      promoDiscount.value = 10.0;
    } else {
      promoDiscount.value = 0.0;
    }
  }
}
