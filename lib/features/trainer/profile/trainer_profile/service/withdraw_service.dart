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
}
