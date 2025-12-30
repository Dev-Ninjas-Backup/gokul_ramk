class Exercise {
  final String id;
  final String name;
  final String description;
  final int sets;
  final String reps;
  final int time;
  final int rest;
  final int order;
  final String workoutId;
  final Map<String, dynamic>? workout;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.sets,
    required this.reps,
    required this.time,
    required this.rest,
    required this.order,
    required this.workoutId,
    this.workout,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] ?? json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      sets: (json['sets'] is int)
          ? json['sets']
          : int.tryParse('${json['sets']}') ?? 0,
      reps: json['reps'] ?? '',
      time: (json['time'] is int)
          ? json['time']
          : int.tryParse('${json['time']}') ?? 0,
      rest: (json['rest'] is int)
          ? json['rest']
          : int.tryParse('${json['rest']}') ?? 0,
      order: (json['order'] is int)
          ? json['order']
          : int.tryParse('${json['order']}') ?? 0,
      workoutId: json['workoutId'] ?? '',
      workout: json['workout'] != null
          ? Map<String, dynamic>.from(json['workout'])
          : null,
    );
  }
}
