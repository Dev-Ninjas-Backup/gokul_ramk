// models/program_model.dart
class WorkoutSession {
  final String exercise;
  final String sets;
  final String reps;
  final String duration;
  final String? videoUrl;

  WorkoutSession({
    required this.exercise,
    required this.sets,
    required this.reps,
    required this.duration,
    this.videoUrl,
  });
}

class WorkoutProgram {
  final String name;
  final String duration;
  final String category;
  final String description;
  final String? thumbnail;
  final List<WorkoutSession> sessions;

  WorkoutProgram({
    required this.name,
    required this.duration,
    required this.category,
    required this.description,
    this.thumbnail,
    this.sessions = const [],
  });

  WorkoutProgram copyWith({List<WorkoutSession>? sessions}) {
    return WorkoutProgram(
      name: name,
      duration: duration,
      category: category,
      description: description,
      thumbnail: thumbnail,
      sessions: sessions ?? this.sessions,
    );
  }
}
