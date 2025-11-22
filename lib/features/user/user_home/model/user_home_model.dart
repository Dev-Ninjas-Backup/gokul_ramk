class CategoryModelWorkOut {
  final String id;
  final String name;

  CategoryModelWorkOut({
    required this.id,
    required this.name,
  });

  factory CategoryModelWorkOut.fromJson(Map<String, dynamic> json) {
    return CategoryModelWorkOut(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
