// import 'package:gokul_ramk/core/endpoint/end_points.dart';
// import 'package:gokul_ramk/core/services/network_service/network_client.dart';

 import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/user/session/trainers_tab/model/top_trainer_model.dart';

class DiscoverService {
  final NetworkClient client;

  DiscoverService({required this.client});

//   Future<List<FeatureTrainerModel>> fetchTopTrainer() async {
//     const String url = Urls.getTopTrainer;

//     final response = await client.getRequest(url: url);

//     if (response.isSuccess &&
//         (response.statusCode == 200 || response.statusCode == 201)) {
//       final List data = response.responseData!['data']['data'];

//       return data.map((json) => FeatureTrainerModel.fromJson(json)).toList();
//     } else {
//       throw response.errorMessage ?? "Failed to load categories";
//     }
//   }




  Future<List<TopTrainer>> fetchTopTrainer() async {
    const String url = Urls.getTopTrainer;

    final response = await client.getRequest(url: url);

    if (response.isSuccess &&
        (response.statusCode == 200 || response.statusCode == 201)) {
      final List data = response.responseData!['data'];

      return data.map((json) => TopTrainer.fromJson(json)).toList();
    } else {
      throw response.errorMessage ?? "Failed to load categories";
    }
  }
 }
