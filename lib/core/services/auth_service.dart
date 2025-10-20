import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class AuthServiceController extends GetxController {
  NetworkClient networkClient = NetworkClient(
    onUnAuthorize: () {
      Get.offAllNamed(AppRoute.loginScreen);
    },
  );
  Future<NetworkResponse> signUp({
    required String fullName,
    required Map<String, dynamic> emailOrPhone,
    required String password,
    required String role,
  }) async {
    try {
      EasyLoading.show(status: "Creating account...");

      final Map<String, dynamic> body = {
        "fullname": fullName.trim(),
        "password": password.trim(),
        "role": role.trim().toUpperCase(),
      };
      body.addAll(emailOrPhone);

      final NetworkResponse response = await networkClient.postRequest(
        url: Urls.signUp,
        body: body,
      );

      return response;
    } catch (e) {
      throw Exception("Error: $e");
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<NetworkResponse> login({
    required Map<String, dynamic> emailOrphone,
    required String password,
  }) async {
    try {
      EasyLoading.show(status: "LogIn....");

      final Map<String, dynamic> body = {"password": password};
      body.addAll(emailOrphone);

      return await networkClient.postRequest(url: Urls.logIn, body: body);
    } catch (e) {
      throw Exception("Error :$e");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
