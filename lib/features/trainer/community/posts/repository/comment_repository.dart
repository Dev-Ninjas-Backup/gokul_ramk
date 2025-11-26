import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/trainer/community/posts/model/comment_model.dart';

class CommentRepository {
  final NetworkClient networkClient;

  CommentRepository({required this.networkClient});

  Future<List<CommentModel>> getPostComments({required String postId}) async {
    try {
      final url = Urls.getPostComments(postId);
      final response = await networkClient.getRequest(url: url);

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData;
        print('Raw comment response data: $data');
        final rawList = _extractCommentList(data);
        print('Extracted comment list length: ${rawList.length}');
        final comments = rawList
            .map((json) => CommentModel.fromJson(json))
            .toList();
        print('Parsed comments: ${comments.length}');
        return comments;
      }
    } catch (e) {
      print('Error fetching comments: $e');
    }
    return [];
  }

  Future<CommentModel?> addComment({
    required String postId,
    required String content,
  }) async {
    try {
      final url = Urls.addPostComment(postId);
      final response = await networkClient.patchRequest(
        url: url,
        body: {'content': content},
      );

      if (response.isSuccess && response.responseData != null) {
        final data = response.responseData;
        print('Add comment response: $data');
        if (data is Map<String, dynamic>) {
          final newComment = CommentModel.fromJson(data);
          print('Created new comment with ID: ${newComment.id}');
          return newComment;
        }
      }
    } catch (e) {
      print('Error adding comment: $e');
    }
    return null;
  }

  List<Map<String, dynamic>> _extractCommentList(dynamic responseData) {
    print('_extractCommentList called with: ${responseData.runtimeType}');

    if (responseData is List) {
      print('Response is a List with ${responseData.length} items');
      return responseData.whereType<Map<String, dynamic>>().toList();
    }
    if (responseData is Map<String, dynamic>) {
      print('Response is a Map, checking for data field...');
      final dataField = responseData['data'];
      print('Data field type: ${dataField.runtimeType}');

      if (dataField is List) {
        // Return all items from the data list
        print('Data field is a List with ${dataField.length} items');
        final result = dataField.whereType<Map<String, dynamic>>().toList();
        print('Extracted ${result.length} comment maps from data field');
        return result;
      }
      // If data field is a single map, return it as a list
      if (responseData.containsKey('data') &&
          dataField is Map<String, dynamic>) {
        print('Data field is a single Map');
        return [dataField];
      }
      // If no data field, treat the entire response as a single comment
      print('No data field, treating entire response as single comment');
      return [responseData];
    }
    print('Response is neither List nor Map');
    return [];
  }
}
