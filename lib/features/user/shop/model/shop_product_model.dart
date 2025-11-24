import 'dart:convert';

class ProductsResponse {
  final bool? success;
  final String? message;
  final ProductDataWrapper? data;

  ProductsResponse({this.success, this.message, this.data});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return ProductsResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? ProductDataWrapper.fromJson(json['data']) : null,
    );
  }
}

class ProductDataWrapper {
  final List<ShopProductModel> data;
  final Meta? meta;

  ProductDataWrapper({required this.data, this.meta});

  factory ProductDataWrapper.fromJson(Map<String, dynamic> json) {
    final List productsJson = json['data'] ?? [];
    return ProductDataWrapper(
      data: productsJson
          .map((item) => ShopProductModel.fromJson(item))
          .toList(),
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }
}

class ShopProductModel {
  final String? id;
  final String? name;
  final List<String>? thumbnail;
  final double? price;
  final int? stock;
  final String? verified;
  final String? status;
  final String? description;
  final double? rating;
  final Ingredients? ingredients;
  final List<String>? keyBenefits;
  final String? categoryId;
  final String? ownerId;
  final String? createdAt;
  final String? updatedAt;
  final Owner? owner;
  final Category? category;
  final List<Review>? reviews;
  final int? reviewsCount;

  ShopProductModel({
    this.id,
    this.name,
    this.thumbnail,
    this.price,
    this.stock,
    this.verified,
    this.status,
    this.description,
    this.rating,
    this.ingredients,
    this.keyBenefits,
    this.categoryId,
    this.ownerId,
    this.createdAt,
    this.updatedAt,
    this.owner,
    this.category,
    this.reviews,
    this.reviewsCount,
  });

  factory ShopProductModel.fromJson(Map<String, dynamic> json) {
    // Ingredients
Ingredients? ingredients;
if (json['ingredients'] != null) {
  if (json['ingredients'] is String && json['ingredients'].trim().isNotEmpty) {
    ingredients = Ingredients.fromJson(jsonDecode(json['ingredients']));
  } else if (json['ingredients'] is Map<String, dynamic>) {
    ingredients = Ingredients.fromJson(json['ingredients']);
  }
}

    // Owner
    Owner? owner;
    if (json['owner'] != null && json['owner'] is Map<String, dynamic>) {
      owner = Owner.fromJson(json['owner']);
    }

    // Category
    Category? category;
    if (json['category'] != null && json['category'] is Map<String, dynamic>) {
      category = Category.fromJson(json['category']);
    }

    // Reviews
    List<Review> reviews = [];
    if (json['reviews'] != null && json['reviews'] is List) {
      reviews = List<Review>.from(
        json['reviews'].map((x) => Review.fromJson(x)),
      );
    }

    return ShopProductModel(
      id: json['id'],
      name: json['name'],
      thumbnail: json['thumbnail'] != null ? List<String>.from(json['thumbnail']) : null,
      price: (json['price'] != null) ? (json['price'] as num).toDouble() : null,
      stock: json['stock'],
      verified: json['verified'],
      status: json['status'],
      description: json['description'],
      rating: (json['rating'] != null) ? (json['rating'] as num).toDouble() : null,
      ingredients: ingredients,
      keyBenefits: json['key_benefits'] != null ? List<String>.from(json['key_benefits']) : null,
      categoryId: json['categoryId'],
      ownerId: json['ownerId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      owner: owner,
      category: category,
      reviews: reviews,
      reviewsCount: json['_count'] != null ? json['_count']['reviews'] : 0,
    );
  }
}

// Ingredients as a dynamic map
class Ingredients {
  final Map<String, dynamic>? data;

  Ingredients({this.data});

  factory Ingredients.fromJson(Map<String, dynamic> json) {
    return Ingredients(data: json);
  }
}

class Owner {
  final String? fullname;
  final dynamic images;
  final String? email;

  Owner({this.fullname, this.images, this.email});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      fullname: json['fullname'],
      images: json['images'],
      email: json['email'],
    );
  }
}

class Category {
  final String? name;
  final String? color;
  final String? imageUrl;

  Category({this.name, this.color, this.imageUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      color: json['color'],
      imageUrl: json['imageUrl'],
    );
  }
}

class Review {
  final int? rating;
  final String? comment;
  final User? user;

  Review({this.rating, this.comment, this.user});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'],
      comment: json['comment'],
      user: json['user'] != null && json['user'] is Map<String, dynamic>
          ? User.fromJson(json['user'])
          : null,
    );
  }
}

class User {
  final String? fullname;
  final dynamic images;

  User({this.fullname, this.images});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullname: json['fullname'],
      images: json['images'],
    );
  }
}

class Meta {
  final int? total;
  final int? page;
  final int? limit;
  final int? totalPages;

  Meta({this.total, this.page, this.limit, this.totalPages});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      total: json['total'],
      page: json['page'],
      limit: json['limit'],
      totalPages: json['totalPages'],
    );
  }
}
