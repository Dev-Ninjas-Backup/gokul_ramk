class CategoryModel {
  final String id;
  final String name;
  final String type;
  final String desc;
  final String color;

  CategoryModel({
    required this.id,
    required this.name,
    required this.type,
    required this.desc,
    required this.color,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["id"],
      name: json["name"],
      type: json["type"],
      desc: json["desc"],
      color: json["color"],
    );
  }
}
