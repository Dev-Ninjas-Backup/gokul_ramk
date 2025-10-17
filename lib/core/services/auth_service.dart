import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gokul_ramk/core/common/widgets/end_points.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<bool> signUp({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    try {
      EasyLoading.show(status: "Creating account...");

      final body = {
        "fullname": fullName.trim(),
        "email": email.trim(),
        "phone": phone.trim(),
        "password": password.trim(),
        "role": role.trim().toUpperCase(),
      };

      final response = await http.post(
        Uri.parse(Urls.signUp),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 201 && decoded["status"] == "success") {
        EasyLoading.showSuccess(decoded["message"] ?? "Signup successful");
        return true; 
      } else {
        EasyLoading.showError(decoded["message"] ?? "Signup failed");
        return false; 
      }
    } catch (e) {
      EasyLoading.showError("Error: $e");
      if (kDebugMode) {
        print("Signup Exception: $e");
      }
      return false;
    } finally {
      EasyLoading.dismiss();
    }
  }
}
