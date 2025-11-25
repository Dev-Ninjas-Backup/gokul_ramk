class Product {
  final String id;
  final String name;
  final List<String> thumbnail;
  final double price;
  final int stock;
  final String verified;
  final String status;
  final String description;
  final double rating;
  final Map<String, dynamic> ingredients;
  final List<String> keyBenefits;
  final String categoryId;
  final String ownerId;
  final String createdAt;
  final String updatedAt;
  final Owner? owner;
  final Category? category;
  final List<dynamic> reviews;

  Product({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.price,
    required this.stock,
    required this.verified,
    required this.status,
    required this.description,
    required this.rating,
    required this.ingredients,
    required this.keyBenefits,
    required this.categoryId,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    this.owner,
    this.category,
    required this.reviews,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      thumbnail: List<String>.from(json['thumbnail'] as List? ?? []),
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] as int? ?? 0,
      verified: json['verified'] as String? ?? '',
      status: json['status'] as String? ?? '',
      description: json['description'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      ingredients: _parseIngredients(json['ingredients']),
      keyBenefits: List<String>.from(json['key_benefits'] as List? ?? []),
      categoryId: json['categoryId'] as String? ?? '',
      ownerId: json['ownerId'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      owner: json['owner'] != null
          ? Owner.fromJson(json['owner'] as Map<String, dynamic>)
          : null,
      category: json['category'] != null
          ? Category.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      reviews: json['reviews'] as List? ?? [],
    );
  }

  static Map<String, dynamic> _parseIngredients(dynamic ingredients) {
    if (ingredients is Map<String, dynamic>) {
      return ingredients;
    }
    return {};
  }
}

class Owner {
  final String fullname;
  final String images;
  final String email;

  Owner({required this.fullname, required this.images, required this.email});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      fullname: json['fullname'] as String? ?? '',
      images: json['images'] as String? ?? '',
      email: json['email'] as String? ?? '',
    );
  }
}

class Category {
  final String name;
  final String color;
  final String imageUrl;

  Category({required this.name, required this.color, required this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] as String? ?? '',
      color: json['color'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }
}
