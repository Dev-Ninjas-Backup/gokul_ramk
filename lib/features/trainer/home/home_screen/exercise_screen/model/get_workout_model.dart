class GetWorkout {
  final String id;
  final String name;
  final List<dynamic> exercises;

  GetWorkout({required this.id, required this.name, required this.exercises});

  factory GetWorkout.fromJson(Map<String, dynamic> json) {
    return GetWorkout(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? '',
      exercises: json['exercises'] != null ? List.from(json['exercises']) : [],
    );
  }
}
