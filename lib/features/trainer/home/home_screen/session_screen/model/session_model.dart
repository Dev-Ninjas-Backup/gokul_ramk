class SessionModel {
  final String id;
  final String? programId;
  final String? packageId;
  final String trainerId;
  final String categoryId;
  final String title;
  final String description;
  final int duration;
  final dynamic price;

  SessionModel({
    required this.id,
    this.programId,
    this.packageId,
    required this.trainerId,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.duration,
    required this.price,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'] ?? json['_id'] ?? '',
      programId: json['programId'] as String?,
      packageId: json['packageId'] as String?,
      trainerId: json['trainerId'] ?? '',
      categoryId: json['categoryId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      duration: (json['duration'] is int)
          ? json['duration']
          : int.tryParse('${json['duration']}') ?? 0,
      price: json['price'],
    );
  }
}
