class PackageModel {
  final String id;
  final String name;

  PackageModel({required this.id, required this.name});

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? json['title'] ?? '',
    );
  }
}
