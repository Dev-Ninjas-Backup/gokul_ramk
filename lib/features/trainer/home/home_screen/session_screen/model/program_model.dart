class ProgramModel {
  final String id;
  final String name;

  ProgramModel({required this.id, required this.name});

  factory ProgramModel.fromJson(Map<String, dynamic> json) {
    return ProgramModel(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? json['title'] ?? '',
    );
  }
}
