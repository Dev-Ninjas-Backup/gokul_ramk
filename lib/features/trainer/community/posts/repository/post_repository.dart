// ignore_for_file: avoid_print, unnecessary_cast

import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/community/posts/model/posts_model.dart';

class PostRepository {
  final NetworkClient networkClient;

  PostRepository({required this.networkClient});

  Future<List<PostModel>> getPosts({
    required int page,
    required int limit,
    String sortBy = 'createdAt',
  }) async {
    try {
      final url = '${Urls.getPost}?sortBy=$sortBy&limit=$limit&page=$page';
      final response = await networkClient.getRequest(url: url);

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData;

        // Handle different response formats
        List<dynamic> postsList = [];

        if (data is List) {
          postsList = data as List<dynamic>;
        } else if (data is Map<String, dynamic>) {
          if (data.containsKey('data')) {
            final dataField = data['data'];
            if (dataField is List) {
              postsList = dataField;
            }
          }
        }

        final validPostMaps = postsList
            .whereType<Map<String, dynamic>>()
            .toList();
        return validPostMaps.map((post) => PostModel.fromJson(post)).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching posts: $e');
      return [];
    }
  }

  Future<(bool, String?, int)> toggleLike(String postId) async {
    try {
      final url = '${Urls.getPost}/$postId/like/toggle';
      final response = await networkClient.postRequest(url: url, body: {});

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData;

        // Handle different response formats
        Map<String, dynamic>? responseData;

        if (data is Map<String, dynamic>) {
          if (data.containsKey('data')) {
            responseData = data['data'] as Map<String, dynamic>;
          } else {
            responseData = data;
          }
        }

        if (responseData != null) {
          final liked = responseData['liked'] as bool? ?? false;
          final likeId = responseData['likeId'] as String?;

          print(
            'Toggle like response: liked=$liked, action=${responseData['action']}',
          );

          // Return the updated like state with likeId and current like count
          // Note: The API might return updated count, but we'll handle it in the widget
          return (liked, likeId, 0);
        }
      }
      return (false, null, 0);
    } catch (e) {
      print('Error toggling like: $e');
      return (false, null, 0);
    }
  }
}
