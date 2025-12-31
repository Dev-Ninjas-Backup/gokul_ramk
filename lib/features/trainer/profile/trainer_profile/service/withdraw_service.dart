import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';

class WithdrawService {
  static Future<NetworkResponse> requestWithdraw({
    required String userId,
    required num amount,
  }) async {
    try {
      final client = Get.find<NetworkClient>();
      final body = {'userId': userId, 'amount': amount};
      final res = await client.postRequest(
        url: Urls.requestWithdraw,
        body: body,
      );
      return res;
    } catch (e) {
      print('requestWithdraw error: $e');
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
        statusCode: -1,
      );
    }
  }

  /// Fetch withdraw history for the logged-in user.
  /// Supports optional pagination and status filter.
  static Future<NetworkResponse> getWithdrawHistory({
    int page = 1,
    int limit = 10,
    String? status,
  }) async {
    try {
      final client = Get.find<NetworkClient>();
      final params = <String, String>{
        'page': page.toString(),
        'limit': limit.toString(),
      };
      if (status != null && status.isNotEmpty) params['status'] = status;

      final queryString = params.entries
          .map(
            (e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
          )
          .join('&');

      final url = '${Urls.getWithdrawHistory}?$queryString';
      final res = await client.getRequest(url: url);
      return res;
    } catch (e) {
      print('getWithdrawHistory error: $e');
      return NetworkResponse(
        isSuccess: false,
        errorMessage: e.toString(),
        statusCode: -1,
      );
    }
  }
}
