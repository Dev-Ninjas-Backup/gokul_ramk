import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/user/user_community/community_posts/model/posts_model.dart';

class PostService {
  final NetworkClient client;

  PostService({required this.client});

  Future<List<PostModel>> fetchPost() async {
    const String url = Urls.getPost;

    final response = await client.getRequest(url: url);

    if (response.isSuccess &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      final List data = response.responseData!['data'];

      return data.map((json) => PostModel.fromJson(json)).toList();
    } else {
      throw response.errorMessage ?? "Failed to load categories";
    }
  }

}
