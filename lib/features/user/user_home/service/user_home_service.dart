import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/user/user_home/model/user_home_model.dart';

class CategoryService {
  final NetworkClient client;

  CategoryService({required this.client});

  Future<List<CategoryModelWorkOut>> fetchCategories() async {
    const String url = "${Urls.categories}?type=WORKOUT";

    final response = await client.getRequest(url: url);

    if (response.isSuccess &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      final List data = response.responseData!['data']['data'];

      return data.map((json) => CategoryModelWorkOut.fromJson(json)).toList();
    } else {
      throw response.errorMessage ?? "Failed to load categories";
    }
  }
}
