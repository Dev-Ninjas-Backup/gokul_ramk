class GetMeal {
  final String id;
  final String title;

  GetMeal({
    required this.id,
    required this.title,
  });

  factory GetMeal.fromJson(Map<String, dynamic> json) {
    return GetMeal(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
    );
  }
}
