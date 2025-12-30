class CreateOrderRequest {
  final Map<String, dynamic> shippingInfo;
  final Map<String, dynamic> deliveryInfo;
  final String deliveryMethod;
  final String cartId;

  CreateOrderRequest({
    required this.shippingInfo,
    required this.deliveryInfo,
    required this.deliveryMethod,
    required this.cartId,
  });

  Map<String, dynamic> toJson() {
    return {
      "shippingInfo": shippingInfo,
      "deliveryInfo": deliveryInfo,
      "deliveryMethod": deliveryMethod,
      "cartId": cartId,
    };
  }
}
