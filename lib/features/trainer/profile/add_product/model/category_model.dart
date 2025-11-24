class ProductCategory {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String color;
  final String createdAt;
  final String updatedAt;

  ProductCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      color: json['color'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'color': color,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
