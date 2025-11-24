class ProductCategoryModel {
  final String? id;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? color;
  final String? createdAt;
  final String? updatedAt;

  ProductCategoryModel({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.color,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      color: json['color'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
