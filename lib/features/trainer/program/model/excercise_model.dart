// models/exercise_model.dart

class ExerciseResponse {
  final List<Exercise> data;
  final int? totalCount;

  ExerciseResponse({required this.data, this.totalCount});

  factory ExerciseResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List<dynamic>? ?? [];
    return ExerciseResponse(
      data: list.map((e) => Exercise.fromJson(e as Map<String, dynamic>)).toList(),
      totalCount: json['totalCount'] as int?,
    );
  }
}

class Exercise {
  final String id;
  final String name;
  final String? description;
  final int? sets;
  final String? reps;
  final int? time;
  final int? rest;

  Exercise({
    required this.id,
    required this.name,
    this.description,
    this.sets,
    this.reps,
    this.time,
    this.rest,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      name: json['name'] as String? ?? 'Unknown',
      description: json['description'] as String?,
      sets: json['sets'] as int?,
      reps: json['reps'] as String?,
      time: json['time'] as int?,
      rest: json['rest'] as int?,
    );
  }

  @override
  bool operator ==(Object other) => other is Exercise && other.id == id;

  @override
  int get hashCode => id.hashCode;
}