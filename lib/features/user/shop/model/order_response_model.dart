class OrderResponseModel {
  String? message;
  int? page;
  int? limit;
  int? total;
  List<OrderModel>? orders;

  OrderResponseModel({
    this.message,
    this.page,
    this.limit,
    this.total,
    this.orders,
  });

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderResponseModel(
      message: json['message'],
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
      orders: (json['orders'] as List?)
          ?.map((e) => OrderModel.fromJson(e))
          .toList(),
    );
  }
}
class OrderModel {
  String? id;
  String? status;
  int? totalAmount;
  String? createdAt;
  List<OrderItemModel>? items;

  OrderModel({
    this.id,
    this.status,
    this.totalAmount,
    this.createdAt,
    this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      status: json['status'],
      totalAmount: json['totalAmount'],
      createdAt: json['createdAt'],
      items: (json['items'] as List?)
          ?.map((e) => OrderItemModel.fromJson(e))
          .toList(),
    );
  }
}
class OrderItemModel {
  int? quantity;
  int? price;
  ProductModel? product;

  OrderItemModel({
    this.quantity,
    this.price,
    this.product,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      quantity: json['quantity'],
      price: json['price'],
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
    );
  }
}
class ProductModel {
  String? id;
  String? name;
  int? price;
  List<String>? thumbnail;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      thumbnail: (json['thumbnail'] as List?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }
}
