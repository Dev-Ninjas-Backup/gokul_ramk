import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gokul_ramk/core/common/widgets/end_points.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      EasyLoading.show(status: "Creating account...");

      final body = {
        "fullName": fullName.trim(),
        "email": email.trim(),
        "password": password.trim(),
      };

      final response = await http.post(
        Uri.parse(Urls.signUp),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 201 && decoded["status"] == "success") {
        EasyLoading.showSuccess(decoded["message"] ?? "Signup successful");
      } else {
        EasyLoading.showError(decoded["message"] ?? "Signup failed");
      }

      if (kDebugMode) {
        print("Signup Response: ${response.body}");
      }
    } catch (e) {
      EasyLoading.showError("Error: $e");
      if (kDebugMode) {
        print("Signup Exception: $e");
      }
    } finally {
      EasyLoading.dismiss();
    }
  }
}