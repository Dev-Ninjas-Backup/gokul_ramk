import 'package:gokul_ramk/features/user/bookmark/model/workout_model.dart';

class BookmarkModel {
  final String id;
  final String userId;
  final String workoutId;
  final WorkoutModel? workoutDetails;

  BookmarkModel({
    required this.id,
    required this.userId,
    required this.workoutId,
    this.workoutDetails,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      workoutId: json['workoutId'] as String,
      workoutDetails: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'workoutId': workoutId,
      'workoutDetails': workoutDetails?.toJson(),
    };
  }
}
