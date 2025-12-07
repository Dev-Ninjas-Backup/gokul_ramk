// class CartItemModel {
//   String? id;
//   String? userId;
//   String? createdAt;
//   String? updatedAt;
//   List<CartItem>? items;

//   CartItemModel({
//     this.id,
//     this.userId,
//     this.createdAt,
//     this.updatedAt,
//     this.items,
//   });

// factory CartItemModel.fromJson(Map<String, dynamic> json) {
//   return CartItemModel(
//     id: json['id'],
//     userId: json['userId'],
//     createdAt: json['createdAt'],
//     updatedAt: json['updatedAt'],

//     items: (json['items'] is List)
//         ? (json['items'] as List)
//             .map((e) => CartItem.fromJson(e ?? {}))
//             .toList()
//         : [],
//   );
// }


//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'userId': userId,
//     'createdAt': createdAt,
//     'updatedAt': updatedAt,
//     'items': items!.map((e) => e.toJson()).toList(),
//   };
// }


// class CartItem {
//   String? id;
//   int? quantity;
//   String? cartId;
//   String? productId;
//   Product? product;

//   CartItem({this.id, this.quantity, this.cartId, this.productId, this.product});

//   factory CartItem.fromJson(Map<String, dynamic> json) {
//     return CartItem(
//       id: json['id'],
//       quantity: json['quantity'],
//       cartId: json['cartId'],
//       productId: json['productId'],
//       product: json['product'] != null
//           ? Product.fromJson(json['product'])
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'quantity': quantity,
//     'cartId': cartId,
//     'productId': productId,
//     'product': product?.toJson(),
//   };
// }

// class Product {
//   String? id;
//   String? name;
//   List<String>? thumbnail;
//   double? price;
//   int? stock;
//   String? verified;
//   String? status;
//   String? description;
//   double? rating;
//   Map<String, dynamic>? ingredients;
//   List<String>? keyBenefits;
//   String? categoryId;
//   String? ownerId;
//   String? createdAt;
//   String? updatedAt;

//   Product({
//     this.id,
//     this.name,
//     this.thumbnail,
//     this.price,
//     this.stock,
//     this.verified,
//     this.status,
//     this.description,
//     this.rating,
//     this.ingredients,
//     this.keyBenefits,
//     this.categoryId,
//     this.ownerId,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'] as String?,
//       name: json['name'].toString(),

//       // Safest thumbnail parsing
//       thumbnail: _toStringList(json['thumbnail']),

//       price: json['price'] != null ? (json['price']).toDouble() : 0.0,

//       stock: (json['stock'])?.toInt() ?? 0,
//       verified: json['verified'] as String?,
//       status: json['status'] as String?,
//       description: json['description'] as String?,

//       rating: json['rating'] != null ? (json['rating'] as num).toDouble() : 0.0,

//       ingredients: json['ingredients'] is Map
//           ? Map<String, dynamic>.from(json['ingredients'] as Map)
//           : <String, dynamic>{},

//       keyBenefits: _toStringList(json['key_benefits']),

//       categoryId: json['categoryId'] as String?,
//       ownerId: json['ownerId'] as String?,
//       createdAt: json['createdAt'] as String?,
//       updatedAt: json['updatedAt'] as String?,
//     );
//   }

//   // Helper method (add inside Product class)
//   static List<String> _toStringList(dynamic data) {
//     if (data == null) return [];
//     if (data is List) {
//       return data.map((e) => e.toString()).toList();
//     }
//     if (data is String) {
//       return [data];
//     }
//     return [];
//   }

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'name': name,
//     'thumbnail': thumbnail,
//     'price': price,
//     'stock': stock,
//     'verified': verified,
//     'status': status,
//     'description': description,
//     'rating': rating,
//     'ingredients': ingredients,
//     'key_benefits': keyBenefits,
//     'categoryId': categoryId,
//     'ownerId': ownerId,
//     'createdAt': createdAt,
//     'updatedAt': updatedAt,
//   };
// }






//new model

class CartItem2 {
  String? id;
  int? quantity;
  String? cartId;
  String? productId;
  Product? product;

  CartItem2({
    this.id,
    this.quantity,
    this.cartId,
    this.productId,
    this.product,
  });

  CartItem2.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    cartId = json['cartId'];
    productId = json['productId'];
    product = json['product'] != null
        ? Product.fromJson(json['product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['cartId'] = cartId;
    data['productId'] = productId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  String? id;
  String? name;
  List<String>? thumbnail;
  int? price;
  int? stock;
  String? verified;
  String? status;
  String? description;
  int? rating;
  String? categoryId;
  String? ownerId;
  String? createdAt;
  String? updatedAt;

  Product({
    this.id,
    this.name,
    this.thumbnail,
    this.price,
    this.stock,
    this.verified,
    this.status,
    this.description,
    this.rating,
    this.categoryId,
    this.ownerId,
    this.createdAt,
    this.updatedAt,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnail = json['thumbnail'].cast<String>();
    price = json['price'];
    stock = json['stock'];
    verified = json['verified'];
    status = json['status'];
    description = json['description'];
    rating = json['rating'];
    categoryId = json['categoryId'];
    ownerId = json['ownerId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['thumbnail'] = thumbnail;
    data['price'] = price;
    data['stock'] = stock;
    data['verified'] = verified;
    data['status'] = status;
    data['description'] = description;
    data['rating'] = rating;
    data['categoryId'] = categoryId;
    data['ownerId'] = ownerId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}