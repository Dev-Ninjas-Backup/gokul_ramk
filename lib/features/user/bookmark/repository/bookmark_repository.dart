// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/user/bookmark/model/bookmark_model.dart';
import 'package:gokul_ramk/features/user/bookmark/model/workout_model.dart';

class BookmarkRepository {
  final NetworkClient _networkClient = Get.find<NetworkClient>();

  Future<List<BookmarkModel>> getBookmarks() async {
    try {
      final response = await _networkClient.getRequest(
        url: '${Urls.baseUrl}/bookmark',
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData as Map<String, dynamic>;

        if (data['success'] == true && data['data'] != null) {
          final List<dynamic> bookmarkList = data['data'] as List<dynamic>;
          final bookmarks = bookmarkList
              .map(
                (item) => BookmarkModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();

          // Fetch workout details for each bookmark
          for (var bookmark in bookmarks) {
            final workoutDetails = await getWorkoutDetails(bookmark.workoutId);
            if (workoutDetails != null) {
              // Create new bookmark with workout details
              final index = bookmarks.indexOf(bookmark);
              bookmarks[index] = BookmarkModel(
                id: bookmark.id,
                userId: bookmark.userId,
                workoutId: bookmark.workoutId,
                workoutDetails: workoutDetails,
              );
            }
          }

          return bookmarks;
        }
      }
      return [];
    } catch (e) {
      print('Error fetching bookmarks: $e');
      return [];
    }
  }

  Future<WorkoutModel?> getWorkoutDetails(String workoutId) async {
    try {
      final response = await _networkClient.getRequest(
        url: '${Urls.baseUrl}/workouts/$workoutId',
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData as Map<String, dynamic>;

        if (data['success'] == true && data['data'] != null) {
          return WorkoutModel.fromJson(data['data'] as Map<String, dynamic>);
        }
      }
      return null;
    } catch (e) {
      print('Error fetching workout details for $workoutId: $e');
      return null;
    }
  }

  Future<bool> removeBookmark(String workoutId) async {
    try {
      final response = await _networkClient.postRequest(
        url: '${Urls.baseUrl}/bookmark/$workoutId',
        body: {},
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData as Map<String, dynamic>;
        final success = data['success'] == true;
        print('Bookmark removed: $success');
        return success;
      }
      return false;
    } catch (e) {
      print('Error removing bookmark: $e');
      return false;
    }
  }
}
