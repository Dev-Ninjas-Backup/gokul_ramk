import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';

import '../model/produt_categories_model.dart';

class ShopService {
  final NetworkClient client;

  ShopService({required this.client});

  Future<List<ProductCategoryModel>> fetchProductCategories() async {
    const String url = Urls.productcategories;

    final response = await client.getRequest(url: url);

    if (response.isSuccess &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      final List data = response.responseData!['data']['data'];

      return data.map((json) => ProductCategoryModel.fromJson(json)).toList();
    } else {
      throw response.errorMessage ?? "Failed to load categories";
    }
  }
}
